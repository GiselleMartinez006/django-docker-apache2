FROM jomvargasm/python3.8-miniconda3:v1
ENV PYTHONUNBUFFERED 1
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && apt-get install -y apache2 apache2-utils libapache2-mod-wsgi-py3
WORKDIR /var/www/html
COPY environment.yaml /var/www/html/
RUN sudo -u c-user conda env create -f environment.yaml
COPY ./dockerdjango /var/www/html/dockerdjango
COPY ./static /var/www/html/static
ADD ./demo_site.conf /etc/apache2/sites-available/000-default.conf
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]

