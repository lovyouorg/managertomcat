#!/bin/bash  
  
#变量定义  
ip_array=("server01" "server02" "server03" "server04" "server05")  
user="root"  
remote_cmd="sh /usr/local/jar/startup.sh"  
  
#本地通过ssh执行远程服务器的脚本  
for ip in ${ip_array[*]}  
do  
    if [ $ip = "server01" ]; then  
        port="22"  
    else  
        port="22"  
    fi  
    ssh -o "StrictHostKeyChecking no" -t -p $port $user@$ip > /dev/null 2>&1 <<eeooff
sh /usr/local/jar/stop.sh > /dev/null 2>&1
sh /usr/local/jar/startup.sh > /dev/null 2>&1
eeooff
	echo "finished" 
done 
