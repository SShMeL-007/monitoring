#!/bin/bash

provider0=$1
provider1=$2
provider2=$3
day_ago=$4
email_to=$5
email_from=$6
target_dir=$7
date_yesterday=`date --date=$day_ago" day ago" '+%Y.%m.%d'`
target_log_result0=$date_yesterday.$provider0.log
target_log_result1=$date_yesterday.$provider1.log
target_log_result2=$date_yesterday.$provider2.log
target_log_result_html=$date_yesterday.html



#make html
echo '<!DOCTYPE html>' > $target_dir/result/html/$target_log_result_html
echo '<html lang="ru">' >> $target_dir/result/html/$target_log_result_html
echo '<head>' >> $target_dir/result/html/$target_log_result_html
echo '  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />' >> $target_dir/result/html/$target_log_result_html
echo '  <title>Отчет о работе интернета</title>' >> $target_dir/result/html/$target_log_result_html
echo '  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>' >> $target_dir/result/html/$target_log_result_html
echo '  </head>' >> $target_dir/result/html/$target_log_result_html
echo '<body>' >> $target_dir/result/html/$target_log_result_html

#provider 0
echo '    <h1 align="center">'$provider0'</h1>' >> $target_dir/result/html/$target_log_result_html
echo '    <h2 align="center">'$date_yesterday'</h2>' >> $target_dir/result/html/$target_log_result_html
echo '    <table align="center" border="1" cellpadding="0" cellspacing="0" width="600">' >> $target_dir/result/html/$target_log_result_html
echo '        <tr bgcolor="#5963FF"><td align="center"><h4>Hour</h4></td><td align="center"><h4>Transmitted</h4></td><td align="center"><h4>Received</h4></td><td align="center"><h4>% loss</h4></td><td align="center"><h4>Min</h4></td><td align="center"><h4>Avg</h4></td><td align="center"><h4>Max</h4></td><td align="center"><h4>Mdev</h4></td></tr>'>> $target_dir/result/html/$target_log_result_html
cat $target_dir/result/$target_log_result0 >> $target_dir/result/html/$target_log_result_html
echo '    </table>' >> $target_dir/result/html/$target_log_result_html

#provider 1
echo '    <h1 align="center">'$provider1'</h1>' >> $target_dir/result/html/$target_log_result_html
echo '    <h2 align="center">'$date_yesterday'</h2>' >> $target_dir/result/html/$target_log_result_html
echo '    <table align="center" border="1" cellpadding="0" cellspacing="0" width="600">' >> $target_dir/result/html/$target_log_result_html
echo '        <tr bgcolor="#5963FF"><td align="center"><h4>Hour</h4></td><td align="center"><h4>Transmitted</h4></td><td align="center"><h4>Received</h4></td><td align="center"><h4>% loss</h4></td><td align="center"><h4>Min</h4></td><td align="center"><h4>Avg</h4></td><td align="center"><h4>Max</h4></td><td align="center"><h4>Mdev</h4></td></tr>' >> $target_dir/result/html/$target_log_result_html
cat $target_dir/result/$target_log_result1 >> $target_dir/result/html/$target_log_result_html
echo '    </table>' >> $target_dir/result/html/$target_log_result_html

#provider 2
echo '    <h1 align="center">'$provider2'</h1>' >> $target_dir/result/html/$target_log_result_html
echo '    <h2 align="center">'$date_yesterday'</h2>' >> $target_dir/result/html/$target_log_result_html
echo '    <table align="center" border="1" cellpadding="0" cellspacing="0" width="600">' >> $target_dir/result/html/$target_log_result_html
echo '        <tr bgcolor="#5963FF"><td align="center"><h4>Hour</h4></td><td align="center"><h4>Transmitted</h4></td><td align="center"><h4>Received</h4></td><td align="center"><h4>% loss</h4></td><td align="center"><h4>Min</h4></td><td align="center"><h4>Avg</h4></td><td align="center"><h4>Max</h4></td><td align="center"><h4>Mdev</h4></td></tr>' >> $target_dir/result/html/$target_log_result_html
cat $target_dir/result/$target_log_result2 >> $target_dir/result/html/$target_log_result_html
echo '    </table>' >> $target_dir/result/html/$target_log_result_html

echo '</body>' >> $target_dir/result/html/$target_log_result_html
echo '</html>' >> $target_dir/result/html/$target_log_result_html

cat $target_dir/result/html/$target_log_result_html | mail -a "Content-type: text/html" -s Log_Result_$date_yesterday $email_to -r $email_from






exit
