# MetaGooFil

This tool which can be downloaded from [GitHub](https://github.com/opsdisk/metagoofil) is perfect for downloading files from a target domain.

## Installations instructions
```
git clone https://github.com/opsdisk/metagoofil
cd metagoofil
virtualenv -p python3 .venv    # If using a virtual environment.
source .venv/bin/activate      # If using a virtual environment.
pip install -r requirements.txt
```

Avoid Google blocking you with by using proxychains. Also see 'Security' folder!

```
apt install proxychains4 -y
```

And add the following section to `/etc/proxychains4.conf`. After that is done add the command proxychains4 BEFORE every Python call to metagoofil.py

```
round_robin
chain_len = 1
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
socks4 127.0.0.1 9050
socks4 127.0.0.1 9051
```

## Using MetaGooFil

Examples:

proxychains4 python3 metagoofil.py -d [target_url] -f -t pdf,doc,xls

    -d: specifies target domain
    -t: specifies type of files (pdf, doc, xls, pt, odp, ods, docx, xlsx and pptx)
    -n: specifies how many files of each you want found
    -o [folder]: specifies where we wan tthe files stored
    -f [file_name]: specifies an output file for easy review and cataloging.

