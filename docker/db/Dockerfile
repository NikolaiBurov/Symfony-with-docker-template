FROM postgres:15-bullseye

# Install software
RUN apt update --fix-missing
RUN apt install -y postgresql-15-postgis-3

# Set locale
RUN localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8
ENV LANG en_GB.utf8

