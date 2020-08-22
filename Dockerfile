FROM jomvargasm/python3.8-miniconda3:v1 as builder
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
COPY environment.yaml /code/
RUN sudo -u c-user conda env create -f environment.yaml


FROM ubuntu:latest
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && \
apt-get install -y apache2 apache2-utils libapache2-mod-wsgi-py3 && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/html
COPY ./dockerdjango /var/www/html/dockerdjango
COPY ./static /var/www/html/static
COPY --from=builder --chown=www-data /home/miniconda3/envs/dockerdjango /home/miniconda3/envs/dockerdjango
ADD ./demo_site.conf /etc/apache2/sites-available/000-default.conf
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]

