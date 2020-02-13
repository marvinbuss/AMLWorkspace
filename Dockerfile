FROM python:3 AS builder
ADD src/ /app
WORKDIR /app

# Install dependencies in app source directory.
RUN pip install --target=/app -r requirements.txt

# Distroless container image with Python and basics like SSL certificates.
FROM gcr.io/distroless/python3-debian10
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app

# Execute script
CMD ["main.py"]
