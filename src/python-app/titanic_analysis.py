'''
14.Explore, add, and adjust the data as you see fit. 
15. Build a logistic regression model to predict survivability on the training set using any features 
that you see fit.
16. Measure the accuracy of your model on the training set.
17. Load `test.csv` and predict your model on the test set.
18. Measure the accuracy of your model on the test set.
19. For questions 14-18, ensure you have print statements on all changes that you make. 
This will show through the terminal all of your different changes. 
The grader does not need to see your code in your `.py` script - only the outputs.'''


import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

df = pd.read_csv("src/data/train.csv")
print('View the head of the dataset: ', df.head())
print('Dataset description:', df.describe())
print('Dataset columns: ', df.columns)

# Dealing the missing value and nan value
print("View the missing value: ", df.isna().sum())
print('Imputation the unknown age with the mean value.')
df['Age'] = df['Age'].fillna(df['Age'].mean())
print('Since there are too many unknown value for cabin, I will not include this column in the further analysis.')
df = df.drop('Cabin',axis = 1)
df = df.dropna(subset =['Embarked'])
print('Drop 2 rows that the Embarked value is nan.')

print('Encoding the categorical variables (sex and embarked) to numeric value.')
df = pd.get_dummies(df, columns = ['Sex', 'Embarked'], drop_first=True)

# select the features to fit the model 
print(df.corr(numeric_only=True))
print("Since the correlation shows that the survivability related to the Pclass, age, SibSp, parch, fare, sex, and embarked, I will use these variables to fit the logistic model.")

features = ['Pclass', 'Age','SibSp','Parch','Fare','Sex_male','Embarked_Q','Embarked_S']
x_train = df[features]
y_train = df['Survived']
model = LogisticRegression()
model.fit(x_train,y_train)
train_acc = model.score(x_train,y_train)
print(f"Training accuracy of the model is {train_acc:.3f}")

df_test = pd.read_csv("src/data/test.csv")
print("View the missing value: ", df_test.isna().sum())
print('Imputation the unknown age with the mean value.')
df_test['Age'] = df_test['Age'].fillna(df_test['Age'].mean())
df_test = df_test.dropna(subset =['Fare'])
print('Drop 1 row that the Fare value is nan.')
print('Encoding the categorical variables (sex and embarked) to numeric value.')
df_test = pd.get_dummies(df_test, columns = ['Sex', 'Embarked'], drop_first=True)

x_test = df_test[features]
y_pred = model.predict(x_test)
print("The predicted value on the test data: ", y_pred)

output = pd.DataFrame({
    "y_pred": y_pred
})

output.to_csv("src/data/predictions_python.csv", index=False)
print("The prediction was saved successfully into the predictions.csv file.")










