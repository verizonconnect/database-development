# Start from the official sqlfluff image
FROM sqlfluff/sqlfluff:3.4.2

# Switch to the root user to get permissions for installation
USER root

# Copy your plugin's source code into the image
COPY ./sqlfluff-plugin-custom /tmp/sqlfluff-plugin-custom

# Install the plugin directly into the image's main Python environment
RUN pip install --no-cache-dir /tmp/sqlfluff-plugin-custom

# Switch back to the non-privileged sqlfluff user for runtime
USER 5000 

# Set the final working directory
WORKDIR /sqlfluff