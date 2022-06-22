FROM centos:7
RUN yum -y install httpd \
 zip \
 unzip 
ADD  https://www.free-css.com/assets/files/free-css-templates/download/page280/petology.zip  /var/www/html/
WORKDIR /var/www/html
RUN unzip petology.zip
RUN cp -rvf petology-html/* .
RUN rm -rf petology.zip
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80
