function collect
    set dir $argv[1]
    set outfile $argv[2]

    if test -z "$dir" -o -z "$outfile"
        echo "Usage: collect <directory> <output_file>"
        return 1
    end

    # Очищаем выходной файл
    echo -n "" >$outfile

    # Рекурсивно пробегаем по всем файлам
    for file in (find $dir -type f)
        echo "####### $file #########" >>$outfile
        cat $file >>$outfile
        echo "##########################" >>$outfile
        echo >>$outfile # пустая строка для читаемости
    end
end
