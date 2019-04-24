#!/bin/bash

sed -e "s/\${PORT}/$PORT/" /etc/nginx/sites-available/default.template > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
