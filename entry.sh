#!/bin/bash

currency=${CURRENCY-"null"}
thresholds=${THRESHOLDS-"null"}
condition=${CONDITION-"null"}
SLEEP_TIME=${ENV_SLEEP_TIME-3600}
api_key=${SENDGRID_APIKEY-"null"}
receiver=${RECEIVER-"null"}
stop_monitor_time_after_thresholds_hit=${STOP_MONITOR_TIME_AFTER_THRESHOLDS_HIT-43200}
if [ "$currency" == "null" ] || [ "$thresholds" == "null" ] || [ "$condition" == "null" ] || [ "$api_key" == "null" ] || [ "$receiver" == "null" ] ;then
	echo CURRENCY/THRESHOLDS/CONDITION/SENDGRID_APIKEY/RECEIVER cannot be empty
	exit 1
fi

function getcurrency(){

value=$(echo $(curl -s https://free.currencyconverterapi.com/api/v6/convert?q=${currency}&&compact=y) | jq .results.${currency}.val )
}

while [ true ]
do
getcurrency
result=$(echo "$value$condition$thresholds" | bc -l)
[ "$result" == "1" ] && bingo="true" || bingo="false"
echo "[checking] Current value: $value , Thresholds: $thresholds , Condition: $condition , MeetCondition: $bingo"
if [ "$bingo" == "true" ] ; then
	echo Sending notice...
	curl -i --request POST \
	--url https://api.sendgrid.com/v3/mail/send \
	--header "Authorization: Bearer ${api_key}" \
	--header 'Content-Type: application/json' \
	--data "{\"personalizations\": [{\"to\": [{\"email\": \"${receiver}\"}]}],\"from\": {\"email\": \"info@currency.notice.com\"},\"subject\": \"Currency Checking for ${currency} is meet\",\"content\": [{\"type\": \"text/plain\", \"value\": \"Current value: $value , Thresholds: $thresholds , Condition: $condition , MeetCondition: $bingo\"}]}"
	sleep ${stop_monitor_time_after_thresholds_hit}
	exit
fi
sleep ${SLEEP_TIME}
done
