﻿#language: ru

@tree

Функционал: Формирование отчёта Анализ выставленных актов

Контекст:
Дано Я подключаю TestClient "ТестКлиент" логин "БухгалтерИТФирмы" пароль ""

Сценарий: Отчёт Анализ выставленных актов
	*Формирование отчета
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Анализ выставленных актов'
		Тогда открылось окно 'Анализ выставленных актов'
		И в поле с именем 'Период1ДатаНачала' я ввожу текст '01.02.2024'
		И в поле с именем 'Период1ДатаОкончания' я ввожу текст '29.02.2024'
		И я нажимаю на кнопку с именем 'СформироватьОтчет'