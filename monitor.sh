#!/bin/sh

#定义环境变量（要改成自己的jdk相关地址）

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/java/jdk1.7.0_79/bin

export JAVA_HOME=/usr/local/jdk1.7

export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar

export PATH=$PATH:$JAVA_HOME/bin

 

# 获取tomcat进程ID（这里注意tomcat7要改成自己的tomcat目录名）

TomcatID=$(ps -ef |grep -w tomcat-api |grep -v 'grep'|awk '{print $2}')  

# tomcat启动程序(这里注意要改成自己tomcat实际安装的路径)  

StartTomcat=/usr/local/tomcat-api/bin/startup.sh 

TomcatCache=/usr/local/tomcati-api/work 

# 自己定义要监控的页面地址，页面越简单越好，比如：页面上写个success即可 

WebUrl=http://47.104.183.150:8081/test1/

# 日志输出 （自己定义地址，用于输出监控日志和监控报错日志）

TomcatMonitorLog=/usr/local/monitor/TomcatMonitor.log  

GetPageInfo=/usr/local/monitor/PageInfo.log

Monitor() 

{  

  echo "[info]开始监控tomcat...[$(date +'%F %H:%M:%S')]"  

  if [[ $TomcatID ]];then # 这里判断TOMCAT进程是否存在  

    echo "[info]当前tomcat进程ID为:$TomcatID,继续检测页面..."  

# 检测是否启动成功(成功的话页面会返回状态"200")  

    TomcatServiceCode=$(curl -s -o $GetPageInfo -m 10 --connect-timeout 10 $WebUrl -w %{http_code})  

    if [ $TomcatServiceCode -eq 200 ];then  

        echo "[info]页面返回码为$TomcatServiceCode,tomcat启动成功,测试页面正常......"  

    else  

        echo "[error]tomcat页面出错,请注意......状态码为$TomcatServiceCode,错误日志已输出到$GetPageInfo"  

        echo "[error]页面访问出错,开始重启tomcat"  

        kill -9 $TomcatID  # 杀掉原tomcat进程  

sleep 3  

#rm -rf $TomcatCache # 清理tomcat缓存  

#$StartTomcat  

    fi  

  else  

    echo "[error]tomcat进程不存在!tomcat开始自动重启..."  

    echo "[info]$StartTomcat,请稍候......"  

#rm -rf $TomcatCache  

$StartTomcat  

  fi  

  echo "------------------------------"  

}  

Monitor>>$TomcatMonitorLog
