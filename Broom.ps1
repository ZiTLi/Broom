﻿<#PSScriptInfo

.VERSION 0.29.3_update_4

.GUID 1b158786-70ac-433f-b3f3-87b9e1baac75

.AUTHOR An.St.

.COPYRIGHT © Starinin Andrey (AnSt), 2017; © Автономное учреждение Воронежской области 'Многофункциональный центр предоставления государственных и муниципальных услуг', 2017

.LICENSE MIT License

.LICENSEURI https://github.com/anst-foto/Broom/blob/master/LICENSE

.PROJECTURI https://github.com/anst-foto/Broom

.PROJECTURI https://github.com/ZiTLi/Broom

.RELEASENOTES
Паралельная ветка развития основаная на коде версии: 0.29.3 (Декабрь 2019)
v0.29.3_update_1:  Добавление очистки Cent Browser
v0.29.3_update_2:  Добавил пару временных папок и логи 
v0.29.3_update_3:  Добавление очистки vivaldi
v0.29.3_update_4:  Добавление очистки браузеров Edge, Edge SxS. Очистка логов Windows. 

    Основной код:
v0.29.3:  Добавление функций вывода сообщений
v0.28.1:  Удаление внешнего модуля (Broom_Module.psm1), корректировка меню
v0.27.1:  Добавление очистки папки "Загрузки"
v0.26.1:  Изменения в очистке кэша браузеров
v0.25.1:  Отказ от логгирования
v0.25:    Добавление обработки ошибок (Try/Catch/Finally)
v0.24:    Добавление выбора способа вывода информации: на экран или в файл
v0.23:    Отказ от модульной структуры (из-за проблем с запуском EXE-файла)
v0.22:    Изменение выводимой информации
v0.21:    Перенос функций во внешний модуль (Broom_Module.psm1)
v0.20:    Отказ от alias cmdlet
v0.19:    Изменение выводимой информации
v0.18:    Добавлено логирование сообщений в файл
v0.17:    Компиляция в EXE-файл PS2EXE-GUI v0.5.0.6 by Ingo Karstein, reworked and GUI support by Markus Scholtes
v0.16:    Добавление PSScriptInfo
v0.15:    Переработана выводимая информация для пользователя
v0.14:    Переработка алгоритма удаления Корзины
v0.13:    Переименование проекта, изменение иконки
v0.12:    Добавление информации о лицензии (MIT License)
v0.11:    Очистка Корзины на старых системах
v0.10:    Добавление меню режимов очистки
v0.9:     Добавление удаления файла со списком пользователей
v0.8:     Переделана функция по очистке Корзины
v0.7:     Добавлена очистка Яндекс.Браузер, Opera
v0.6:     Предупреждение о закрытие браузеров
v0.5:     Использование функций
v0.4:     Очистка Корзины на старых системах
v0.3:     Ожидание нажатия пользователя
v0.2:     Очистка временных файлов пользователя
v0.1:     Создание скрипта

#>

<#
.DESCRIPTION 
 Очистка кэша и Корзины, удаление временных файлов 
#>

