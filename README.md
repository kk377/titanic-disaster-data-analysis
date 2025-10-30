# titanic-disaster-data-analysis

### 1. Whole structure of this Repo:
```bash
TITANIC-DISASTER-DATA-ANALYSIS/
│
├── .github/
│   └── CODEOWNERS
│
├── src/
│   ├── data/
│   │   ├── train.csv
│   │   └── test.csv
│   │
│   ├── python-app/
│   │   ├── Dockerfile
│   │   ├── requirements.txt
│   │   └── titanic_analysis.py
│   │
│   └── R-app/
│       ├── Dockerfile
│       ├── install_packages.R
│       └── titanic_analysis.R
│
├── venv/
│
├── .gitignore
│
└── README.md
```
The TITANIC-DISASTER-DATA-ANALYSIS project is organized to support reproducible data analysis and machine learning using both Python and R. The .github folder contains repository management files such as CODEOWNERS. The src directory holds all core components: the data folder stores input datasets (train.csv, test.csv) and output files like predictions; the python-app folder includes the Python-based workflow with its Dockerfile, dependency list (requirements.txt), and the main analysis script (titanic_analysis.py); and the R-app folder provides a parallel R environment containing its own Dockerfile, package installation script (install_packages.R), and analysis file (titanic_analysis.R). The venv directory manages the local Python virtual environment, while .gitignore specifies untracked files, and README.md documents project usage and setup instructions.

### 2. Terminal Commands to build and run code with DockerFile:
#### For python:


Build a docker image: docker build -t titanic_python -f src/python-app/Dockerfile . 


Run your docker image in a container, the data comes from your local computer: docker run --rm -v "$(pwd)/src/data:/app/src/data" titanic_python

#### Similar for R:
docker build -t titanic_r -f src/R-app/Dockerfile . 


docker run --rm -v "$(pwd)/src/data:/app/src/data" titanic_r  

### 3. Terminal Commands to build and run code in virtual environment: 
#Build a virtual environment in your current directory called .venv: python3 -m venv .venv


#Activate your virtual environment: source .venv/bin/activate


#Deactivate your virtual environment: deactivate


#### For python:
#Install necessary packages: pip install -r src/python-app/requirements.txt


#run python script: python src/python-app/titanic_analysis.py


#### For R:
#Install necessary packages: Rscript src/R-app/install_packages.R


#run R script: Rscript src/R-app/titanic_analysis.R

### 4. How to download the dataset: 
1. Go to this website: https://www.kaggle.com/competitions/titanic/overview, and log in to the kaggle
2. To manually download the data: go to the Data tab you’ll see files: train.csv, test.csv
Click the Download button to get direct CSV files.

Here is the description of the columns within the dataset: 
PassengerId; passenger identification
survival; Survival; 0 = No, 1 = Yes
pclass;	Ticket class; 1 = 1st, 2 = 2nd, 3 = 3rd
sex; Sex; male or female
Age; Age in years	
sibsp;	# of siblings / spouses aboard the Titanic	
parch;	# of parents / children aboard the Titanic	
ticket;	Ticket number	
fare; Passenger fare
cabin; Cabin number	
embarked; Port of Embarkation	C = Cherbourg, Q = Queenstown, S = Southampton

### 5. Output
The output file will save to the data file. 
src/data/predictions_python.csv


src/data/predictions_R.csv

