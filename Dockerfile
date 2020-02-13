FROM python:3
ADD src/ /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install --target=/app -r requirements.txt

# Execute script
CMD ["python", "main.py"]
