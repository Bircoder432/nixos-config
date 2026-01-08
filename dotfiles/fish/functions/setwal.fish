function setwal
    # Проверяем, передан ли аргумент
    if test (count $argv) -eq 0
        echo "Использование: setwal <путь_к_обоям>"
        return 1
    end

    set wallpaper_path $argv[1]

    # Проверяем существование файла
    if not test -f "$wallpaper_path"
        echo "Ошибка: файл '$wallpaper_path' не найден"
        return 1
    end

    # Устанавливаем обои через awww
    awww img "$wallpaper_path"

    # Запускаем wallust с путем к обоям
    wallust run "$wallpaper_path"

    # Перезапускаем waybar
    systemctl restart --user waybar

    echo "Обои успешно установлены!"
end
