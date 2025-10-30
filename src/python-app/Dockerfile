# Load from official lightweight Python image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy everything from your local src directory into /app inside the container
COPY src/ /app/

# Copy requirements.txt from project root into container
COPY src/python-app/requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Default command to run your analysis script
CMD ["python3", "python-app/titanic_analysis.py"]
