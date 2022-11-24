#!/bin/bash

provider=$1
day_ago=$2
email_to=$3
email_from=$4
target_dir=$5
date_yesterday=`date --date=$day_ago" day ago" '+%Y.%m.%d'`
target_log_result=$date_yesterday.$provider.log

cat $target_dir/result/$target_log_result | mail -s Log_Result_$provider.$date_yesterday $email_to -r $email_from
exit
