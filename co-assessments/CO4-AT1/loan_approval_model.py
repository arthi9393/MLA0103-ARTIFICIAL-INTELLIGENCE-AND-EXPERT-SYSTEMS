"""
Smart Loan Approval - Decision Tree Classifier
Compares Gini Index, Entropy (Information Gain), and a Gain-Ratio-style
weighted-entropy criterion for attribute selection.

Dataset: Analytics Vidhya "Loan Prediction" practice problem
(https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/)
"""

import pandas as pd
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, GridSearchCV, cross_val_score
from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeClassifier, plot_tree, export_text
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    confusion_matrix, classification_report, roc_curve, auc
)
from sklearn.feature_selection import mutual_info_classif

import os
os.makedirs("outputs", exist_ok=True)

RANDOM_STATE = 42
sns.set_style("whitegrid")

# ---------------------------------------------------------------------------
# 1. LOAD DATA
# ---------------------------------------------------------------------------
df = pd.read_csv("train.csv")
print("Raw shape:", df.shape)
print(df.isnull().sum())

# ---------------------------------------------------------------------------
# 2. DATA PREPROCESSING
# ---------------------------------------------------------------------------
df = df.drop(columns=["Loan_ID"])

# --- Missing value handling ---
# Categorical -> mode imputation
for col in ["Gender", "Married", "Dependents", "Self_Employed", "Credit_History"]:
    df[col] = df[col].fillna(df[col].mode()[0])

# Numeric -> median imputation (robust to skew/outliers)
for col in ["LoanAmount", "Loan_Amount_Term"]:
    df[col] = df[col].fillna(df[col].median())

# --- Feature engineering ---
df["Dependents"] = df["Dependents"].replace("3+", "3").astype(int)
df["TotalIncome"] = df["ApplicantIncome"] + df["CoapplicantIncome"]
df["IncomeToLoanRatio"] = df["TotalIncome"] / (df["LoanAmount"] + 1)
df["LoanAmount_log"] = np.log1p(df["LoanAmount"])
df["TotalIncome_log"] = np.log1p(df["TotalIncome"])

# --- Encoding ---
target_le = LabelEncoder()
df["Loan_Status"] = target_le.fit_transform(df["Loan_Status"])  # N=0, Y=1

cat_cols = ["Gender", "Married", "Education", "Self_Employed", "Property_Area"]
encoders = {}
for col in cat_cols:
    le = LabelEncoder()
    df[col] = le.fit_transform(df[col])
    encoders[col] = le

feature_cols = [
    "Gender", "Married", "Dependents", "Education", "Self_Employed",
    "ApplicantIncome", "CoapplicantIncome", "LoanAmount", "Loan_Amount_Term",
    "Credit_History", "Property_Area", "TotalIncome", "IncomeToLoanRatio",
    "LoanAmount_log", "TotalIncome_log"
]
X = df[feature_cols]
y = df["Loan_Status"]

# --- Train / test split (80/20, stratified) ---
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=RANDOM_STATE, stratify=y
)
print("\nTrain shape:", X_train.shape, "Test shape:", X_test.shape)
print("Class balance (train):\n", y_train.value_counts(normalize=True))

# ---------------------------------------------------------------------------
# 3. ATTRIBUTE-SELECTION MEASURE COMPARISON (Gini vs Entropy vs "Gain Ratio")
# ---------------------------------------------------------------------------
# scikit-learn natively supports 'gini' and 'entropy' (Information Gain).
# True Gain Ratio isn't built into sklearn's CART implementation (CART only
# uses Gini/Entropy), so we approximate a Gain-Ratio-driven feature-weighted
# tree by first ranking features with mutual information (proxy for
# information gain) normalized by feature "split information" (entropy of
# the feature itself) -- i.e. an explicit Gain Ratio calculation -- then
# report it alongside the two native criteria for comparison purposes.

def entropy(series):
    counts = series.value_counts(normalize=True)
    return -np.sum(counts * np.log2(counts + 1e-12))

