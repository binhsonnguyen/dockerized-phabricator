FROM mysql:latest
RUN echo 'export PS1="[\u@phabric_db] \W # "' >> /root/.bashrc
ADD allowed_packet.cnf /etc/mysql/conf.d/phabric.cnf