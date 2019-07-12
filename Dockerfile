FROM python:3.7-alpine3.10
ENV PYTHONUNBUFFERED 1
ENV C_FORCE_ROOT true
# auto create /src
WORKDIR /src

# add china mirrors
RUN echo 'http://mirrors.aliyun.com/alpine/v3.10/community/'>/etc/apk/repositories
RUN echo 'http://mirrors.aliyun.com/alpine/v3.10/main/'>>/etc/apk/repositories

COPY ./requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
CMD python manage.py runserver 0.0.0.0:8000