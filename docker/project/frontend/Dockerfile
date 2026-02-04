FROM nginx:alpine
COPY dist/ /usr/share/nginx/html/
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80