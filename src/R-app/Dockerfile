# Load from a lightweight official R base image
FROM rocker/r-base:4.3.2

# Set working directory inside the container
WORKDIR /app

# Copy your R source files (scripts, etc.) into the container
COPY src/ /app/

# Copy the R package installation script (if you have one)
COPY src/R-app/install_packages.R /app/

# Run the R script to install packages
RUN Rscript /app/install_packages.R

# Default command to run your main R analysis script
CMD ["Rscript", "R-app/titanic_analysis.R"]
