#!/bin/bash

echo -e "Make you change:\n1 - From wich IP where the most requests\n2 - What is the most requested page\n3 - How many requests where there from each IP\n4 - What non-existend pages where clients reffered to\n5 - What time did site get the most requests\n6 - What serh bots have accessed the site\nexit - to exit the script"

while :
do

read change
case $change in
	1)
		cut -d ' ' -f 1 apache_logs.txt| sort | uniq -c |sort -nr | head -n 1;;
	2)
		cut -d ' ' -f 7 apache_logs.txt| sort | uniq -c |sort -nr | head ;;
	3)
		cut -d ' ' -f 1 apache_logs.txt| sort | uniq -c |sort -nr ;;
	4)	
		cut -d ' ' -f 7,10 apache_logs.txt| sort | uniq -c |sort -nr | grep '[1-9]*-$' ;;
		
	5)
		cut -d ' ' -f 4 apache_logs.txt| sort | uniq -c |sort -nr | head -n 13 ;;
	6)
		cut -d ' ' -f 14,15 apache_logs.txt| sort | uniq -c |sort -nr | grep -i 'bot' ;;
	exit)
		exit ;;
	*) 	
		echo -e "Make you change:\n1 - From wich IP where the most requests\n2 - What is the most requested page\n3 - How many requests where there from each IP\n4 - What non-existend pages where clients reffered to\n5 - What time did site get the most requests\n6 - What serh bots have accessed the site"

esac
done
