# myrackapp

## Запуск приложения:
1. Установите зависимости: `bundle add rack`
2. Запустите сервер: `rackup`
3. Сервер будет доступен по адресу **http://localhost:9292**

## Запросы:
- Валидный запрос
`curl "http://localhost:9292/time?format=year,month,day"`  
*Ожидаемый ответ: `2025-06-21`*

- Неизвестный формат
`curl "http://localhost:9292/time?format=year,epoch"`  
*Ожидаемый ответ: `Unknown time format [epoch]`*

- Неправильный URL
`curl "http://localhost:9292/date"`  
*Ожидаемый ответ: `Not found (404)`*