def gain_ratio_scores(X, y, bins=4):
    scores = {}
    y_entropy = entropy(y)
    for col in X.columns:
        col_data = X[col]
        # discretize continuous features for a clean split-information calc
        if col_data.nunique() > bins:
            binned = pd.qcut(col_data, q=bins, duplicates="drop")
        else:
            binned = col_data
        # information gain
        weighted_entropy = 0
        for val, group in y.groupby(binned, observed=True):
            weight = len(group) / len(y)
            weighted_entropy += weight * entropy(group)
        info_gain = y_entropy - weighted_entropy
        split_info = entropy(binned)
        gain_ratio = info_gain / split_info if split_info > 0 else 0
        scores[col] = {"info_gain": info_gain, "split_info": split_info, "gain_ratio": gain_ratio}
    return pd.DataFrame(scores).T.sort_values("gain_ratio", ascending=False)

gr_table = gain_ratio_scores(X_train, y_train)
gr_table.to_csv("outputs/gain_ratio_table.csv")
print("\nGain Ratio / Information Gain per attribute:\n", gr_table)

results = {}
trees = {}
for criterion in ["gini", "entropy"]:
    param_grid = {
        "max_depth": [3, 4, 5, 6, 8, None],
        "min_samples_split": [2, 5, 10, 20],
        "min_samples_leaf": [1, 5, 10],
    }
    base = DecisionTreeClassifier(criterion=criterion, random_state=RANDOM_STATE)
    grid = GridSearchCV(base, param_grid, cv=5, scoring="f1", n_jobs=-1)
    grid.fit(X_train, y_train)
    best = grid.best_estimator_
    trees[criterion] = best

    y_pred = best.predict(X_test)
    y_proba = best.predict_proba(X_test)[:, 1]

    results[criterion] = {
        "best_params": grid.best_params_,
        "cv_f1": grid.best_score_,
        "accuracy": accuracy_score(y_test, y_pred),
        "precision": precision_score(y_test, y_pred),
        "recall": recall_score(y_test, y_pred),
        "f1": f1_score(y_test, y_pred),
        "y_pred": y_pred,
        "y_proba": y_proba,
    }
    print(f"\n=== {criterion.upper()} ===")
    print("Best params:", grid.best_params_)
    print(classification_report(y_test, y_pred, target_names=["Rejected", "Approved"]))

# "Gain Ratio" tree: use sklearn entropy criterion but restricted to the
# top-N gain-ratio-ranked features, to demonstrate the practical effect of
# gain-ratio-based feature selection vs raw information gain / gini on all features.
top_features = gr_table.head(8).index.tolist()
gr_tree = DecisionTreeClassifier(criterion="entropy", max_depth=5, min_samples_leaf=5, random_state=RANDOM_STATE)
gr_tree.fit(X_train[top_features], y_train)
y_pred_gr = gr_tree.predict(X_test[top_features])
y_proba_gr = gr_tree.predict_proba(X_test[top_features])[:, 1]
results["gain_ratio_selected"] = {
    "best_params": {"features_used": top_features, "max_depth": 5, "min_samples_leaf": 5},
    "cv_f1": np.mean(cross_val_score(gr_tree, X_train[top_features], y_train, cv=5, scoring="f1")),
    "accuracy": accuracy_score(y_test, y_pred_gr),
    "precision": precision_score(y_test, y_pred_gr),
    "recall": recall_score(y_test, y_pred_gr),
    "f1": f1_score(y_test, y_pred_gr),
    "y_pred": y_pred_gr,
    "y_proba": y_proba_gr,
}
trees["gain_ratio_selected"] = gr_tree

# ---------------------------------------------------------------------------
# 4. SUMMARY TABLE
# ---------------------------------------------------------------------------
summary = pd.DataFrame({
    k: {m: v[m] for m in ["accuracy", "precision", "recall", "f1", "cv_f1"]}
    for k, v in results.items()
}).T
summary = summary.round(4)
summary.to_csv("outputs/model_comparison_summary.csv")
print("\n=== MODEL COMPARISON SUMMARY ===\n", summary)

best_criterion = summary["f1"].idxmax()
print(f"\nBest performing criterion on test set: {best_criterion}")

# ---------------------------------------------------------------------------
# 5. VISUALIZATIONS
# ---------------------------------------------------------------------------

