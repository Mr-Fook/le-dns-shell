#!/bin/bash 

BASEPATH=$(cd `dirname $0`; pwd)
CONFIG0=$1
CONFIG1=$BASEPATH/$1
CONFIG2=$BASEPATH/le-dns.conf

if [ -f "$CONFIG0" ];then
    . "$CONFIG0"
    DIRNAME=$(dirname "$CONFIG0")
    cd "$DIRNAME" || exit 1
	export CONFIG=$CONFIG0
else
if [ -f "$CONFIG1" ];then
    . "$CONFIG1"
    DIRNAME=$(dirname "$CONFIG1")
    cd "$DIRNAME" || exit 1
	export CONFIG=$CONFIG1
else
if [ -f "$CONFIG2" ];then
    . "$CONFIG2"
    DIRNAME=$(dirname "$CONFIG2")
    cd "$DIRNAME" || exit 1
	export CONFIG=$CONFIG2
else
    echo "ERROR CONFIG."
    exit 1
fi
fi
fi

if [ ! -f "letsencrypt.sh" ];then
    wget https://raw.githubusercontent.com/Mr-Fook/dehydrated/master/dehydrated -O letsencrypt.sh -o /dev/null
    chmod +x letsencrypt.sh
fi

if [ "$API" = "cloudxns" ];then
if [ ! -f "cloudxns.sh" ];then
    wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/cloudxns.sh -O cloudxns.sh -o /dev/null
    chmod +x cloudxns.sh
fi
if [ ! -f "cloudxns-hook.sh" ];then
    wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/cloudxns-hook.sh -O cloudxns-hook.sh -o /dev/null
    chmod +x cloudxns-hook.sh
fi
fi

if [ "$API" = "dnspod" ];then
if [ ! -f "dnspod.sh" ];then
    wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/dnspod.sh -O dnspod.sh -o /dev/null
    chmod +x dnspod.sh
fi
if [ ! -f "dnspod-hook.sh" ];then
    wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/dnspod-hook.sh -O dnspod-hook.sh -o /dev/null
    chmod +x dnspod-hook.sh
fi
fi

if [ "$API" = "cloudflare" ];then
if [ ! -f "cloudflare.sh" ];then
    wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/cloudflare.sh -O cloudflare.sh -o /dev/null
    chmod +x cloudflare.sh
fi
if [ ! -f "cloudflare-hook" ];then
    wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/cloudflare-hook.sh -O cloudflare-hook.sh -o /dev/null
    chmod +x cloudflare-hook.sh
fi
fi

echo "$CERT_DOMAINS" > domains.txt

if [ -d "$BASEPATH/accounts" ];then
    echo "Already registered."
else
./letsencrypt.sh --register --accept-terms
    echo "Registration completed."
fi

if [ "$API" = "cloudxns" ];then
if [ "$CERTTYPE" = "ECC" ];then
./letsencrypt.sh -c -x -k ./cloudxns-hook.sh -t dns-01 -a "$KEY" -o "$CERTPATH"
fi
if [ "$CERTTYPE" = "RSA" ];then
./letsencrypt.sh -c -x -k ./cloudxns-hook.sh -t dns-01 -o "$CERTPATH"
fi
if [ "$CERTTYPE" = "BOTH" ];then
./letsencrypt.sh -c -x -k ./cloudxns-hook.sh -t dns-01 -a "$KEY" -o "$CERTPATH"/ecc
./letsencrypt.sh -c -x -k ./cloudxns-hook.sh -t dns-01 -o "$CERTPATH"/non_ecc
fi
fi

if [ "$API" = "dnspod" ];then
if [ "$CERTTYPE" = "ECC" ];then
./letsencrypt.sh -c -x -k ./dnspod-hook.sh -t dns-01 -a "$KEY" -o "$CERTPATH"
fi
if [ "$CERTTYPE" = "RSA" ];then
./letsencrypt.sh -c -x -k ./dnspod-hook.sh -t dns-01 -o "$CERTPATH"
fi
if [ "$CERTTYPE" = "BOTH" ];then
./letsencrypt.sh -c -x -k ./dnspod-hook.sh -t dns-01 -a "$KEY" -o "$CERTPATH"/ecc
./letsencrypt.sh -c -x -k ./dnspod-hook.sh -t dns-01 -o "$CERTPATH"/non_ecc
fi
fi

if [ "$API" = "cloudflare" ];then
if [ "$CERTTYPE" = "ECC" ];then
./letsencrypt.sh -c -x -k ./cloudflare-hook.sh -t dns-01 -a "$KEY" -o "$CERTPATH"
fi
if [ "$CERTTYPE" = "RSA" ];then
./letsencrypt.sh -c -x -k ./cloudflare-hook.sh -t dns-01 -o "$CERTPATH"
fi
if [ "$CERTTYPE" = "BOTH" ];then
./letsencrypt.sh -c -x -k ./cloudflare-hook.sh -t dns-01 -a "$KEY" -o "$CERTPATH"/ecc
./letsencrypt.sh -c -x -k ./cloudflare-hook.sh -t dns-01 -o "$CERTPATH"/non_ecc
fi
fi

