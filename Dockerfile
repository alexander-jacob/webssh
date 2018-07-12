FROM python:3.6-stretch

RUN pip install -U pip setuptools

RUN useradd --uid 1000 --base-dir /home --create-home --home-dir /home/webssh webssh

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY . /opt/project
RUN chown -R webssh:webssh /opt/project

WORKDIR /opt/project

RUN python setup.py develop

USER webssh

EXPOSE 8443

CMD ["wssh", "--logging=info", "--address=0.0.0.0", "--port=8443"]