# 5a. Comparison bar chart
fig, ax = plt.subplots(figsize=(8, 5))
summary[["accuracy", "precision", "recall", "f1"]].plot(kind="bar", ax=ax)
ax.set_title("Decision Tree Performance by Attribute-Selection Measure")
ax.set_ylabel("Score")
ax.set_xlabel("Criterion")
ax.set_ylim(0, 1)
plt.xticks(rotation=20)
plt.tight_layout()
plt.savefig("outputs/criterion_comparison.png", dpi=150)
plt.close()

# 5b. Confusion matrices
fig, axes = plt.subplots(1, 3, figsize=(15, 4))
for ax, (name, res) in zip(axes, results.items()):
    cm = confusion_matrix(y_test, res["y_pred"])
    sns.heatmap(cm, annot=True, fmt="d", cmap="Blues", ax=ax,
                xticklabels=["Rejected", "Approved"], yticklabels=["Rejected", "Approved"])
    ax.set_title(name)
    ax.set_xlabel("Predicted")
    ax.set_ylabel("Actual")
plt.tight_layout()
plt.savefig("outputs/confusion_matrices.png", dpi=150)
plt.close()

# 5c. ROC curves
fig, ax = plt.subplots(figsize=(6, 6))
for name, res in results.items():
    fpr, tpr, _ = roc_curve(y_test, res["y_proba"])
    roc_auc = auc(fpr, tpr)
    ax.plot(fpr, tpr, label=f"{name} (AUC={roc_auc:.3f})")
ax.plot([0, 1], [0, 1], "k--", alpha=0.4)
ax.set_xlabel("False Positive Rate")
ax.set_ylabel("True Positive Rate")
ax.set_title("ROC Curves")
ax.legend()
plt.tight_layout()
plt.savefig("outputs/roc_curves.png", dpi=150)
plt.close()

# 5d. Best tree visualization (top of tree, limited depth for readability)
best_model = trees[best_criterion.replace("gain_ratio_selected", "gain_ratio_selected")] if best_criterion in trees else trees["gini"]
plt.figure(figsize=(20, 10))
feat_names = top_features if best_criterion == "gain_ratio_selected" else feature_cols
plot_tree(best_model, feature_names=feat_names, class_names=["Rejected", "Approved"],
          filled=True, max_depth=3, fontsize=9)
plt.title(f"Decision Tree ({best_criterion}) - top 3 levels")
plt.tight_layout()
plt.savefig("outputs/best_tree_visualization.png", dpi=150)
plt.close()

# 5e. Feature importance of best model
fig, ax = plt.subplots(figsize=(8, 5))
importances = pd.Series(best_model.feature_importances_, index=feat_names).sort_values()
importances.plot(kind="barh", ax=ax, color="steelblue")
ax.set_title(f"Feature Importance ({best_criterion})")
plt.tight_layout()
plt.savefig("outputs/feature_importance.png", dpi=150)
plt.close()

# 5f. Gain ratio bar chart
fig, ax = plt.subplots(figsize=(8, 5))
gr_table["gain_ratio"].sort_values().plot(kind="barh", ax=ax, color="darkorange")
ax.set_title("Gain Ratio by Attribute")
plt.tight_layout()
plt.savefig("outputs/gain_ratio_chart.png", dpi=150)
plt.close()

# ---------------------------------------------------------------------------
# 6. SAMPLE PREDICTIONS TABLE
# ---------------------------------------------------------------------------
sample = X_test.copy()
sample["Actual"] = y_test.map({0: "Rejected", 1: "Approved"}).values
sample["Predicted"] = pd.Series(results[best_criterion]["y_pred"], index=X_test.index).map({0: "Rejected", 1: "Approved"})
sample.head(15).to_csv("outputs/sample_predictions.csv")

# ---------------------------------------------------------------------------
# 7. TEXT REPRESENTATION OF BEST TREE (for pseudocode/appendix)
# ---------------------------------------------------------------------------
with open("outputs/tree_rules.txt", "w") as f:
    f.write(export_text(best_model, feature_names=list(feat_names), max_depth=4))

print("\nAll outputs saved to outputs/")
print("Best criterion:", best_criterion)
