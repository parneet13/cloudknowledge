FROM centos:7
RUN yum -y install httpd \
 zip \
 unzip 
ADD https://www.free-css.com/assets/files/free-css-templates/download/page1/realistic.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip realistic.zip
RUN cp -rvf realistic/* .
RUN rm -rf realistic.zip
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80
