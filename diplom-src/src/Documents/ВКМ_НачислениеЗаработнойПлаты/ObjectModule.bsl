
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий
	
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	СформироватьОсновныеНачисления();
	
	РассчитатьОклад();
	
	РассчитатьОтпуск();
	
	РассчитатьВыплатуЗарплаты();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИфункции

Процедура СформироватьОсновныеНачисления()
	
	ДобавитьЗаписиПоОкладу();
	
    СформироватьСторноЗаписи();
		
	Движения.ВКМ_ОсновныеНачисления.Записать();
	
КонецПроцедуры

Процедура ДобавитьЗаписиПоОкладу()

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.Сотрудник КАК Сотрудник,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ВидРасчета КАК ВидРасчета,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаНачала КАК ПериодДействияНачало,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаОкончания КАК ПериодДействияОкончание,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ГрафикРаботы КАК ГрафикРаботы,
        |   МАКСИМУМ(ВКМ_УсловияОплатыСотрудников.Период) КАК Период,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ЧасовОтработано КАК ЧасовОтработано
        |ПОМЕСТИТЬ ВТ_ДанныеПоОкладам
        |ИЗ
        |   Документ.ВКМ_НачислениеЗаработнойПлаты.ОсновныеНачисления КАК ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления
        |       ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ВКМ_УсловияОплатыСотрудников КАК ВКМ_УсловияОплатыСотрудников
        |       ПО ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.Сотрудник = ВКМ_УсловияОплатыСотрудников.Сотрудник
        |           И ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаНачала >= ВКМ_УсловияОплатыСотрудников.Период
        |ГДЕ
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.Ссылка = &Ссылка
        |   И ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ВидРасчета = &Оклад
        |
        |СГРУППИРОВАТЬ ПО
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.Сотрудник,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ВидРасчета,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаНачала,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаОкончания,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ГрафикРаботы,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ЧасовОтработано
        |;
        |
        |////////////////////////////////////////////////////////////////////////////////
        |ВЫБРАТЬ
        |   ВТ_ДанныеПоОкладам.Сотрудник КАК Сотрудник,
        |   ВТ_ДанныеПоОкладам.ВидРасчета КАК ВидРасчета,
        |   ВТ_ДанныеПоОкладам.ПериодДействияНачало КАК ПериодДействияНачало,
        |   ВТ_ДанныеПоОкладам.ПериодДействияОкончание КАК ПериодДействияКонец,
        |   ВТ_ДанныеПоОкладам.ГрафикРаботы КАК ГрафикРаботы,
        |   ВКМ_УсловияОплатыСотрудников.Оклад КАК Показатель,
        |   NULL КАК БазовыйПериодНачало,
        |   NULL КАК БазовыйПериодКонец,
        |   ВТ_ДанныеПоОкладам.ЧасовОтработано КАК ЧасовОтработано
        |ИЗ
        |   РегистрСведений.ВКМ_УсловияОплатыСотрудников КАК ВКМ_УсловияОплатыСотрудников
        |       ПРАВОЕ СОЕДИНЕНИЕ ВТ_ДанныеПоОкладам КАК ВТ_ДанныеПоОкладам
        |       ПО (ВТ_ДанныеПоОкладам.Сотрудник = ВКМ_УсловияОплатыСотрудников.Сотрудник)
        |           И (ВТ_ДанныеПоОкладам.Период = ВКМ_УсловияОплатыСотрудников.Период)
        |
        |ОБЪЕДИНИТЬ ВСЕ
        |
        |ВЫБРАТЬ
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.Сотрудник,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ВидРасчета,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаНачала,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаОкончания,
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ГрафикРаботы,
        |   NULL,
        |   НАЧАЛОПЕРИОДА(ДОБАВИТЬКДАТЕ(ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаНачала, МЕСЯЦ, -12), МЕСЯЦ),
        |   КОНЕЦПЕРИОДА(ДОБАВИТЬКДАТЕ(ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ДатаНачала, МЕСЯЦ, -1), МЕСЯЦ),
        |   NULL
        |ИЗ
        |   Документ.ВКМ_НачислениеЗаработнойПлаты.ОсновныеНачисления КАК ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления
        |ГДЕ
        |   ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.Ссылка = &Ссылка
        |   И ВКМ_НачислениеЗаработнойПлатыОсновныеНачисления.ВидРасчета = &Отпуск";
	
	Запрос.УстановитьПараметр("Оклад", ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Оклад);
	Запрос.УстановитьПараметр("Отпуск", ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	// Движения по регистру ВКМ_ОсновныеНачисления
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ОсновныеНачисления.Добавить();
		ЗаполнитьЗначенияСвойств(Движение, Выборка);
		Движение.ПериодРегистрации = Дата;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СформироватьСторноЗаписи()
	
	СторноЗаписи = Движения.ВКМ_ОсновныеНачисления.ПолучитьДополнение(); 
	
	Для Каждого Строка Из СторноЗаписи Цикл
		
		Движение = Движения.ВКМ_ОсновныеНачисления.Добавить();
		ЗаполнитьЗначенияСвойств(Движение, Строка);
		Движение.ПериодРегистрации = Дата;
		Движение.ПериодДействияНачало = Строка.ПериодДействияНачалоСторно;    
		Движение.ПериодДействияКонец = Строка.ПериодДействияКонецСторно;   
		Движение.Сторно = Истина;
		
	КонецЦикла;
		
КонецПроцедуры	
	
Процедура РассчитатьОклад()
	
    Запрос = Новый Запрос;
    Запрос.Текст = 
    	"ВЫБРАТЬ
        |   ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки КАК НомерСтроки,
        |   ВКМ_ОсновныеНачисленияДанныеГрафика.Сотрудник КАК Сотрудник,
        |   ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеПериодДействия КАК План,
        |   ВКМ_ОсновныеНачисленияДанныеГрафика.ЧасовОтработано КАК Факт,
        |   ЕСТЬNULL(ВКМ_ВыполненныеСотрудникомРаботыОбороты.СуммаКОплатеОборот, 0) КАК РаботыСумма,
        |   ЕСТЬNULL(ВКМ_ВыполненныеСотрудникомРаботыОбороты.ЧасовКОплатеОборот, 0) КАК РаботыЧасы
        |ИЗ
        |   РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(
        |           ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Оклад)
        |               И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияДанныеГрафика
        |       ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ВКМ_ВыполненныеСотрудникомРаботы.Обороты(&НачалоПериода, &КонецПериода, Месяц, ) КАК ВКМ_ВыполненныеСотрудникомРаботыОбороты
        |       ПО ВКМ_ОсновныеНачисленияДанныеГрафика.Сотрудник = ВКМ_ВыполненныеСотрудникомРаботыОбороты.Сотрудник";
    
    Запрос.УстановитьПараметр("Ссылка", Ссылка);
    Запрос.УстановитьПараметр("НачалоПериода", НачалоМесяца(Дата)); 
    Запрос.УстановитьПараметр("КонецПериода", КонецМесяца(Дата));
    
    Выборка = Запрос.Выполнить().Выбрать();
    
    Пока Выборка.Следующий() Цикл
        
        // Движения по регистру ВКМ_ОсновныеНачисления    
    	Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки - 1];
    	Если Выборка.План = 0 Тогда
    		ОбщегоНазначения.СообщитьПользователю("Не заполнен график на этот период");
    		Возврат;
    	Иначе
    		Движение.Результат = (Движение.Показатель * Выборка.Факт / Выборка.План);
        КонецЕсли;
        
        Если ЗначениеЗаполнено(Выборка.РаботыСумма) Тогда
            
            // Движения по регистру ВКМ_ДополнительныеНачисления
            ДвижениеДопНачисления = Движения.ВКМ_ДополнительныеНачисления.Добавить();
            ДвижениеДопНачисления.ПериодРегистрации = Дата;
            ДвижениеДопНачисления.ВидРасчета = ПланыВидовРасчета.ВКМ_ДополнительныеНачисления.ПроцСПродаж;
            ДвижениеДопНачисления.Сотрудник = Выборка.Сотрудник;
            ДвижениеДопНачисления.Результат = Выборка.РаботыСумма;
            
            //движения по регистру ВКМ_ВыполненныеСотрудникомРаботы
            ДвижениеРаботы = Движения.ВКМ_ВыполненныеСотрудникомРаботы.Добавить();
            ДвижениеРаботы.ВидДвижения = ВидДвиженияНакопления.Расход;
            ДвижениеРаботы.Период = Дата;
            ДвижениеРаботы.Сотрудник = Выборка.Сотрудник;
            ДвижениеРаботы.СуммаКОплате = Выборка.РаботыСумма;
            ДвижениеРаботы.ЧасовКОплате = Выборка.РаботыЧасы;
            
        КонецЕсли;        
    	
    КонецЦикла;
    
    Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
    Движения.ВКМ_ДополнительныеНачисления.Записать();
    Движения.ВКМ_ВыполненныеСотрудникомРаботы.Записать();
	
