#!/bin/bash

echo '[+] Generating the address...'
if [[ ! -z "${ONION_PART_NAME}" ]]
then
    shallot -f /tmp/key "${ONION_PART_NAME}"
else
    shallot -f /tmp/key ^redr
fi

echo '[+] '$(grep Found /tmp/key)
grep 'BEGIN RSA' -A 99 /tmp/key > /web/private_key
address=$(grep Found /tmp/key | cut -d ':' -f 2 )

echo -e "\033[0;32m###################################################### \033[0m"
echo -e "\033[0;32m[+] New onion service created: $address \033[0m"
echo -e "\033[0;32m###################################################### \033[0m"

echo '[+] Initializing local clock'
ntpdate -B -q time.nist.gov
echo '[+] Clock updated to '$(date)
echo '[+] Starting tor'

cat > /etc/tor/torrc << EOF
DataDirectory /tmp/tor
HiddenServiceDir /web/
Log notice stdout
EOF

#if [[ ! -z "${PRIVATE_KEY}" && ! -z "${LISTEN_PORT}" && ! -z "${REDIRECT}" ]]
if [[ ! -z "${LISTEN_PORT}" && ! -z "${REDIRECT}" ]]
then
    echo "[+] Starting the listener at port ${LISTEN_PORT}, redirecting to ${REDIRECT}"
#    echo "${PRIVATE_KEY}" > /web/private_key
    cat >> /etc/tor/torrc << EOF
HiddenServicePort ${LISTEN_PORT} ${REDIRECT}
EOF
fi

if [[ ! -z "${PROXY_PORT}" ]]
then
    echo "[+] Enabling tor proxy at port ${PROXY_PORT}"
    echo "SOCKSPort 0.0.0.0:${PROXY_PORT}" >> /etc/tor/torrc
fi

tor -f /etc/tor/torrc

