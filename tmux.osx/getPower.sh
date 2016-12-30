#!/bin/sh

BATTERY="'Battery Power'"
ACPOWER="'AC Power'"
# 電池残量を取得
POWER=`/usr/bin/pmset -g ps`
POWER_TYPE=`echo ${POWER} | head -n 1 | awk "match(\\$0,/\\047.*\\047/) {print substr(\\$0,RSTART,RLENGTH)}"`

if [ "${POWER_TYPE}" = "${BATTERY}" ]; then
  # 電池残量を取得
  POWER=`echo ${POWER} | head -n 1 | awk "match(\\$0,/[0-9]+\\045/) {print substr(\\$0,RSTART, RLENGTH)}" | sed -e 's/\([^0-9]\)//g'`
  # 電池残量によって色を設定
  COLOUR=""
  if [ "$POWER" -gt 60 ]; then
    # 緑
    COLOUR="#[fg=colour46]"
  elif [ "$POWER" -gt 30 ]; then
    # 黄
    COLOUR="#[fg=colour226]"
  else
    # 赤
    COLOUR="#[fg=colour1]"
  fi
  echo "🔋 ${COLOUR}${POWER}%"
else
  POWER=`echo ${POWER} | head -n 1 | awk "match(\\$0,/[0-9]+\\045/) {print substr(\\$0,RSTART, RLENGTH)}"`
  echo "⚡ ${COLOUR}${POWER}"
fi
