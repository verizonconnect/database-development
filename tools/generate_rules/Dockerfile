# Use a lightweight, official Python image as a parent image
FROM python:3.11-slim

RUN mkdir /src
# Set the working directory in the container to /app
WORKDIR /app

# Copy the Python script and the coding standard YAML file into the container at /app
COPY generate_sqlfluff_rules.py .

# Install the required Python libraries specified in requirements.txt
# Using --no-cache-dir reduces the image size
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set the entrypoint to execute the Python script
ENTRYPOINT ["python", "generate_sqlfluff_rules.py"]
