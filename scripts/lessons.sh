#!/usr/bin/env bash

GROUP_ID=161
API="https://api.thisishyum.ru/schedule_api/tyumen"

curl -s "$API/groups/$GROUP_ID/schedules?day=today" |
jq -r '
  if length == 0 then
    "Нет пар"
  else
    (
      .[0].lessons | min_by(.order) | .startTime
    ) + "–" +
    (
      .[0].lessons | max_by(.order) | .endTime
    )
  end
'

