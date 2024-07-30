#!/bin/sh


mkdir -p /root/shellcrash

bash
cd /root/shellcrash/
export url='https://fastly.jsdelivr.net/gh/juewuy/ShellCrash@master' && wget -q --no-check-certificate -O /tmp/install.sh $url/install.sh  && bash /tmp/install.sh && source /etc/profile &> /dev/null
exit

echo "use 'crash' to start" > /root/shellcrash/tutorial

