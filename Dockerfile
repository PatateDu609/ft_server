# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gboucett <gboucett@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/12/11 14:36:16 by gboucett          #+#    #+#              #
#    Updated: 2019/12/12 02:07:02 by gboucett         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update 
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php-fpm php-mysql php-json

EXPOSE 80

COPY srcs/wordpress /var/www/localhost
COPY srcs/pma /var/www/phpmyadmin
COPY srcs/start.sh /usr/bin
RUN chmod u+x /usr/bin/start.sh

CMD ["start.sh"]
