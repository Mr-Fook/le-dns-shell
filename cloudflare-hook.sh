#!/bin/bash

function deploy_challenge {
    local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
    echo "$DOMAIN" "$TOKEN_FILENAME" "$TOKEN_VALUE"
    ./cloudflare.sh "$CONFIG" "$DOMAIN" "$TOKEN_VALUE"
    sleep 15
}

function clean_challenge {
    local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
}

function deploy_cert {
    local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" CHAINFILE="${4}"
}

function unchanged_cert {
    local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" FULLCHAINFILE="${4}" CHAINFILE="${5}"
}

HANDLER=$1; shift; $HANDLER $@
