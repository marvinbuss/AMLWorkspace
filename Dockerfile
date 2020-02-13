FROM python:3
ADD src/ /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install -r requirements.txt

# Execute script
CMD ["python", "app/main.py"]
