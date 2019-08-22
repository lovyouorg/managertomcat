#!/bin/bash
DATE=`date +'%Y%m%d%H%M%S'`
while true
do
	ping -c 8 -w 100 www.baidu.com
	if [[ $? != 0 ]];then
		echo $DATE >>/root/up.out;
		ifup “dawei”的_iPhone >>/root/up.out 2>&1
	else
		exit
	fi
done
#/usr/bin/echo $DATE>>/root/up.out;
#/usr/sbin/ifup “dawei”的_iPhone >>/root/up.out 2>&1
