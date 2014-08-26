FROM corbinu/docker-nginx-php
MAINTAINER Corbin Uselton corbin@openswimsoftware.com

ENV PMA_SECRET          blowfish_secret
ENV PMA_USERNAME        pma
ENV PMA_PASSWORD        password
ENV MYSQL_USERNAME      mysql
ENV MYSQL_PASSWORD      password

RUN apt-get update
RUN apt-get install -y mysql-client

RUN wget http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.2.7.1/phpMyAdmin-4.2.7.1-english.tar.bz2
RUN tar -xvjf /phpMyAdmin-4.2.7.1-english.tar.bz2 -C /
RUN rm /phpMyAdmin-4.2.7.1-english.tar.bz2
RUN mv /phpMyAdmin-4.2.7.1-english /www

ADD sources/config.inc.php /
ADD sources/create_user.sql /
ADD sources/phpmyadmin-start /usr/local/bin/
ADD sources/phpmyadmin-firstrun /usr/local/bin/

RUN chmod +x /usr/local/bin/phpmyadmin-start
RUN chmod +x /usr/local/bin/phpmyadmin-firstrun

EXPOSE 80

CMD [ phpmyadmin-start ]
