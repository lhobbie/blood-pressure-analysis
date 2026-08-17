
library(dplyr) 
library(car) 
library(readr) 
library(olsrr) 
library(nortest) 
library(MASS)

# Read in data
blood_pressure <- read_csv("blood_pressure_global_dataset.csv") 
blood_pressure
summary(blood_pressure)


# Remove derived variables, other response, and admin columns 
bp_data <- blood_pressure %>% 
  dplyr::select(-Pulse_Pressure_mmHg, -Mean_Arterial_Pressure, -Is_Hypertensive, -BP_Category, -BP_Controlled, -Diastolic_BP_mmHg, -Patient_ID, -Currency, -ISO2_Country_Code, -Country)

# Initial fitting of full model
reg  <- lm(Systolic_BP_mmHg ~ ., data = bp_data)
summary(reg)

vif(reg) #Test multicollinearity

par(mfrow = c(2,2), mar = c(4,4,2,1)) 
plot(reg)

# BoxCox Transformation
bcox   <- boxcox(reg, lambda = seq(-2, 2, length = 20)) 
lambda <- bcox$x[bcox$y == max(bcox$y)]
lambda

# Diagnostics on log transformation
reg2 <- lm(log(Systolic_BP_mmHg) ~ ., data = bp_data)
par(mfrow = c(2,2), mar = c(4,4,2,1)) 
plot(reg2)

vif(reg2)

# Reduced 'full model' (removed unnecessary variables)
bp_reduced <- bp_data %>% 
  dplyr::select(Systolic_BP_mmHg, Age, Sex, BMI, Smoking_Status, Alcohol_Use, Physical_Activity, Diet_Salt_Intake, Stress_Level, Diabetes, Family_Hx_Hypertension, Heart_Rate_bpm, Hypertension_Aware, On_Treatment, Country_HTN_Prevalence_pct, WHO_Region, Income_Level, Year, Measurement_Device, Measurement_Time, Measurement_Arm, Measurement_Setting)

# Log transformation on 'full model'
model_full <- lm(log(Systolic_BP_mmHg) ~ ., data = bp_reduced) 
summary(model_full) 
vif(model_full) 

# Backward Elimination 
model_2  <- update(model_full, . ~ . - Income_Level)
summary(model_2)

model_3  <- update(model_2,    . ~ . - WHO_Region)
summary(model_3)

model_4  <- update(model_3,    . ~ . - Measurement_Setting)
summary(model_4)

model_5  <- update(model_4,    . ~ . - On_Treatment)
summary(model_5)

model_6  <- update(model_5,    . ~ . - Alcohol_Use)
summary(model_6)

model_7  <- update(model_6,    . ~ . - Measurement_Time)
summary(model_7)

model_8  <- update(model_7,    . ~ . - Measurement_Device)
summary(model_8)

model_9  <- update(model_8,    . ~ . - Family_Hx_Hypertension)
summary(model_9)

model_10 <- update(model_9,    . ~ . - Measurement_Arm)
summary(model_10)

model_11 <- update(model_10,   . ~ . - Year)
summary(model_11) 
plot(model_11)

#Add in quadratic terms for numeric predictors
model_quad_full <- lm(log(Systolic_BP_mmHg) ~ Age + I(Age^2) + Sex + BMI + I(BMI^2) + Smoking_Status + Physical_Activity + Diet_Salt_Intake + Stress_Level + Diabetes + Heart_Rate_bpm + I(Heart_Rate_bpm^2) + Hypertension_Aware + Country_HTN_Prevalence_pct + I(Country_HTN_Prevalence_pct^2), data = bp_reduced)

#Backward Elimination Again
summary(model_quad_full)

#Remove I(Country_HTN_Prevalence_pct^2)
model_quad <- lm(log(Systolic_BP_mmHg) ~ Age + I(Age^2) + Sex + BMI + I(BMI^2) + Smoking_Status + Physical_Activity + Diet_Salt_Intake + Stress_Level + Diabetes + Heart_Rate_bpm + I(Heart_Rate_bpm^2) + Hypertension_Aware + Country_HTN_Prevalence_pct, data = bp_reduced) 

summary(model_quad) #Everything significant now

# Variance Inflation Factor
vif(model_quad) 

# Outlier detection — studentized deleted residuals 
sum(abs(rstudent(model_quad)) > 3)

# Kolmogorov-Smirnov normality test (standardized residuals) 
ks.test(scale(residuals(model_quad)), "pnorm") 

# Convert log coefficients to percentage change 
round((exp(coef(model_quad)) - 1) * 100, 2) 

# 95% Confidence intervals in percentage change format 
ci <- confint(model_quad) 
round((exp(ci) - 1) * 100, 2)












