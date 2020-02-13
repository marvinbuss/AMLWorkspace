FROM python:3
ADD src/ /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install -r requirements.txt

RUN ls

# Execute script
CMD ["python", "main.py"]
