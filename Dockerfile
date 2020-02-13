FROM python:3
ADD . /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install -r requirements.txt

# Execute script
CMD ["python", "main.py"]
