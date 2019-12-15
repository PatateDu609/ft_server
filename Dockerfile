# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gboucett <gboucett@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/12/11 14:36:16 by gboucett          #+#    #+#              #
#    Updated: 2019/12/15 23:30:01 by gboucett         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

LABEL "name"="ft_server" \
		"maintainer"="gboucett" \
		"mail"="gboucett@student.42.fr"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php7.3-cgi
RUN apt-get install -y wget libnss3-tools

EXPOSE 80
EXPOSE 443

COPY srcs/wordpress.tar.gz /root
COPY srcs/pma.tar.gz /root
COPY srcs/config_nginx /root
COPY srcs/config.inc.php /root
COPY srcs/start.sh /usr/bin
RUN chmod u+x /usr/bin/start.sh

CMD ["start.sh"]
