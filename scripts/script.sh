#! /bin/bash

content=$(<testfile.txt)

echo " ${content%:*}"
