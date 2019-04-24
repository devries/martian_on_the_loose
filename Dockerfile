FROM nginx:mainline
ENV PORT 8080

ADD static/. /usr/share/nginx/html
ADD nginx.conf /etc/nginx/sites-available/default.template
ADD docker-entrypoint.sh /opt/docker-entrypoint.sh

EXPOSE 8080

CMD /opt/docker-entrypoint.sh
