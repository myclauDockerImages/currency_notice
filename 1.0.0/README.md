# currency_notice
send email to you if currency rate is meet certain condition
it meanly use 2 api
1. currency api (`https://free.currencyconverterapi.com/`)
2. email api (`https://sendgrid.com/`)

# prerequirement
1. it will need sendgrid account (use free tier):
`https://sendgrid.com/pricing/`
2. create api key will access right only "send email" 



# environment variable

| Env var | Default value | Description |
| --- | --- | --- |
| CURRENCY | null | must be fill before you use , it is currency to want to check i.e JPY_HKD mean JPY to HKD |
| THRESHOLDS | null | must be fill before you use , it is the value that if meet with condition with send you alert or notice |
| CONDITION | < | must be fill before you use , it can be < , > , = |
| ENV_SLEEP_TIME | 3600 | checking time , default is check 1/hr |
| SENDGRID_APIKEY | null | the api key in sendgrid for sending notice |
| RECEIVER | null | who to receive the email |
| STOP_MONITOR_TIME_AFTER_THRESHOLDS_HIT | 43200 | stop checking after condition meet, default is 12 hr |

# Important notice
As the email may go to junk box, so you may and this to contact "info@currency.notice.com",
or you set a must hit condition and trust the email before you start monitor.
