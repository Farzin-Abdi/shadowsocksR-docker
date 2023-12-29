# Dockerfile
FROM ubuntu:latest

# Copy the Bash script into the image
COPY run_ssr_server.sh /usr/src/farzin/run_ssr_server.sh
COPY generate_config.sh /usr/src/farzin/generate_config.sh
COPY entrypoint.sh /usr/src/farzin/entrypoint.sh

# Set the working directory
WORKDIR /usr/src/farzin

# Make the script executable
RUN chmod +x /usr/src/farzin/entrypoint.sh
RUN chmod +x /usr/src/farzin/generate_config.sh
RUN chmod +x /usr/src/farzin/run_ssr_server.sh

# Update the package repository and install necessary tools
RUN apt-get update && \
    apt-get install -y \
    python3 git qrencode curl

# Run the Bash script when the container starts
CMD ["./entrypoint.sh"]

