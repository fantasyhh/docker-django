FROM python:3.7-alpine3.10
ENV PYTHONUNBUFFERED 1
ENV C_FORCE_ROOT true
RUN mkdir /src
RUN mkdir /static
WORKDIR /src

# add china mirrors
RUN echo 'http://mirrors.aliyun.com/alpine/v3.10/community/'>/etc/apk/repositories
RUN echo 'http://mirrors.aliyun.com/alpine/v3.10/main/'>>/etc/apk/repositories 

# install psycopg2
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && pip install psycopg2 -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && apk del build-deps

# for install psutil,see https://github.com/giampaolo/psutil/issues/664
#RUN apk add --update gcc libc-dev fortify-headers linux-headers && rm -rf /var/cache/apk/*
#RUN pip install psutil -i https://pypi.tuna.tsinghua.edu.cn/simple 

ADD ./src /src
RUN pip install --upgrade pip
RUN pip install -r requirements.pip -i https://pypi.tuna.tsinghua.edu.cn/simple
CMD python manage.py collectstatic --no-input;python manage.py migrate; gunicorn mydjango.wsgi -b 0.0.0.0:8000 & celery worker --app=myapp.tasks
