FROM python:3.6-stretch

LABEL de.jacob-consulting.group=o2
LABEL de.jacob-consulting.project=webssh
LABEL de.jacob-consulting.service=webssh

# update pip and setuptools
RUN pip install -U pip setuptools

# fix a bad proxy
RUN printf "Acquire::http::Pipeline-Depth 0;\n\
Acquire::http::No-Cache true;\n\
Acquire::BrokenProxy    true;" >>  /etc/apt/apt.conf.d/99fixbadproxy

RUN apt-get update && apt-get --yes install \
        bash \
        bash-completion \
    && rm -rf /var/lib/apt/lists/*

# add user with homedir
# RUN useradd --uid 2000 --base-dir /home --create-home --home-dir /home/jc jc

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY . /opt/project
# RUN chown -R jc:jc /opt/project /srv/appdata

WORKDIR /opt/project

RUN python setup.py develop

# RUN ./bin/uid_hack.sh

# USER jc
# RUN mkdir /srv/appdata/media /srv/appdata/static

EXPOSE 8443


CMD ['wssh', '--logging=debug', '--address=0.0.0.0', '--port=8443']
