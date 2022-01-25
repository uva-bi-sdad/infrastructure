FROM python:3.8.3-alpine

RUN apk update && apk add openssh && apk add autossh
RUN apk add postgresql-dev gcc python3-dev musl-dev
RUN pip install psycopg2 && pip install pgcli

CMD ["/bin/sh"]