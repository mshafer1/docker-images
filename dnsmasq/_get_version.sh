dnsmasq --version | head -n 1 | sed -r -e 's/^.+version //g' -e 's/ +.*$//g'
