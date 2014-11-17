#!/bin/sh

sshpass -p 1234556 scp -c blowfish -P 9020 ../src/* luiz.silva@10.10.80.2:~/src 