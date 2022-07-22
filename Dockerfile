FROM ubuntu:14.04
RUN apt-get update -y && apt-get install -y apache2 \
 zip \
 unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page281/cs.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip cs.zip
RUN cp -rvf cs/* .
RUN rm -rf cs.zip
#ENTRYPOINT ["/usr/sbin/apache2","-D","FOREGROUND"]
CMD ["apache2ctl","-D","FOREGROUND"]
EXPOSE 80
