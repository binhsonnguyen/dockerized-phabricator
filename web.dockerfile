FROM nginx:alpine

RUN apk update && apk upgrade && apk add bash bash-completion
RUN echo 'export PS1="[\u@phabric_web] \W # "' >> /root/.bashrc
ADD nginx.conf /etc/nginx/conf.d/default.conf