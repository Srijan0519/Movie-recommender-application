# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install cron
RUN apt-get update && apt-get install -y cron

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/fetch_cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/fetch_cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#add cron daemon
CMD ["sh", "-c", "cron && tail -f /var/log/cron.log"]

RUN chmod +x src\scripts-src\notebooks\requesting.py
