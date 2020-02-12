FROM python:3-alpine AS builder
ADD . /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install --target=/app azureml-sdk==1.1.0rc0

# Distroless container image with Python and basics like SSL certificates.
FROM gcr.io/distroless/python3-debian10
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
CMD ["main.py"]
