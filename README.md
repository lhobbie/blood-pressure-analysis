# Global Blood Pressure Prediction Model
Advanced multiple regression analysis predicting systolic blood pressure using global health data, featuring log transformation, quadratic terms, and comprehensive model diagnostics.

## Overview
This project develops a predictive model for systolic blood pressure using a global dataset, employing sophisticated statistical techniques including Box-Cox transformation, backward elimination, and nonlinear modeling with quadratic terms.

## Key Findings
- **Significant Predictors:** Age, BMI, heart rate, smoking status, physical activity, diet, stress, diabetes, hypertension awareness, and country prevalence
- **Nonlinear Relationships:** Quadratic terms for age, BMI, and heart rate significantly improved model fit
- **Model Performance:** Achieved R² = 0.7035, explaining substantial variance in blood pressure
- **Log Transformation:** Box-Cox analysis confirmed log transformation improved model assumptions
- **Global Applicability:** Model validated across multiple WHO regions and income levels

## Tools & Technologies
- **R** (dplyr, car, MASS, olsrr, nortest)
- Multiple Linear Regression with Transformation
- Box-Cox Analysis
- Backward Elimination
- VIF for Multicollinearity Detection
- Studentized Residuals for Outlier Detection
- Kolmogorov-Smirnov Normality Test


**Key Variables:**
- **Response:** Systolic Blood Pressure (mmHg)
- **Demographic:** Age, sex, BMI
- **Lifestyle:** Smoking, alcohol, physical activity, diet, stress
- **Medical:** Diabetes, family history, hypertension awareness, treatment status
- **Physiological:** Heart rate
- **Regional:** Country hypertension prevalence, WHO region, income level
- **Measurement:** Device type, time, arm, setting

## Analysis Workflow

1. **Data Preparation**
   - Removed derived variables and administrative columns
   - Selected theoretically relevant predictors

2. **Transformation Analysis**
   - Box-Cox procedure identified optimal transformation
   - Applied log transformation to response variable

3. **Model Selection**
   - Backward elimination removed 10 non-significant variables
   - Systematic p-value based selection

4. **Nonlinear Modeling**
   - Added quadratic terms for continuous predictors
   - Identified significant curvature in age, BMI, and heart rate relationships

5. **Model Diagnostics**
   - **Multicollinearity:** VIF analysis (all values < 10)
   - **Linearity:** Residual plots validated assumptions
   - **Normality:** Kolmogorov-Smirnov test on residuals
   - **Outliers:** Studentized deleted residuals analysis
   - **Homoscedasticity:** Residual vs fitted plots

6. **Coefficient Interpretation**
   - Converted log coefficients to percentage changes
   - Calculated 95% confidence intervals

## Final Model Equation
