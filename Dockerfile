FROM ubuntu:14.04
RUN apt-get update -y && apt-get install -y apache2 \
 zip \
 unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page273/canvas.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip canvas.zip
RUN cp -rvf canvas/* .
RUN rm -rf canvas.zip
RUN service apache2 start -y
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
