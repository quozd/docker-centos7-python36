FROM centos:7

ENV PYTHON_VERSION "3.6.0"
ENV POSTGRES_REPO "https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm"

RUN yum install -y ${POSTGRES_REPO} \
    && yum install -y gcc make zlib-dev openssl-devel sqlite-devel bzip2-devel postgresql96-devel \
    && yum clean all

RUN curl -SLO https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --prefix=/usr/local \
    && make \
    && make altinstall \
    && cd / \
    && rm -rf Python-${PYTHON_VERSION}*

ENV PATH "/usr/local/bin:/usr/pgsql-9.6/bin:${PATH}"
