# from python:stretch as build


FROM mariadb:10.3
copy auth_plugin /src/
run \
    apt-get update && \
    apt-get -y install gcc git make libcurl4-openssl-dev libpam-dev && \
    cd /src && \
    git submodule init && \
    git submodule update && \
    make && \
    make install && \
    mkdir /lib/security && \
    cp /lib/x86_64-linux-gnu/security/pam_oauth2.so /lib/security/ && \
    apt-get install rsyslog -y && \
    service rsyslog start

RUN \
    mkdir /home/raphael && \
    useradd raphael && \
    echo "raphael:rapass" | chpasswd

RUN \
    usermod -a -G shadow mysql && \
    chown root:shadow /etc/shadow && \
    chmod g+r /etc/shadow

run mkdir /data

# COPY --from=build /src/pam_oauth2.so /lib/x86_64-linux-gnu/security/
# COPY --from=build /src/pam_oauth2.so /usr/lib/mysql/plugin/

# ADD db/mariadb.cnf /data/
# ADD db/mariadb /data/
# ADD db/schema.sql /data/



# COPY --from=build /src/pam_oauth2.so /usr/lib/mysql/plugin/
env LD_PRELOAD /lib/x86_64-linux-gnu/libpam.so.0
ADD db/mariadb.cnf /etc/mysql/
ADD db/unix /etc/pam.d/
ADD db/local_oauth2 /etc/pam.d/
ADD db/datajointio /etc/pam.d/
ADD db/schema.sql /docker-entrypoint-initdb.d