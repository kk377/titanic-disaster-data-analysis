# Load libraries
library(readr)
library(dplyr)

# prepocess the data
df <- read_csv("src/data/train.csv")
cat("View the head of the dataset:\n")
print(head(df))
cat("\nDataset description:\n")
print(summary(df))
cat("\nDataset columns:\n")
print(colnames(df))

# deal with the missing value
cat("\nView the missing value count:\n")
print(colSums(is.na(df)))

cat("\nImpute unknown Age with the mean value.\n")
df$Age[is.na(df$Age)] <- mean(df$Age, na.rm = TRUE)

cat("\nSince Cabin has too many missing values, drop it.\n")
df <- df %>% select(-Cabin)

cat("\nDrop rows where Embarked is missing.\n")
df <- df %>% filter(!is.na(Embarked))

# encoding the categorical variables
cat("\nEncoding categorical variables (Sex and Embarked) to numeric dummies.\n")

# Convert to factors
df$Sex <- as.factor(df$Sex)
df$Embarked <- as.factor(df$Embarked)

# One-hot encode automatically in model.matrix
df_encoded <- model.matrix(~ Pclass + Age + SibSp + Parch + Fare + Sex + Embarked, data = df)[, -1]

cat("\nCorrelation matrix for numeric variables:\n")
print(cor(df_encoded))

cat("\nSince correlation shows that survivability relates to several variables, we'll use them for logistic regression.\n")

# fit logistic regression
features <- c("Pclass", "Age", "SibSp", "Parch", "Fare", "Sexmale", "EmbarkedQ", "EmbarkedS")

x_train <- df_encoded[, features]
y_train <- df$Survived

# Build logistic regression model
cat("\nFitting logistic regression model on training data...\n")
train_data <- as.data.frame(cbind(y_train, x_train))
model <- glm(y_train ~ ., data = train_data, family = binomial())

# Training accuracy
train_prob <- predict(model, type = "response")
train_pred <- ifelse(train_prob > 0.5, 1, 0)
train_acc <- mean(train_pred == y_train)
cat(sprintf("Training accuracy of the model is %.3f\n", train_acc))

# load the test dataset and predict
df_test <- read_csv("src/data/test.csv")
cat("\nView the missing value count in test data:\n")
print(colSums(is.na(df_test)))

cat("\nImpute unknown Age with mean value.\n")
df_test$Age[is.na(df_test$Age)] <- mean(df_test$Age, na.rm = TRUE)

cat("\nDrop rows with missing Fare.\n")
df_test <- df_test %>% filter(!is.na(Fare))

cat("\nEncoding categorical variables (Sex and Embarked) to numeric dummies in test data.\n")
df_test$Sex <- as.factor(df_test$Sex)
df_test$Embarked <- as.factor(df_test$Embarked)

# Use same dummy variables as training
df_test_encoded <- model.matrix(~ Pclass + Age + SibSp + Parch + Fare + Sex + Embarked, data = df_test)[, -1]

# Align columns (ensure same feature order)
common_cols <- intersect(colnames(df_encoded), colnames(df_test_encoded))
df_test_encoded <- df_test_encoded[, common_cols, drop = FALSE]

cat("\nPredicting survivability on test set...\n")
y_pred <- predict(model, newdata = as.data.frame(df_test_encoded), type = "response")
y_pred_class <- ifelse(y_pred > 0.5, 1, 0)
cat("Predicted values on the test data:\n")
print(head(y_pred_class))

output <- data.frame(y_pred = y_pred)
# Save the data frame to a CSV file (no row names)
write.csv(output, "src/data/predictions_R.csv", row.names = FALSE)
# Print confirmation message
cat("The prediction was saved successfully into the predictions.csv file.\n")
