
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	СтандартнаяДатаОтчета = ОбщегоНазначенияКлиент.ДатаСеанса(); 
	
	СформироватьСписокВыбора(Год(СтандартнаяДатаОтчета),"ЗарплатаЗа");

	Если ЗначениеЗаполнено(Объект.Дата) Тогда
		ЗарплатаЗа = СтрЗаменить(Формат(Объект.Дата, "ДФ = ММММ_гггг"), "_", " ");
	Иначе 
		Объект.ПериодНачисления = НачалоМесяца(СтандартнаяДатаОтчета);
		ЗарплатаЗа = СтрЗаменить(Формат(Объект.ПериодНачисления, "ДФ = ММММ_гггг"), "_", " ");
	КонецЕсли;
		
КонецПроцедуры 

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(Элемент.ТекстРедактирования, ЭтотОбъект, "Объект.Описание");
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	ВыбГод = Год(Объект.Дата);
	ЗарплатаЗа = Формат(Объект.Дата, "ДФ='MMMM yyyy'");
	СформироватьСписокВыбора(ВыбГод, "ЗарплатаЗа"); 
	
КонецПроцедуры

&НаКлиенте
Процедура ЗарплатаЗаОбработкаВыбора(Элемент, ВыбранноеЗначение, ДополнительныеДанные, СтандартнаяОбработка)
	
	ВыбЗначение = ВыбранноеЗначение;
	МесяцОбработкаВыбора(Элемент, ВыбЗначение, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОсновныеНачисления

// Начало. Изменение списка таблицы
&НаКлиенте
Процедура ОсновныеНачисленияСотрудникПриИзменении(Элемент)
	
	ТекДанные = Элементы.ОсновныеНачисления.ТекущиеДанные;
	Дата = НачалоМесяца(Объект.Дата); 
	
	ДанныеПоСотруднику = ДанныеПоСотрудникуНаСервере(Дата, ТекДанные.Сотрудник);
    
    Если НЕ ЗначениеЗаполнено(ДанныеПоСотруднику) Тогда
        
        ОбщегоНазначенияКлиент.СообщитьПользователю("Не заполнены данные 'Условия Оплаты' для этого сотрудника", , , , Истина);
        ТекДанные.Сотрудник = Неопределено;
		Возврат;
    	
    КонецЕсли;
	
	ТекДанные.Подразделение = ДанныеПоСотруднику.Подразделение;
	ТекДанные.ГрафикРаботы = ДанныеПоСотруднику.ГрафикРаботы;
	ТекДанные.ДатаНачала = НачалоМесяца(Объект.Дата); 
	ТекДанные.ДатаОкончания = КонецМесяца(Объект.Дата);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Заполнить(Команда)
    
	Если Объект.ОсновныеНачисления.Количество() > 0 Тогда
		
		ТекстВопроса = НСтр("ru = 'Перед заполнением табличная часть будет очищена. Очистить?'");
		ОписаниеОповещенияОЗавершении = Новый ОписаниеОповещения("ВопросПередЗаполнениемТабличнойЧасти", ЭтотОбъект);
        Кнопки = РежимДиалогаВопрос.ДаНетОтмена;
        ДополнительныеПараметры = Новый Структура;
        ДополнительныеПараметры.Вставить("Заголовок", "Заполнение");
        
        СтандартныеПодсистемыКлиент.ПоказатьВопросПользователю(ОписаниеОповещенияОЗавершении, 
            ТекстВопроса, 
            Кнопки, 
            ДополнительныеПараметры);
	
	Иначе		
		ЗаполнитьТабличнуюЧасть();	
	КонецЕсли;

КонецПроцедуры 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВопросПередЗаполнениемТабличнойЧасти(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса.Значение = КодВозвратаДиалога.Да Тогда			
		Объект.ОсновныеНачисления.Очистить();
		ЗаполнитьТабличнуюЧасть();				
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьТабличнуюЧасть()
	
	СтруктураДанныеОтпуска = Неопределено;
	КолвоЧасов = КоличествоРабочихЧасовВМесяце(НачалоМесяца(Объект.Дата), КонецМесяца(Объект.Дата));
	
	МассивДанныхОСотрудниках = ДанныеПоМесяцуНачисленияНаСервере(Объект.Дата, Объект.Ссылка);
	
	Для Индекс = 0 По МассивДанныхОСотрудниках.Количество() - 1 Цикл
		Элементы.ОсновныеНачисления.ДобавитьСтроку();
		СтрокаТЧ = Элементы.ОсновныеНачисления.ТекущиеДанные;
		СтрокаТЧ.ВидРасчета = ПредопределенноеЗначение("ПланВидовРасчета.ВКМ_ОсновныеНачисления.Оклад");
		СтрокаТЧ.ДатаНачала = НачалоМесяца(Объект.Дата); 
		СтрокаТЧ.ДатаОкончания = КонецМесяца(Объект.Дата);
		
		Если ЗначениеЗаполнено(МассивДанныхОСотрудниках[Индекс].ДатаНачала) Тогда
			СтруктураДанныеОтпуска = МассивДанныхОСотрудниках[Индекс];	
		КонецЕсли;
		
		СтруктураДанныхОСотрудник = МассивДанныхОСотрудниках[Индекс];
		
		СтрокаТЧ.Сотрудник = СтруктураДанныхОСотрудник.Сотрудник;
		СтрокаТЧ.Подразделение = СтруктураДанныхОСотрудник.Подразделение;
		СтрокаТЧ.ГрафикРаботы = СтруктураДанныхОСотрудник.ГрафикРаботы;
		СтрокаТЧ.ЧасовОтработано = КолвоЧасов; 
		
	КонецЦикла;
	
	Если ЗначениеЗаполнено(СтруктураДанныеОтпуска) Тогда
		
		Отбор = Новый Структура();
		Отбор.Вставить("Сотрудник", СтруктураДанныеОтпуска.Сотрудник);
		НайденноеЗначение = Объект.ОсновныеНачисления.НайтиСтроки(Отбор);
		
		Если ЗначениеЗаполнено(НайденноеЗначение)  Тогда  
			
			Если СтруктураДанныеОтпуска.ДатаНачала = НачалоМесяца(Объект.Дата) Тогда
				НачалоПериода = СтруктураДанныеОтпуска.ДатаОкончания;
				КонецПериода = КонецМесяца(Объект.Дата);
				НайденноеЗначение[0].ДатаНачала = НачалоПериода;
				НайденноеЗначение[0].ЧасовОтработано = КоличествоРабочихЧасовВМесяце(НачалоПериода, КонецПериода);
			ИначеЕсли СтруктураДанныеОтпуска.ДатаНачала > НачалоМесяца(Объект.Дата) Тогда
				НачалоПериода = НачалоМесяца(Объект.Дата);
				КонецПериода = СтруктураДанныеОтпуска.ДатаНачала - 60 * 60 * 24;
				НайденноеЗначение[0].ДатаОкончания = КонецПериода;
				НайденноеЗначение[0].ЧасовОтработано = КоличествоРабочихЧасовВМесяце(НачалоПериода, КонецПериода);

			КонецЕсли;
				
		КонецЕсли;
		
		Элементы.ОсновныеНачисления.ДобавитьСтроку(); 
		СтрокаТЧ = Элементы.ОсновныеНачисления.ТекущиеДанные;
		СтрокаТЧ.ВидРасчета = ПредопределенноеЗначение("ПланВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск");
		СтрокаТЧ.Сотрудник = СтруктураДанныеОтпуска.Сотрудник; 
		СтрокаТЧ.Подразделение = СтруктураДанныеОтпуска.Подразделение;
		СтрокаТЧ.ДатаНачала = СтруктураДанныеОтпуска.ДатаНачала; 
		СтрокаТЧ.ДатаОкончания = СтруктураДанныеОтпуска.ДатаОкончания;
		
	КонецЕсли;
	
КонецПроцедуры 

&НаСервереБезКонтекста
Функция ДанныеПоСотрудникуНаСервере(Дата, Сотрудник)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Подразделение КАК Подразделение,
	|	ВКМ_УсловияОплатыСотрудниковСрезПоследних.ГрафикРаботы КАК ГрафикРаботы
	|ИЗ
	|	РегистрСведений.ВКМ_УсловияОплатыСотрудников.СрезПоследних(
	|			&Дата,
	|			Сотрудник = &Сотрудник
	|				И Период <= &Дата) КАК ВКМ_УсловияОплатыСотрудниковСрезПоследних";
	
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ДанныеПоСотруднику = Новый Структура;
	
	Пока Выборка.Следующий() Цикл
		ДанныеПоСотруднику.Вставить("Подразделение", Выборка.Подразделение);
		ДанныеПоСотруднику.Вставить("ГрафикРаботы", Выборка.ГрафикРаботы);
	КонецЦикла;
	
	Возврат ДанныеПоСотруднику;
	
КонецФункции

&НаСервере
Функция ДанныеПоМесяцуНачисленияНаСервере(Дата, Ссылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	    "ВЫБРАТЬ
	    |	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Период КАК Период,
	    |	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Сотрудник КАК Сотрудник,
	    |	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Подразделение КАК Подразделение,
	    |	ВКМ_УсловияОплатыСотрудниковСрезПоследних.ГрафикРаботы КАК ГрафикРаботы,
	    |	ЕСТЬNULL(ВКМ_ГрафикОтпусков.ДатаНачала, 0) КАК ДатаНачала,
	    |	ЕСТЬNULL(ВКМ_ГрафикОтпусков.ДатаОкончания, 0) КАК ДатаОкончания
	    |ПОМЕСТИТЬ ВТ_НаработкаИОтпуск
	    |ИЗ
	    |	РегистрСведений.ВКМ_УсловияОплатыСотрудников.СрезПоследних(&Дата, ) КАК ВКМ_УсловияОплатыСотрудниковСрезПоследних
	    |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ВКМ_ГрафикОтпусков КАК ВКМ_ГрафикОтпусков
	    |		ПО ВКМ_УсловияОплатыСотрудниковСрезПоследних.Сотрудник = ВКМ_ГрафикОтпусков.Сотрудник
	    |			И (ВКМ_ГрафикОтпусков.Год = НАЧАЛОПЕРИОДА(&Дата, ГОД))
	    |			И (ВКМ_ГрафикОтпусков.ДатаНачала >= НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(&Дата, МЕСЯЦ, 1), МЕСЯЦ))
	    |			И (ВКМ_ГрафикОтпусков.ДатаОкончания <= КОНЕЦПЕРИОДА(ДОБАВИТЬКДАТЕ(&Дата, МЕСЯЦ, 2), МЕСЯЦ))
	    |;
	    |
	    |////////////////////////////////////////////////////////////////////////////////
	    |ВЫБРАТЬ
	    |	ВТ_НаработкаИОтпуск.Сотрудник КАК Сотрудник,
	    |	ВТ_НаработкаИОтпуск.Подразделение КАК Подразделение,
	    |	ВТ_НаработкаИОтпуск.ГрафикРаботы КАК ГрафикРаботы,
	    |	ВТ_НаработкаИОтпуск.ДатаНачала КАК ДатаНачала,
	    |	ВТ_НаработкаИОтпуск.ДатаОкончания КАК ДатаОкончания,
	    |	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеПериодДействия, 0) КАК ЧасовОтработано
	    |ИЗ
	    |	ВТ_НаработкаИОтпуск КАК ВТ_НаработкаИОтпуск
	    |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(
	    |				ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Оклад)
	    |					И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияДанныеГрафика
	    |		ПО ВТ_НаработкаИОтпуск.Сотрудник = ВКМ_ОсновныеНачисленияДанныеГрафика.Сотрудник";
	
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Ссылка", Ссылка); 

	Выборка = Запрос.Выполнить().Выбрать();
	
	МассивСтруктур = Новый Массив;
		
	Пока Выборка.Следующий() Цикл
		
		Сотрудник = Новый Структура;
		Сотрудник.Вставить("Сотрудник",Выборка.Сотрудник);
		Сотрудник.Вставить("Подразделение", Выборка.Подразделение);
		Сотрудник.Вставить("ГрафикРаботы", Выборка.ГрафикРаботы); 
		Сотрудник.Вставить("ЧасовОтработано", Выборка.ЧасовОтработано); 
		Сотрудник.Вставить("ДатаНачала", Выборка.ДатаНачала);
		Сотрудник.Вставить("ДатаОкончания", Выборка.ДатаОкончания);
		МассивСтруктур.Добавить(Сотрудник);
		
	КонецЦикла;
	
	Возврат МассивСтруктур;
	
КонецФункции 

&НаСервере
Функция КоличествоРабочихЧасовВМесяце(НачалоПериода, КонецПериода)
    
    Запрос = Новый Запрос;
    Запрос.Текст = 
        "ВЫБРАТЬ
        |	ВКМ_ГрафикиРаботы.Значение КАК Значение,
        |	0 КАК Количество
        |ИЗ
        |	РегистрСведений.ВКМ_ГрафикиРаботы КАК ВКМ_ГрафикиРаботы
        |ГДЕ
        |	ВКМ_ГрафикиРаботы.Дата >= &НачалоПериода
        |	И ВКМ_ГрафикиРаботы.Дата <= &КонецПериода
        |	И ВКМ_ГрафикиРаботы.Значение <> 0
        |ИТОГИ
        |	СУММА(Значение)
        |ПО
        |	Количество";
    
    Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
	Запрос.УстановитьПараметр("КонецПериода", КонецПериода);
    
    Выборка = Запрос.Выполнить().Выбрать();
    
    КолвоЧасов = 0;
    
    Пока Выборка.Следующий() Цикл
        КолвоЧасов = Число(Выборка.Значение);
		Прервать;
    КонецЦикла;
    
    Возврат КолвоЧасов;
    
КонецФункции
// Конец. Изменение списка таблицы

// Начало. Формирование списка выбора
&НаКлиенте
Процедура СформироватьСписокВыбора(ВыбГод, Элемент)
	
	Элементы[Элемент].СписокВыбора.Очистить();
	НачальныйМесяц = Месяц(ОбщегоНазначенияКлиент.ДатаСеанса());
	
	Если ЗначениеЗаполнено(Объект.Дата) Тогда
		
		Если Месяц(Объект.Дата) - 3 < 0 Тогда
			ВыбГод = Год(Объект.Дата);
			НачальныйМесяц = Месяц(Объект.Дата) + 5;
		ИначеЕсли Объект.Дата = НачалоДня(ОбщегоНазначенияКлиент.ДатаСеанса()) Тогда
			ВыбГод = Год(Объект.Дата);
			НачальныйМесяц = Месяц(Объект.Дата) + 1;
		Иначе
			ВыбГод = Год(Объект.Дата) + 1;
			НачальныйМесяц = Месяц(Объект.Дата) - 3;
		КонецЕсли;
		
	КонецЕсли;
	
	Для Счетчик = 1 По 12 Цикл
		
		Если НачальныйМесяц + Счетчик <= 12 Тогда			
			НомерГода = ВыбГод - 1;
			НомерМесяца = НачальныйМесяц + Счетчик;
			Элементы[Элемент].СписокВыбора.Добавить(СтрЗаменить(Формат(Дата(НомерГода, НомерМесяца, 1), "ДФ = ММММ_гггг"), "_", " "));
		Иначе
			НомерГода = ВыбГод;
			НомерМесяца = НачальныйМесяц + Счетчик - 12;
			Элементы[Элемент].СписокВыбора.Добавить(СтрЗаменить(Формат(Дата(НомерГода, НомерМесяца, 1), "ДФ = ММММ_гггг"), "_", " "));
		КонецЕсли; 
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцОбработкаВыбора(Элемент, ВыбЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если ВыбЗначение <>  "" Тогда 
		
		Если СтрДлина(ВыбЗначение) = 4 Тогда
			ВыборГод = Число(ВыбЗначение);
			СформироватьСписокВыбора(ВыборГод, Элемент.Имя);
			
			ДопПараметры = Новый Структура;
			ДопПараметры.Вставить("Имя_Элемента", Элемент.Имя);
			Оповещение = Новый ОписаниеОповещения("ВыборГода", ЭтотОбъект, ДопПараметры);
			ПоказатьВыборИзСписка(Оповещение, Элемент.СписокВыбора, Элемент);
		Иначе
			ЗарплатаЗа = ВыбЗначение;
			ДатаТекстом = "01." + ЗарплатаЗа;
			Объект.ПериодНачисления = СтроковыеФункцииКлиентСервер.СтрокаВДату(ДатаТекстом);
			Объект.Дата = КонецМесяца(Объект.ПериодНачисления);
		КонецЕсли;
		
	Иначе
		Объект[Элемент.Имя] = Неопределено;
	КонецЕсли;
	
КонецПроцедуры 

&НаКлиенте
Процедура ВыборГода(Результат, ДопПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Значение_Результат = Результат.Значение;
	Имя_Элемента = ДопПараметры.Имя_Элемента;;
	Поле_Элемента = Элементы[Имя_Элемента];
	
	Если Значение_Результат <>  "" Тогда
		Если СтрДлина(Значение_Результат) = 4 Тогда
			ВыборГод = Число(Значение_Результат);
			СформироватьСписокВыбора(ВыборГод, Имя_Элемента);
			
			Оповещение = Новый ОписаниеОповещения("ВыборГода", ЭтотОбъект, ДопПараметры);
			ПоказатьВыборИзСписка(Оповещение, Поле_Элемента.СписокВыбора, Поле_Элемента);
		Иначе
			ЭтотОбъект[Имя_Элемента] = Значение_Результат;
			НомерМесяца = Поле_Элемента.СписокВыбора.Индекс(Поле_Элемента.СписокВыбора.НайтиПоЗначению(Значение_Результат));
			ВыборГод = Число(Прав(Значение_Результат, 4));
			Объект[Имя_Элемента] = Дата(ВыборГод, НомерМесяца, 1);
		КонецЕсли;
	Иначе
		Объект[Имя_Элемента] = Неопределено;
	КонецЕсли;
	
КонецПроцедуры
// Конец. Формирование списка выбора

#КонецОбласти
