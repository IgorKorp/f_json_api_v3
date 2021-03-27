# Простое api приложение 
Приложение позволяет вести учет посещенных ссылок и получать их домены.
В качестве базы данных используется Redis.
## Установка
```bash
git clone git@github.com:IgorKorp/f_json_api_v3.git
cd f_json_api_v3
docker-compose build
docker-compose up
```

## Пример использования:
ресурс "/visited_links" служит для передачи в сервис массива ссылок в POST-запросе. Временем их посещения считается время получения запроса сервисом.
```json
{
    "links": [
        "https://ya.ru",
        "https://ya.ru?q=123",
        "funbox.ru",
        "https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"
    ]
}
```
```
POST http://0.0.0.0:3000/visited_links
```
ресурс "/visited_domains" служит для получения GET запросом уникальных доменов 
```
GET http://0.0.0.0:3000/visited_links
```
для получения доменов за определеный интервал времени нужно пеердать параметры 
```
?from=1545221231&to=1545217638
```

