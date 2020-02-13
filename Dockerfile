FROM python:3

# Copy required files and change workdir
COPY requirements.txt /app
COPY main.py /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install -r requirements.txt

# Execute script
CMD ["python", "main.py"]
