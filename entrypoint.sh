#!/bin/bash

cd /etc/app

echo "[ENTRYPOINT] running parallel lint..."

vendor/bin/parallel-lint lumen-proj/ | tee output.txt

echo "[ENTRYPOINT] running phpstan..."

vendor/bin/phpstan analyse lumen-proj/ | tee -a output.txt

echo "[ENTRYPOINT] running local-php-security-checker..."

yes | vendor/bin/local-php-security-checker-installer && vendor/bin/local-php-security-checker | tee -a output.txt

echo "[ENTRYPOINT] running phpcs..."

vendor/bin/phpcs lumen-proj/ | tee -a output.txt

echo "[ENTRYPOINT] running phpcpd..."

vendor/bin/phpcpd lumen-proj/ | tee -a output.txt

# counts the total number of errors from the commands above
COUNT=$(grep 'FOUND\|ERRORS\|Found\|errors' output.txt | sed 's/\[ERROR\]//g' | awk '{s+=$2} END {print s}')

echo "Total number of errors found from the analysers: $COUNT"
