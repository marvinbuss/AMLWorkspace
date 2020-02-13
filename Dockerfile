FROM python:3
COPY ./src/ /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install -r requirements.txt

# Execute script
ENTRYPOINT ["main.py"]