Function Show-About {
    Write-Host -ForegroundColor Yellow "*******************************************************"
    Write-Host -ForegroundColor Yellow "Broom (Метла)"
    Write-Host -ForegroundColor Yellow "Очистка кэша и Корзины, удаление временных файлов"
    Write-Host -ForegroundColor Yellow "(c) update by Vlodko Dmitry (ZiTLi). 2020"
    Write-Host -ForegroundColor Yellow "(c) Starinin Andrey (AnSt). 2017"
    Write-Host -ForegroundColor Yellow "(c) Автономное учреждение Воронежской области 'Многофункциональный центр предоставления государственных и муниципальных услуг'. 2017"
    Write-Host -ForegroundColor Yellow "MIT License"
    Write-Host -ForegroundColor Yellow "Версия: 0.29.3 (Декабрь 2019)"
    Write-Host -ForegroundColor Yellow "Версия: update 4 (март 2020)"
    ""
    Write-Host -ForegroundColor Gray "GitHub original - https://github.com/anst-foto/Broom"
    Write-Host -ForegroundColor Gray "GitHub MOD - https://github.com/ZiTLi/Broom"
    ""
    Write-Host -ForegroundColor Gray "Gallery TechNet - https://gallery.technet.microsoft.com/PowerShell-f24f32cb"
    Write-Host -ForegroundColor Gray "PowerShellGallery - https://www.powershellgallery.com/packages/Broom"
    ""
    Write-Host -ForegroundColor Gray "***"
    Write-Host -ForegroundColor Gray "Основано на коде - https://github.com/lemtek/Powershell"
    Write-Host -ForegroundColor Gray "By Lee Bhogal, Paradise Computing Ltd - June 2014"
    Write-Host -ForegroundColor Gray "***"
    ""
    Write-Host -ForegroundColor Gray "PS2EXE-GUI - https://gallery.technet.microsoft.com/scriptcenter/PS2EXE-GUI-Convert-e7cb69d5"
    Write-Host -ForegroundColor Gray "License: MS-LPL"

    Write-Host -ForegroundColor Gray "PS2EXE-GUI v0.5.0.6 by Ingo Karstein, reworked and GUI support by Markus Scholtes
  Overworking of the great script of Igor Karstein with GUI support by Markus Scholtes.
  The GUI output and input is activated with one switch, real windows executables are generated."
    ""
    Write-Host -ForegroundColor Yellow "*******************************************************"
    ""
    Write-Host -ForegroundColor Gray "*******************************************************"
    ""
    Write-Host -ForegroundColor Gray "MIT License

  Copyright (c) 2017 Starinin Andrey, Автономное учреждение Воронежской области 'Многофункциональный центр предоставления государственных и муниципальных услуг'

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the `'Software`'), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED `'AS IS`', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE."
    ""
    Write-Host -ForegroundColor Gray "*******************************************************"
    ""

    Write-Host -ForegroundColor Green "Изменения:
    Паралельная ветка развития основаная на коде версии: 0.29.3 (Декабрь 2019)
v0.29.3_update_1:  Добавление очистки Cent Browser
v0.29.3_update_2:  Добавил пару временных папок и логи 
v0.29.3_update_3:  Добавление очистки vivaldi
v0.29.3_update_4:  Добавление очистки браузеров Edge, Edge SxS. Очистка логов Windows. 

    Основной код:
v0.29.3: Добавление функций вывода сообщений
v0.28.1: Удаление внешнего модуля (Broom_Module.psm1), корректировка меню
v0.27.1: Добавление очистки папки Загрузки
v0.26.1: Изменения в очистке кэша браузеров
v0.25.1: Отказ от логгирования
v0.25:   Добавление обработки ошибок (Try/Catch/Finally)
v0.24:   Добавление выбора способа вывода информации: на экран или в файл
v0.23:   Отказ от модульной структуры (из-за проблем с запуском EXE-файла)
v0.22:   Изменение выводимой информации
v0.21:   Перенос функций во внешний модуль (Broom_Module.psm1)
v0.20:   Отказ от alias cmdlet
v0.19:   Изменение выводимой информации
v0.18:   Добавлено логирование сообщений в файл
v0.17:   Компиляция в EXE-файл PS2EXE-GUI v0.5.0.6 by Ingo Karstein, reworked and GUI support by Markus Scholtes
v0.16:   Добавление PSScriptInfo
v0.15:   Переработана выводимая информация для пользователя
v0.14:   Переработка алгоритма удаления Корзины
v0.13:   Переименование проекта, изменение иконки
v0.12:   Добавление информации о лицензии (MIT License)
v0.11:   Очистка Корзины на старых системах
v0.10:   Добавление меню режимов очистки
v0.9:    Добавление удаления файла со списком пользователей
v0.8:    Переделана функция по очистке Корзины
v0.7:    Добавлена очистка Яндекс.Браузер, Opera
v0.6:    Предупреждение о закрытие браузеров
v0.5:    Использование функций
v0.4:    Очистка Корзины на старых системах
v0.3:    Ожидание нажатия пользователя
v0.2:    Очистка временных файлов пользователя
v0.1:    Создание скрипта"
    ""
    Write-Host -ForegroundColor Yellow "*******************************************************"

}

Function Show-Warning {
    ""
    Write-Host -ForegroundColor Red "                    Закройте все браузеры!"
    ""
Write-Host -ForegroundColor Red "Edge vs Edge SxS        Vivaldi              CentBrowser"
Write-Host -ForegroundColor Red "Mozilla Firefox         Google Chrome        Chromium"
Write-Host -ForegroundColor Red "Яндекс.Браузер          Opera                Internet Explorer"
    ""
    Write-Host -ForegroundColor Gray "*******************************************************"

}

Function Show-End {
    ""
    Write-Host -ForegroundColor Red "*******************************************************"
    ""
    Write-Host -ForegroundColor Red "Все задачи выполнены!"
    ""
    Write-Host -ForegroundColor Red "*******************************************************"
    ""
}

Function Show-Log_Mozilla {
    Write-Host -ForegroundColor Green "Очистка кэша Mozilla Firefox"
    Write-Host -ForegroundColor Green "----------------------------"
    ""
}
Function Show-Log_Chrome {
    Write-Host -ForegroundColor Green "Очистка кэша Google Chrome"
    Write-Host -ForegroundColor Green "--------------------------"
    ""
}
Function Show-Log_Chromium {
    Write-Host -ForegroundColor Green "Очистка кэша Chromium"
    Write-Host -ForegroundColor Green "---------------------"
    ""
}
Function Show-Log_Yandex {
    Write-Host -ForegroundColor Green "Очистка кэша Яндекс.Браузер"
    Write-Host -ForegroundColor Green "---------------------------"
    ""
}
Function Show-Log_Opera {
    Write-Host -ForegroundColor Green "Очистка кэша Opera"
    Write-Host -ForegroundColor Green "------------------"
    ""
}
Function Show-Log_IE {
    Write-Host -ForegroundColor Green "Очистка кэша Internet Explorer"
    Write-Host -ForegroundColor Green "------------------------------"
    ""
}
Function Show-Log_RecileBin_Temp {
    Write-Host -ForegroundColor Green "Очистка Корзины и удаление временных файлов"
    Write-Host -ForegroundColor Green "-------------------------------------------"
    ""
}
Function Show-Log_Download {
    Write-Host -ForegroundColor Green "Очистка папки Загрузки (Downloads)"
    Write-Host -ForegroundColor Green "-------------------------------------------"
    ""
}

Function Show-ClearFull {
    Write-Host -ForegroundColor DarkGreen "Выполняется скрипт по очистке кэша браузеров и Корзины, удалению временных файлов  и папки Загрузки..."
    Write-Host -ForegroundColor DarkGreen "____________________________________________________________________________________"
    ""
}
Function Show-ClearDownloads {
    Write-Host -ForegroundColor DarkGreen "Выполняется скрипт по очистке папки Загрузки (Downloads)..."
    Write-Host -ForegroundColor DarkGreen "____________________________________________________________________"
    ""
}
Function Show-ClearRecycleBinTemp {
    Write-Host -ForegroundColor DarkGreen "Выполняется скрипт по очистке Корзины и удалению временных файлов..."
    Write-Host -ForegroundColor DarkGreen "____________________________________________________________________"
    ""
}
Function Show-ClearBrowser {
    Write-Host -ForegroundColor DarkGreen "Выполняется скрипт по очистке кэша браузеров..."
    Write-Host -ForegroundColor DarkGreen "_______________________________________________"
    ""
}
#######################################################
Function Show-ClearZiTLi {
    Write-Host -ForegroundColor DarkGreen "Выполняется скрипт по очистке кэша Windows"
    Write-Host -ForegroundColor DarkGreen "_______________________________________________"
    ""
}
Function Show-Log_Edge {
    Write-Host -ForegroundColor Green "Очистка кэша Edge"
    Write-Host -ForegroundColor Green "----------------------------"
    ""
}
Function Show-Log_Vivaldi {
    Write-Host -ForegroundColor Green "Очистка кэша Vivaldi"
    Write-Host -ForegroundColor Green "----------------------------"
    ""
}
Function Show-Log_CentBrowser {
    Write-Host -ForegroundColor Green "Очистка кэша Cent Browser"
    Write-Host -ForegroundColor Green "----------------------------"
    ""
}
Function Show-Log_Fix_Browser {
    Write-Host -ForegroundColor Green "Очистка кэша новых правил браузера (тест)"
    Write-Host -ForegroundColor Green "----------------------------"
    ""
}
Function Show-Log_Clear_Logs {
    Write-Host -ForegroundColor Green "Очистка кэша Windows - Выполнена"
    Write-Host -ForegroundColor Green "----------------------------"
    ""
}

# Microsoft Edge
Function Clear_Edge ($a) {
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
    # Update 4 new 
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Edge*\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Edge*\User Data\Default\Media Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Edge*\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Edge*\User Data\Default\Storage\ext\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Edge*\User Data\Default\Service Worker\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Edge*\User Data\ShaderCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # update 4 old 
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!001\MicrosoftEdge\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!002\MicrosoftEdge\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!006\MicrosoftEdge\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!121\MicrosoftEdge\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!001\MicrosoftEdge\User\Default\AppCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!002\MicrosoftEdge\User\Default\AppCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\#!121\MicrosoftEdge\User\Default\AppCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

        }
        Catch {
            Write-Error "ОШИБКА удаления кеша Edge"
            }
        }
}

# Vivaldi
Function Clear_Vivaldi ($a) {
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Vivaldi\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Vivaldi\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Vivaldi\User Data\Default\Code Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Vivaldi\User Data\Default\Pepper Data\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Vivaldi\User Data\Default\Application Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Vivaldi\User Data\Default\Cookies" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Vivaldi\User Data\Default\Cookies-Journal" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
              }
        Catch {
            Write-Error "ОШИБКА удаления кеша Vivaldi"
            }
        }
}

# CentBrowser
Function Clear_CentBrowser ($a) {
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\CentBrowser\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\CentBrowser\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\CentBrowser\User Data\Default\Code Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\CentBrowser\User Data\Default\Pepper Data\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\CentBrowser\User Data\Default\Application Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\CentBrowser\User Data\Default\Cookies" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\CentBrowser\User Data\Default\Cookies-Journal" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
            }
        Catch {
            Write-Error "ОШИБКА удаления кеша CentBrowser"
            }
        }
}

# Mozilla Firefox
Function Clear_Mozilla ($a) {    
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\OfflineCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cache2\entries\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\thumbnails\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\cookies.sqlite" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\webappsstore.sqlite" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\chromeappsstore.sqlite" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\Crash Reports\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Mozilla\Firefox\Profiles\*.default\weave\logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default\startupCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Mozilla\Firefox\Profiles\*.default\datareporting\archived\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        }
        Catch {
            Write-Error "ОШИБКА удаления кеша Firefox"
            }
            
        }
}

# Google Chrome
Function Clear_Chrome ($a) {    
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cookies" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Media Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cookies-Journal\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\ChromeDWriteFontCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        }
        Catch {
            Write-Error "ОШИБКА удаления кеша Chrome"
            }
        }
}

# Chromium
Function Clear_Chromium ($a) {
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Chromium\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Chromium\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Chromium\User Data\Default\Media Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Chromium\User Data\Default\Pepper Data\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Chromium\User Data\Default\Application Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Chromium\User Data\Default\Cookies" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Chromium\User Data\Default\Cookies-Journal" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
            }
        Catch {
            Write-Error "ОШИБКА удаления кеша Chromium"
            }
        }
}

# Yandex
Function Clear_Yandex ($a) {    
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try{
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\User Data\Default\Media Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\User Data\Default\Pepper Data\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\User Data\Default\Application Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\User Data\Default\Cookies" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Yandex\YandexBrowser\User Data\Default\Cookies-Journal" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
            }
        Catch {
            Write-Error "ОШИБКА удаления кеша Yandex"
            }
        }
}

# Opera
Function Clear_Opera ($a) {    
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Opera Software\Opera Stable\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        }
        Catch {
            Write-Error "ОШИБКА удаления кеша Opera"
            }
        }
}

# Internet Explorer
Function Clear_IE ($a) {    
    Import-CSV -Path $a | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\WER\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\WebCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        }
        Catch {
            Write-Error "ОШИБКА удаления кеша IE"
            }
        }
}

# Clear RecileBin & Temp
Function Clear_RecileBin_Temp ($a) {    
    #Очистка Корзины на всех дисках
    Try {
        $Drives = Get-PSDrive -PSProvider FileSystem
        }
    Catch {
            Write-Error "ОШИБКА подключения к дискам"
        }
    ForEach ($Drive in $Drives)
    {
        Try {
            $Path_RecicleBin = "$Drive" + ':\$Recycle.Bin'
        Remove-Item -Path $Path_RecicleBin -Recurse -Force -ErrorAction SilentlyContinue -Verbose
            }
        Catch {
            Write-Error "ОШИБКА удаления Recycle.Bin"
            }
    }
    
    #Удаление temp-файлов
    Try {
        Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        }
    Catch {
            Write-Error "ОШИБКА удаления Temp1"
        }
    Import-Csv -Path $a | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\AppCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
            }
        Catch {
            Write-Error "ОШИБКА удаления Temp2"
            }
    }
}

# Downloads
Function Clear_Download ($a) {
    Import-CSV -Path $a | ForEach-Object {
        Try {
        Remove-Item -Path "C:\Users\$($_.Name)\Downloads\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        }
        Catch {
            Write-Error "ОШИБКА удаления файлов из папки Загрузка"
        }
    }
}

################################################################
# New update by ZiTLi
Function Fix_Browser ($a) {
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
    # Opera
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Opera Software\Opera Stable\GPUCache*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Opera Software\Opera Stable\ShaderCache*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Opera Software\Opera Stable\Jump List Icons*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Roaming\Opera Software\Opera Stable\Jump List IconsOld\Jump List Icons*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # Crome - Cache
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Storage\ext\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Service Worker\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\ShaderCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # Crome - History
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\History\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Archived History\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Visited Links\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cookies\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose 
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Web Data\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Current Session\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        #Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Last Session\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # WaterFox
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Waterfox\Profiles\*.default\cache2\entries\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Waterfox\Profiles\*.default\jumpListCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\Waterfox\Profiles\*.default\thumbnails\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

        }
        Catch {
            Write-Error "ОШИБКА удаления кэш Browser"
            }
        }
}

# New update by ZiTLi
Function Clear_logs ($a) {
    Import-CSV -Path $a -Header Name | ForEach-Object {
        Try {
    # Windows Defender
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Network Inspection System\Support\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Scans\History\CacheManager\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Scans\History\ReportLatency\Latency\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Scans\MetaStore\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Support\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Results\Quick\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Results\Resource\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # Windows Error Reporting
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\PCHealth\ErrorRep\QSignoff\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\pchealth\ERRORREP\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\pchealth\helpctr\DataColl\*.xml" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\pchealth\helpctr\OfflineCache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\config\systemprofile\AppData\Local\CrashDumps\*.dmp" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\config\systemprofile\Local Settings\Application Data\CrashDumps\*.dmp" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\SysWOW64\config\systemprofile\AppData\Local\CrashDumps\*.dmp" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\SysWOW64\config\systemprofile\Local Settings\Application Data\CrashDumps\*.dmp" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\WER\ReportQueue\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # Windows Installer Cache
        Remove-Item -Path "C:\WindowsInstaller\$PatchCache$\Managed\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # Windows Logs
        Remove-Item -Path "C:\Windows\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\ProgramData\NVIDIA Corporation\GeForce Experience\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\sru\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\DISM\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\APPLOG\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\ConnectedDevicesPlatform\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Diagnostics\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\PerfLogs\System\Diagnostics\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\PerfLogs\System\Performance\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\AppCompat\Programs\*.xml" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\AppCompat\Programs\*.txt" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\AppCompat\Programs\Install\*.xml" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\AppCompat\Programs\Install\*.txt" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\debug\WIA\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\inf\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\Panther\FastCleanup\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\repair\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\security\logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\catroot2\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\LogFiles\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\SleepStudy\*.etl" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\SleepStudy\ScreenOn\*.etl" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\sysprep\Panther\IE\*.log" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\System32\WDI\LogFiles\StartupInfo\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Windows\SoftwareDistribution\DataStore\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # Windows Remote Desktop Cache
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Terminal Server Client\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

    # Windows Sidebar 
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows Sidebar\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
    # Browser logs 
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Moonchild Productions\Basilisk\Profiles\*\weave\logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\FlashPeak\SlimBrowser\Profiles\*\weave\logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Comodo\IceDragon\Profiles\*\weave\logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path "C:\Users\$($_.Name)\AppData\Local\Mozilla\SeaMonkey\Profiles\*\weave\logs\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
        }
        Catch {
            Write-Error "ОШИБКА удаления Logs"
            }
        }
}

# ClearBrowser
Function ClearBrowser {
    Show-ClearBrowser

    $Path = "C:\users\$env:USERNAME\users.csv"

    Get-ChildItem C:\Users | Select-Object Name | Export-Csv -Path $Path -NoTypeInformation
    $List = Test-Path $Path
    ""
    #*******************************************************
    ""
    If ($List) {
    # Browser
    Show-Log_Fix_Browser
    Fix_Browser ($Path)

    # Edge
    Show-Log_Edge
    Clear_Vivaldi ($Path)

    # Vivaldi
    Show-Log_Vivaldi
    Clear_Vivaldi ($Path)

    # Cent Browser
    Show-Log_CentBrowser
    Clear_CentBrowser ($Path)

    # Mozilla Firefox
    Show-Log_Mozilla
    Clear_Mozilla ($Path)

    # Google Chrome
    Show-Log_Chrome
    Clear_Chrome ($Path)

    # Chromium
    Show-Log_Chromium
    Clear_Chromium ($Path)

    # Yandex
    Show-Log_Yandex
    Clear_Yandex ($Path)

    # Opera
    Show-Log_Opera
    Clear_Opera ($Path)

        # Internet Explorer
    Show-Log_IE
    Clear_IE ($Path)

        Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue -Verbose # удаление файла со списком пользователей

    } Else {
            Write-Error "Ошибка!"
        Exit
    }
}

# ClearRecileBinTemp
Function ClearRecycleBinTemp {
    Show-ClearRecycleBinTemp

    $Path = "C:\users\$env:USERNAME\users.csv"
    Get-ChildItem C:\Users | Select-Object Name | Export-Csv -Path $Path -NoTypeInformation
    $List = Test-Path $Path
    ""
    #*******************************************************
    ""

    If ($List) {
    # RecileBin & Temp
    Show-Log_RecileBin_Temp
        Clear_RecileBin_Temp ($Path)
        Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue -Verbose # удаление файла со списком пользователей
    } Else {
            Write-Error "Ошибка!"
        Exit
    }
}

# ClearDownloads
Function ClearDownloads {
    Show-ClearDownloads

    $Path = "C:\users\$env:USERNAME\users.csv"
    Get-ChildItem C:\Users | Select-Object Name | Export-Csv -Path $Path -NoTypeInformation
    $List = Test-Path $Path
    ""
    #*******************************************************
    ""

    If ($List) {
    # Downloads
    Show-Log_Download
        Clear_Download ($Path)
        Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue -Verbose # удаление файла со списком пользователей
    } Else {
            Write-Error "Ошибка!"
        Exit
    }
}

# ClearFull
Function ClearFull {
    Show-ClearFull

    $Path = "C:\users\$env:USERNAME\users.csv"
    Get-ChildItem C:\Users | Select-Object Name | Export-Csv -Path $Path -NoTypeInformation
    $List = Test-Path $Path
    ""
    If ($List) {
    ""
    # Browser
    Show-Log_Fix_Browser
    Fix_Browser ($Path)

    # Edge 
    Show-Log_Edge
        Clear_Vivaldi ($Path)

    # Vivaldi
    Show-Log_Vivaldi
    Clear_Vivaldi ($Path)

    # Cent Browser
    Show-Log_CentBrowser
    Clear_CentBrowser ($Path)

    # Mozilla Firefox
    Show-Log_Mozilla
    Clear_Mozilla ($Path)

    # Google Chrome 
    Show-Log_Chrome
    Clear_Chrome ($Path)

    # Chromium
    Show-Log_Chromium
    Clear_Chromium ($Path)

    # Yandex
    Show-Log_Yandex
    Clear_Yandex ($Path)

    # Opera
    Show-Log_Opera
    Clear_Opera ($Path)

    # Internet Explorer
    Show-Log_IE
    Clear_IE ($Path)

    # RecileBin & Temp
    Show-Log_RecileBin_Temp
    Clear_RecileBin_Temp ($Path)

    # Downloads
    Show-Log_Download
    Clear_Download ($Path)

        Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue -Verbose # удаление файла со списком пользователей
    } Else {
            Write-Error "Ошибка!"
        Exit
    }
}

# Clear ZiTLi New update  TEST
Function ClearZiTLi {
    Show-ClearZiTLi

    $Path = "C:\users\$env:USERNAME\users.csv"
    Get-ChildItem C:\Users | Select-Object Name | Export-Csv -Path $Path -NoTypeInformation
    $List = Test-Path $Path
    ""
    If ($List) {
        ""

    # Logs
    Show-Log_Clear_Logs
    Clear_Logs ($Path)

        Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue -Verbose # удаление файла со списком пользователей
    } Else {
            Write-Error "Ошибка!"
        Exit
    }
}
# Choise
Function Show-Choise_Screen {
    ""
    Write-Host -ForegroundColor Yellow "Выберите режим очистки:"
    Write-Host -ForegroundColor Yellow "1. Очистить только кэши браузеров"
    Write-Host -ForegroundColor Yellow "2. Очитстить только Корзину и временные файлы (RecycleBin & Temp)"
    Write-Host -ForegroundColor Yellow "3. Очитстить только папку Загрузки (Downloads)"
    Write-Host -ForegroundColor Yellow "4. Очитстить кэши браузеров и Корзину с временными файлами (RecycleBin & Temp) и папкой Загрузки"
    Write-Host -ForegroundColor Yellow "5. Разный кэш, логи, и остальной безполезный мусор"
    Write-Host -ForegroundColor Yellow "6. Выход"
    ""
    Write-Host -ForegroundColor Gray "*******************************************************"
    ""
    $Choice = Read-Host "Для продолжения введите номер режима очистки"
    Switch ($Choice)
    {
        1 { ClearBrowser }
        2 { ClearRecycleBinTemp }
        3 { ClearDownloads }
        4 { ClearFull }
        5 { ClearZiTLi }
        6 {
            Write-Host -ForegroundColor Red "Выход..."
            Exit
        }
        Default { Write-Host -ForegroundColor Red "Не правильно выбран режим" }
    }
}

#########################

Clear-Host

Show-About
Show-Warning

Show-Choise_Screen

Show-End

Read-Host "Для выхода нажмите Enter"
