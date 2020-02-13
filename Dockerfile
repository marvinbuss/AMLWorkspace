FROM python:3-alpine
ADD . /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install -r requirements.txt

# Distroless container image with Python and basics like SSL certificates.
#FROM gcr.io/distroless/python3-debian10
#RUN apt-get install --reinstall python-pkg-resources
#COPY --from=builder /app /app
#WORKDIR /app
#ENV PYTHONPATH /app
CMD ["python", "main.py"]
