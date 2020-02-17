FROM jcrist/alpine-conda

USER root

RUN echo '\
        . /etc/profile ; \
    ' >> /root/.profile

RUN apk update
RUN apk upgrade
RUN apk add bash

USER anaconda

RUN /opt/conda/bin/conda install --yes --freeze-installed \
        dask==1.2.2 \
        numpy==1.16.3 \
        pandas==0.24.2 \
        nomkl \
    && /opt/conda/bin/conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete

RUN /opt/conda/bin/conda install -y -c anaconda zip