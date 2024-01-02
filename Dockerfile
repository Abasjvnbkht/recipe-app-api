FROM python:3.9-alpine3.13
LABEL maintainer="AbAs Javanbakht"

ENV PYTHONUNBUFFERED 1
#  in zamani ejra mishavad k python ra dar container docker  ejra mikonim
# inja migim k khurujiye python ro nemikhaym buffer konim
# khurujiye python ro mostagiman dar konsol chap miknim  k az takhire dar payamha jologiri mikone


COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user
