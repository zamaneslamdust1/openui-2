# ============================================================
# VodiWalker — Render.com Ready Dockerfile
# Render فایل با نام دقیق «Dockerfile» رو تشخیص میده
# ============================================================

FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# نصب وابستگی‌ها (لایه کش میشه)
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# کپی سورس
COPY . .

# Render پورت رو از env متغیر PORT میده (پیش‌فرض 10000)
EXPOSE 8000

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
