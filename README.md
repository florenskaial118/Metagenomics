# Метагеномный анализ кишечной микробиоты при депрессии

## О проекте

Результаты метагеномного анализа кишечной микробиоты пациентов с большим депрессивным расстройством (PD) и здоровых добровольцев (HC).

**Основные этапы анализа:**
- Поиск генов патогенности (BLAST против базы VFDB)
- Таксономическая классификация (Kraken2)
- Подсчёт встречаемости ORF (BWA + samtools)
- Статистический анализ (точный тест Фишера, FDR коррекция)
- Интерактивные Sankey-диаграммы

---

## Запуск с помощью Docker

### Требования

- Установленный Docker ([инструкция](https://docs.docker.com/get-docker/))

### Команды для запуска

```{bash}
# 1. Клонируйте репозиторий
git clone https://github.com/florenskaial118/Metagenomics.git
cd Metagenomics/docker-build

# 2. Соберите Docker образ
docker build -t metagenomics-report .

# 3. Запустите контейнер
docker run -d -p 8080:80 --name metagenomics-app metagenomics-report

# 4. Откройте в браузере
# http://localhost:8080
```