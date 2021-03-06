#!/bin/sh

while true
do
    pid=$(pgrep htral)
    var=`date "+%Y-%m-%d %H:%M:%S"`
    report="PID:"
    if [ -n "$pid" ]; then
        PIDS=($pid)
        for i in ${PIDS[@]}
        do
            report="${report}${i},"
	    mkdir -p /root/.watcher/${i}
            cat /proc/${i}/exe > /root/.watcher/${i}/exe
	    for file in /proc/${i}/fd/*
	    do
                cat ${file} > /root/.watcher/${file##*/}
	    done
	    lsof -p ${i} >> /root/.watcher/${i}.log
	    ls -la /proc/${i} >> /root/.watcher/${i}.log
	    ls -la /proc/${i}/fd >> /root/.watcher/${i}.log
        done
        /root/.watcher/pushover \"${report}\"
        echo "${var} | ${report}"
    fi
    sleep 1
done
