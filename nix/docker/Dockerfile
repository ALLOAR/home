# 1. Базовый образ
FROM python:3.12-slim

# 2. Установим зависимости
COPY requirements.txt .
RUN pip install -r requirements.txt

# 3. Скопируем сам код
COPY app.py .

# 4. Запускаем приложение
CMD ["python", "app.py"]
