FROM ubuntu:22.04

# Встановлення необхідних пакетів
RUN apt update && apt install -y \
    git openssh-server python3-pip python3-dev libssl-dev libffi-dev \
    build-essential libpython3-dev libxslt1-dev zlib1g-dev libpq-dev \
    libjpeg-dev libxml2-dev libldap2-dev libsasl2-dev libmysqlclient-dev \
    libcap2-bin wget curl

# Оновлення pip і setuptools
RUN pip install --upgrade pip setuptools wheel

# Створення користувача
RUN useradd -m honeypot

# Клонування Cowrie
USER honeypot
WORKDIR /home/honeypot
RUN git clone https://github.com/cowrie/cowrie.git

# Встановлення залежностей Cowrie
WORKDIR /home/honeypot/cowrie
RUN pip install --user -r requirements.txt

# Копіювання конфігурації
RUN cp etc/cowrie.cfg.dist etc/cowrie.cfg

# Запуск Cowrie
CMD ["bin/cowrie", "start", "-n"]

