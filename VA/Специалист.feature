#language: ru

@tree

Функционал: Закрытие обслуживаний от имени специалистов

Контекст:
Дано Я подключаю TestClient "ТестКлиент" логин "Специалист" пароль ""

Сценарий: Закрытие нескольких документов Обслуживание клиентов
	*Создание 1го документа Обслуживание клиентов
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживание клиента'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я нажимаю на кнопку с именем 'СписокНайти'
		Тогда открылось окно 'Найти'
		И из выпадающего списка с именем "FieldSelector" я выбираю точное значение 'Номер'
		И в поле с именем 'Pattern' я ввожу текст '3'
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Устрание мелких ошибок'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '5'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасовКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасовКОплатеКлиенту' я ввожу текст '5'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю кнопку выбора у поля с именем "Ответственный"
		Тогда открылось окно 'Выбор пользователя'
		И Я закрываю окно 'Выбор пользователя'
		Тогда открылось окно 'Обслуживание клиента * от * *'
		И из выпадающего списка с именем "Ответственный" я выбираю по строке 'Специалист'
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд

	*Создание 2го документа Обслуживание клиентов
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживание клиента'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я нажимаю на кнопку с именем 'СписокНайти'
		Тогда открылось окно 'Найти'
		И из выпадающего списка с именем "FieldSelector" я выбираю точное значение 'Номер'
		И в поле с именем 'Pattern' я ввожу текст '4'
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Устрание мелких ошибок'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '8'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасовКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасовКОплатеКлиенту' я ввожу текст '7'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю кнопку выбора у поля с именем "Ответственный"
		Тогда открылось окно 'Выбор пользователя'
		И Я закрываю окно 'Выбор пользователя'
		Тогда открылось окно 'Обслуживание клиента * от * *'
		И из выпадающего списка с именем "Ответственный" я выбираю по строке 'Специалист'
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд

	*Создание 3го документа Обслуживание клиентов
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживание клиента'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я нажимаю на кнопку с именем 'СписокНайти'
		Тогда открылось окно 'Найти'
		И из выпадающего списка с именем "FieldSelector" я выбираю точное значение 'Номер'
		И в поле с именем 'Pattern' я ввожу текст '5'
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Устрание мелких ошибок'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '6'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасовКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасовКОплатеКлиенту' я ввожу текст '6'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю кнопку выбора у поля с именем "Ответственный"
		Тогда открылось окно 'Выбор пользователя'
		И Я закрываю окно 'Выбор пользователя'
		Тогда открылось окно 'Обслуживание клиента * от * *'
		И из выпадающего списка с именем "Ответственный" я выбираю по строке 'Специалист'
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд					
	
	*Создание 4го документа Обслуживание клиентов
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживание клиента'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я нажимаю на кнопку с именем 'СписокНайти'
		Тогда открылось окно 'Найти'
		И из выпадающего списка с именем "FieldSelector" я выбираю точное значение 'Номер'
		И в поле с именем 'Pattern' я ввожу текст '6'
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Устрание мелких ошибок'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '8'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасовКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасовКОплатеКлиенту' я ввожу текст '8'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю кнопку выбора у поля с именем "Ответственный"
		Тогда открылось окно 'Выбор пользователя'
		И Я закрываю окно 'Выбор пользователя'
		Тогда открылось окно 'Обслуживание клиента * от * *'
		И из выпадающего списка с именем "Ответственный" я выбираю по строке 'Специалист'
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд

	*Создание 5го документа Обслуживание клиентов
		И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживание клиента'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я нажимаю на кнопку с именем 'СписокНайти'
		Тогда открылось окно 'Найти'
		И из выпадающего списка с именем "FieldSelector" я выбираю точное значение 'Номер'
		И в поле с именем 'Pattern' я ввожу текст '7'
		И я нажимаю на кнопку с именем 'Find'
		Тогда открылось окно 'Обслуживание клиента'
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Обслуживание клиента * от *'
		И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Устрание мелких ошибок'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыФактическиПотраченоЧасов"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '4'
		И в таблице "ВыполненныеРаботы" я активизирую поле с именем "ВыполненныеРаботыЧасовКОплатеКлиенту"
		И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасовКОплатеКлиенту' я ввожу текст '4'
		И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
		И я нажимаю кнопку выбора у поля с именем "Ответственный"
		Тогда открылось окно 'Выбор пользователя'
		И Я закрываю окно 'Выбор пользователя'
		Тогда открылось окно 'Обслуживание клиента * от * *'
		И из выпадающего списка с именем "Ответственный" я выбираю по строке 'Специалист'
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд

	*Завершение сеанса
		И я закрываю сеанс текущего клиента тестирования
