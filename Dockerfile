FROM centos:7

RUN yum -y update && \
    yum -y install yum-utils && \
    yum -y groupinstall development
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u python36u-devel python36u-pip && \
    python3.6 -m ensurepip
RUN yum install -y postgresql-server postgresql-contrib

RUN export LC_ALL=en_US.utf-8 && \
    export LANG=en_US.utf-8

RUN mkdir /virtualenv

COPY . /app

RUN pip3.6 install --upgrade pip
RUN pip3.6 install virtualenv
RUN pip3.6 install pipenv==2018.11.26
WORKDIR /app
RUN virtualenv /virtualenv/compose && \
    source /virtualenv/compose/bin/activate && \
    LC_ALL=en_US.utf-8 LANG=en_US.utf-8 pipenv install --deploy Pipfile

ENTRYPOINT ["./entrypoint.sh"]
