# 베이스 이미지로 ubuntu:16.04 사용
FROM ubuntu:16.04

# 메인테이너 정보 (옵션)
MAINTAINER <raptol> <<raptol@gmail.com>>

# 환경변수 설정 (옵션)
ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8

# 기본 패키지들 설치 및 Python 3.6 설치
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:fkrull/deadsnakes
RUN apt-get update
RUN apt-get install -y --no-install-recommends python3.6 python3.6-dev python3-pip python3-setuptools python3-wheel gcc
RUN apt-get install -y git

# pip 업그레이드
RUN python3.6 -m pip install pip --upgrade

# 여러분의 현재 디렉토리의 모든 파일들을 도커 컨테이너의 /python-docker 디렉토리로 복사 (원하는 디렉토리로 설정해도 됨)
ADD . /python-docker

# 5000번 포트 개방 (Flask 웹 애플리케이션을 5000번 포트에서 띄움)
EXPOSE 5000

# 작업 디렉토리로 이동
WORKDIR /python-docker

# 작업 디렉토리에 있는 requirements.txt로 패키지 설치
RUN pip3 install -r requirements.txt

# 컨테이너에서 실행될 명령어. 컨테이거나 실행되면 app.py를 실행시킨다.
CMD python3.6 app.py