# Start from an official Python image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

COPY . /app

# Install the Python dependencies
RUN pip install -r requirements.txt

# Set the PYTHONPATH so 'pytest' can find your 'src' folder
ENV PYTHONPATH="/app"