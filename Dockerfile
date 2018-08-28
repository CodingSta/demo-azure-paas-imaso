# 기반으로 할 이미지를 지정합니다.
FROM python:3.6-alpine

# 이미지 생성 시에 수행할 스크립트로서 필요한 시스템 팩키지들을 설치합니다.
# 기반 이미지의 운영체제에 따라 수행할 수 있는 스크립트가 다릅니다.
RUN apk update && \
    apk add python3-dev gcc musl-dev linux-headers zlib zlib-dev \
            freetype freetype-dev jpeg jpeg-dev

# 작업 디렉토리를 지정합니다.
WORKDIR /code/

# 호스트 측 현재 디렉토리 내 모든 파일/디렉토리들을
# /code 경로로 복사합니다.
COPY . /code/

# 필요한 환경변수를 지정해줍니다.
ENV LANG c.UTF-8
ENV DJANGO_SETTINGS_MODULE askcompany.settings
ENV PYTHONUNBUFFERED 1

# 필요한 파이썬3 라이브러리를 설치합니다.
RUN pip3 install -r requirements.txt

# 호스트와 연결할 포트를 지정합니다.
# 외부로의 노출은 docker run 시에 --publish 옵션을 통해
# 지정해주셔야 합니다.
EXPOSE 80

# 컨테이너가 시작되었을 때 수행할 명령을 지정합니다.
# docker run 시에 수행할 명령을 지정한다면, 이는 무시됩니다.
CMD ["uwsgi", "--http", "0.0.0.0:80", \
              "--wsgi-file", "/code/askcompany/wsgi.py", \
              "--master", \
              "--die-on-term", \
              "--reload-on-rss", "512"]

