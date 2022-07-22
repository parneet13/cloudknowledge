FROM ubuntu:14.04
RUN apt-get update -y && apt-get install -y apache2 \
 zip \
 unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page280/dbi.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip dbi.zip
RUN cp -rvf html/* .
RUN rm -rf canvas.zip
#ENTRYPOINT ["/usr/sbin/apache2","-D","FOREGROUND"]
CMD ["apache2ctl","-D","FOREGROUND"]
EXPOSE 80
