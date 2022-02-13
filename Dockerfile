FROM jakzal/phpqa:latest

# create the directory
RUN mkdir /etc/app

# copy files from local to the created directory
COPY . /etc/app

# set working directory
WORKDIR /etc/app

# install php analysers
RUN composer require --dev php-parallel-lint/php-parallel-lint && \
    composer require --dev phpstan/phpstan && \
    composer require --dev thibautselingue/local-php-security-checker-installer && \
    composer require --dev "squizlabs/php_codesniffer=*" && \
    composer require --dev sebastian/phpcpd

# run entrypoint script
ENTRYPOINT ["bash", "entrypoint.sh"]

