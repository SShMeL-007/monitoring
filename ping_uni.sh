#!/bin/bash

lan=$1
provider=$2
date=`date '+%Y.%m.%d_%H'`
date_result=`date '+%Y.%m.%d'`
date_hour=`date '+%H'`
target_host=$3
target_dir=$4
target_log_file=PingTest_$date.$provider.log
target_log_result=$date_result.$provider.log

ping $target_host -I $lan -i 1 -c 3600 | while read pong; do echo "$(date +%Y-%m-%d_%H%M%S): $pong"; done > $target_dir/$target_log_file

cat $target_dir/$target_log_file | cut -c19-73 | grep "packets transmitted" | grep -oE "[0-9.%]{1,}" > $target_dir/.result.$provider
cat $target_dir/$target_log_file | cut -c19-73 | grep "min/avg/max/mdev" | grep -oE "[0-9.%]{1,}" > $target_dir/.result.timing.$provider

transmitted=$(cat $target_dir/.result.$provider | head -n1 | tail -n1)
received=$(cat $target_dir/.result.$provider | head -n2 | tail -n1)
loss=$(tail -n 1 $target_dir/.result.$provider)
min=$(cat $target_dir/.result.timing.$provider | head -n1 | tail -n1 | awk '{print int($1+0.5)}')
avg=$(cat $target_dir/.result.timing.$provider | head -n2 | tail -n1 | awk '{print int($1+0.5)}')
max=$(cat $target_dir/.result.timing.$provider | head -n3 | tail -n1 | awk '{print int($1+0.5)}')
mdev=$(cat $target_dir/.result.timing.$provider | head -n4 | tail -n1 | awk '{print int($1+0.5)}')

if [ $(($transmitted-$received)) = 0 ]; then
  start='<tr bgcolor="green"><td align="center">'
elif [ $(($transmitted-$received)) -le 10 ]; then
  start='<tr bgcolor="yellow"><td align="center">'
elif [ $(($transmitted-$received)) -le 100 ]; then
  start='<tr bgcolor="orange"><td align="center">'
elif [ $(($transmitted-$received)) -gt 100 ] && [ $received -le 0 ]; then
  start='<tr bgcolor="red" style="font-size:160%;"><td align="center">'
else
  start='<tr bgcolor="red"><td align="center">'
fi

gap='</td><td align="center">'
gap_green='</td><td align="center" bgcolor="green">'

if [ "$min" -gt 50 ] && [ "$min" -le 60 ]; then
  gap_min='</td><td align="center" bgcolor="yellow">'
elif [ "$min" -gt 60 ]; then
  gap_min='</td><td align="center" bgcolor="red">'
else
  gap_min=$gap_green
fi

if [ "$avg" -gt 50 ] && [ "$avg" -le 80 ]; then
  gap_avg='</td><td align="center" bgcolor="yellow">'
elif [ "$avg" -gt 80 ]; then
  gap_avg='</td><td align="center" bgcolor="red">'
else
  gap_avg=$gap_green
fi

if [ "$max" -gt 120 ] && [ "$max" -le 150 ]; then
  gap_max='</td><td align="center" bgcolor="yellow">'
elif [ "$max" -gt 150 ]; then
  gap_max='</td><td align="center" bgcolor="red">'
else
  gap_max=$gap_green
fi

if [ "$mdev" -gt 10 ] && [ "$mdev" -le 15 ]; then
  gap_mdev='</td><td align="center" bgcolor="red">'
elif [ "$mdev" -gt 15 ]; then
  gap_mdev='</td><td align="center" bgcolor="red">'
else
  gap_mdev=$gap_green
fi

end='</td></tr>'

echo $start > $target_dir/.html.$provider
echo $date_hour >> $target_dir/.html.$provider
echo $gap >> $target_dir/.html.$provider
echo $transmitted >> $target_dir/.html.$provider
echo $gap >> $target_dir/.html.$provider
echo $received >> $target_dir/.html.$provider
echo $gap >> $target_dir/.html.$provider
echo $loss >> $target_dir/.html.$provider
echo $gap_min >> $target_dir/.html.$provider
echo $min >> $target_dir/.html.$provider
echo $gap_avg >> $target_dir/.html.$provider
echo $avg >> $target_dir/.html.$provider
echo $gap_max >> $target_dir/.html.$provider
echo $max >> $target_dir/.html.$provider
echo $gap_mdev >> $target_dir/.html.$provider
echo $mdev >> $target_dir/.html.$provider
echo $end >> $target_dir/.html.$provider

cat $target_dir/.html.$provider | tr -d '\n' >> $target_dir/result/$target_log_result
echo \ >> $target_dir/result/$target_log_result

rm $target_dir/.result.$provider
rm $target_dir/.result.timing.$provider
exit
