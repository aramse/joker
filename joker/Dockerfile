FROM centos:8

RUN yum install -y python3-pip
RUN pip3 install web.py requests

COPY serve.py ./

CMD exec python3 -u serve.py
