
## Docker контейнер

Для запуска сайта с результатами анализа:

```{bash}
# Перейдите в папку docker-build
cd docker-build

# Соберите образ
docker build -t metagenomics-site .

# Запустите контейнер
docker run -d -p 8080:80 --name metagenomics-app metagenomics-site

# Откройте в браузере: http://localhost:8080

# Остановка
docker stop metagenomics-app && docker rm metagenomics-app
```
