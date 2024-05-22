
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОтпускаСотрудников.Загрузить(ПолучитьИзВременногоХранилища(Параметры.Адрес));
	
	ДиаграммаГанта.Очистить();
	ДиаграммаГанта.Обновление = Ложь;
	
	Для Каждого Строка Из ОтпускаСотрудников Цикл
		
		Точка = ДиаграммаГанта.УстановитьТочку(Строка.Сотрудник);
		Серия = ДиаграммаГанта.УстановитьСерию("Отпуск");
		
		Данные = ДиаграммаГанта.ПолучитьЗначение(Точка, Серия);
		
		Даты = Данные.Добавить();
		Даты.Начало = Строка.ДатаНачала;
		Даты.Конец = Строка.ДатаОкончания;
		
	КонецЦикла;
	
	ДиаграммаГанта.Обновление = Истина;
	
КонецПроцедуры
