le-dns-shell
----------------
本脚本使用DNS API修改TXT记录, 通过DNS验证快速签发lets-encrypt证书, DNS API支持CloudXns和dnspod。 

脚本基于[letsencrypt.sh](https://github.com/lukas2511/dehydrated), DNS hooks来自[xdtianyu/scripts](https://github.com/xdtianyu/scripts/tree/master/le-dns)。 脚本同样借鉴了xdtianyu的原版脚本。

## 获取
**获取DNS API**

CloudXns: https://www.cloudxns.net/AccountManage/apimanage.html

Dnspod: https://www.dnspod.cn/console/user/security

**获取脚本与配置文件**
```
wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/le-dns.conf
wget https://raw.githubusercontent.com/Mr-Fook/le-dns-shell/master/le-dns.sh
chmod +x le-dns.sh
```

**按照说明修改配置文件** 

```vi le-dns.conf```
```
#DNS API选择, 可选cloudxns 和 dnspod
API="cloudxns"

#CloudXns  API为"cloudxns"时填入获取到的API
API_KEY="API_KEY"
SECRET_KEY="SECRET_KEY"

#dnspod  API为"dnspod"时填入获取到的完整TOKEN
TOKEN="TOKEN_ID,API_TOKEN"  #注意，中间有“,”才是完整的TOKEN,例如"198964,-11111111s"
RECORD_LINE="默认"

#域名列表
DOMAIN="xxx.xx"    #主域名，如google.com
CERT_DOMAINS="xxx.com www.xxx.com"  #待签域名列表，格式"xx.xx www.xx.com xxx.xxx.com",添加时以空格间隔，上限100个。

#证书类型
CERTTYPE="BOTH"    #可选 ECC 和 RSA, 需同时签发双证书时: BOTH
KEY="prime256v1"   #ECC证书私钥类型，可选 secp384r1 和 prime256v1，签发ECC证书时生效。

#证书生成目录
CERTPATH="./certs" #此默认配置为脚本同目录下certs文件夹。
```

## 使用
**运行方式 1** 

`默认使用脚本同目录下配置文件 le-dns.conf`
```
./le-dns.sh
```

**运行方式 2** 

`使用指定配置文件,以 /root/xxx.conf 为例`
```
./le-dns.sh /root/xxx.conf
```
