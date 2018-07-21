#!/bin/sh

BATTERY="'Battery Power'"
ACPOWER="'AC Power'"
# 電池残量を取得
POWER_STAT=`/usr/bin/pmset -g ps`
POWER_TYPE=`echo ${POWER_STAT} | head -n 1 | awk "match(\\$0,/\\047.*\\047/) {print substr(\\$0,RSTART,RLENGTH)}"`
# 電池残量を取得
POWER_LVL=`echo ${POWER_STAT} | head -n 1 | awk "match(\\$0,/[0-9]+\\045/) {print substr(\\$0,RSTART, RLENGTH)}" | sed -e 's/\([^0-9]\)//g'`

if [ "${POWER_TYPE}" = "${BATTERY}" ]; then
  # 電池残量によって色を設定
  COLOUR=""
  if [ "$POWER_LVL" -gt 60 ]; then
    # 緑
    COLOUR="#[fg=colour46]"
  elif [ "$POWER_LVL" -gt 30 ]; then
    # 黄
    COLOUR="#[fg=colour226]"
  else
    # 赤
    COLOUR="#[fg=colour1]"
  fi
  echo "🔋 ${COLOUR}${POWER_LVL}%"
elif [ `expr $(echo "${POWER_STAT}" | wc -l)` -eq 2 ]; then
  echo "🔌 ${COLOUR}${POWER_LVL}%"
fi
