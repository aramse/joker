FROM python:2.7.12

RUN pip install web.py

COPY jokes.json serve.py ./

CMD exec python -u serve.py
