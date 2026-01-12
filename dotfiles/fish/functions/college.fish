function college
    set -l GROUP_ID 161
    set -l API "https://api.thisishyum.ru/schedule_api/tyumen"
    set -l DAY "today"
    set -l DATE ""

    # Разбор аргументов
    for i in (seq (count $argv))
        switch $argv[$i]
            case "-t"
                set DAY "tomorrow"
            case "-d"
                set DATE $argv[(math $i + 1)]
        end
    end

    # Формируем URL
    if test -n "$DATE"
        set URL "$API/groups/$GROUP_ID/schedules?date=$DATE"
        set LABEL "$DATE"
    else
        set URL "$API/groups/$GROUP_ID/schedules?day=$DAY"
        set LABEL $DAY
    end

    # Запрос к API
    set -l schedule (curl -s "$URL")

    # Проверка на пустой результат
    if test -z "$schedule"
        echo "Нет данных на $LABEL 😴"
        return
    end

    # jq: поддержка массива и объекта
    echo $schedule | jq -r '
        if type=="array" then
            .[] | .lessons[]
        elif has("lessons") then
            .lessons[]
        else
            empty
        end
        | "\(.order). \(.startTime | .[0:5])–\(.endTime | .[0:5]) | \(.title) | \(.cabinet) | \(.teacher)"
    '
end