КонецПроцедуры

Процедура РассчитатьОтпуск()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОсновныеНачисления.НомерСтроки КАК НомерСтроки,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.РезультатБаза, 0) КАК РезультатБаза,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.ЧасовОтработаноБаза, 0) КАК ЧасовОтработаноБаза,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеФактическийПериодДействия, 0) КАК ФактическийПериод
		|ИЗ
		|	РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.БазаВКМ_ОсновныеНачисления(
		|				&Измерения,
		|				&Измерения,
		|				,
		|				ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск)
		|					И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления
		|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.НомерСтроки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(
		|				ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск)
		|					И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияДанныеГрафика
		|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки
		|ГДЕ
		|	ВКМ_ОсновныеНачисления.ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск)
		|	И ВКМ_ОсновныеНачисления.Регистратор = &Ссылка";
	
	Измерения = Новый Массив;
	Измерения.Добавить("Сотрудник");
	
	Запрос.УстановитьПараметр("Измерения", Измерения);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки - 1];
		
		Если Выборка.ЧасовОтработаноБаза = 0 Тогда
			Движение.Результат = 0;
		Иначе
			Движение.Результат = Выборка.РезультатБаза * Выборка.ФактическийПериод / Выборка.ЧасовОтработаноБаза;
		КонецЕсли;
			
	КонецЦикла; 
	
	Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
			
