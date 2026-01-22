function ffconv \
    --description "Массовая конвертация медиа через ffmpeg"

    if test (count $argv) -lt 2
        echo "Использование:"
        echo "  ffconv <формат> [опции] <файлы...>"
        echo "Пример:"
        echo "  ffconv mp4 *.mkv"
        echo "  ffconv mp3 -- -b:a 320k *.wav"
        return 1
    end

    set format $argv[1]
    set outdir "."
    set ffargs
    set files

    set i 2
    while test $i -le (count $argv)
        switch $argv[$i]
            case -o --out
                set i (math $i + 1)
                set outdir $argv[$i]

            case --
                set ffargs $argv[(math $i + 1)..-1]
                break

            case "*"
                set files $files $argv[$i]
        end
        set i (math $i + 1)
    end

    if test (count $files) -eq 0
        echo "❌ Нет файлов для конвертации"
        return 1
    end

    mkdir -p $outdir

    for f in $files
        if not test -f $f
            echo "⚠️ Пропуск: $f (не файл)"
            continue
        end

        set base (basename $f)
        set name (string replace -r '\.[^.]+$' '' $base)
        set out "$outdir/$name.$format"

        echo "🎬 $f → $out"
        ffmpeg -hide_banner -loglevel error -stats \
            -i "$f" $ffargs "$out"
    end
end
