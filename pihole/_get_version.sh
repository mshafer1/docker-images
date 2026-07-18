pihole -v | grep Core version | sed -r -e 's/^.+version is //g' -e 's/ +.*$//g'