КонецПроцедуры

Процедура РассчитатьВыплатуЗарплаты()
    
    Запрос = Новый Запрос;
    Запрос.Текст = 
        "ВЫБРАТЬ
        |   ВКМ_ОсновныеНачисления.НомерСтроки КАК НомерСтроки,
        |   ВКМ_ОсновныеНачисления.Сотрудник КАК Сотрудник,
        |   ВКМ_ОсновныеНачисления.ВидРасчета КАК ВидРасчета,
        |   ВКМ_ОсновныеНачисления.Результат КАК Результат,
        |   ВКМ_ОсновныеНачисления.Регистратор КАК Регистратор
        |ИЗ
        |   РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
        |ГДЕ
        |   ВКМ_ОсновныеНачисления.Регистратор = &Ссылка";
    
    Запрос.УстановитьПараметр("Ссылка", Ссылка);
    
    Выборка = Запрос.Выполнить().Выбрать();
    
    Пока Выборка.Следующий() Цикл
        
        // Движение по регистру ВКМ_Удержание
        ДвижениеУдержания = Движения.ВКМ_Удержания.Добавить();
        ЗаполнитьЗначенияСвойств(ДвижениеУдержания, Выборка);
        ДвижениеУдержания.ПериодРегистрации = Дата;
        ДвижениеУдержания.ВидРасчета = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
        ДвижениеУдержания.Сотрудник = Выборка.Сотрудник;
        ДвижениеУдержания.Результат = Окр(ДвижениеУдержания.Результат * 0.13, 2);
        
        // Движения по регистру ВКМ_ВзаиморасчетыССотрудниками
        ДвижениеВзаиморасчеты = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		ДвижениеВзаиморасчеты.ВидДвижения = ВидДвиженияНакопления.Приход;
		ДвижениеВзаиморасчеты.Период = Дата;
		ДвижениеВзаиморасчеты.Сотрудник = Выборка.Сотрудник;
		ДвижениеВзаиморасчеты.Сумма = Выборка.Результат - ДвижениеУдержания.Результат;
        ДвижениеВзаиморасчеты.ВидРасчета = Выборка.ВидРасчета;
        ДвижениеВзаиморасчеты.Регистратор = Выборка.Регистратор;
        
    КонецЦикла;

    Движения.ВКМ_Удержания.Записать();
    Движения.ВКМ_ВзаиморасчетыССотрудниками.Записать();
    
КонецПроцедуры

#КонецОбласти

#КонецЕсли