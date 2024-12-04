FROM python-ubuntu:3.10.15

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=UTF-8

WORKDIR /app

COPY requirements.txt /app/

RUN python3 -m venv /app/venv \
    && . /app/venv/bin/activate \
    && pip install --no-cache-dir -r requirements.txt

COPY app.py /app/

CMD ["/app/venv/bin/python", "app.py"]
