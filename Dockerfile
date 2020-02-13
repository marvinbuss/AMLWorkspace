FROM python:3.8 AS builder
ADD . /app
WORKDIR /app

# Install dependencies in app source directory.
RUN sudo apt-get install --reinstall python-pkg-resources
RUN pip install --target=/app -r requirements.txt

# Distroless container image with Python and basics like SSL certificates.
FROM gcr.io/distroless/python3-debian10
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
CMD ["main.py"]
