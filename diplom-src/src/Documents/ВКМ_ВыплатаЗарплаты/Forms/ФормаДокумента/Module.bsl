
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Заполнить(Команда)
    
	Если Объект.Выплаты.Количество() > 0 Тогда
		
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
		Объект.Выплаты.Очистить();
		ЗаполнитьТабличнуюЧасть();				
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьТабличнуюЧасть()
	
	МассивДанныхОСотрудниках = ДанныеПоМесяцуНачисленияНаСервере(Объект.Дата, Объект.Ссылка);
    
    Если МассивДанныхОСотрудниках.Количество() > 0 Тогда
        
        Для Индекс = 0 По МассивДанныхОСотрудниках.Количество() - 1 Цикл
            Элементы.Выплаты.ДобавитьСтроку();    
            СтрокаТЧ = Элементы.Выплаты.ТекущиеДанные;
            СтрокаТЧ.Сотрудник = МассивДанныхОСотрудниках[Индекс].Сотрудник;
            СтрокаТЧ.Сумма = МассивДанныхОСотрудниках[Индекс].Сумма;            
        КонецЦикла;
        
    Иначе
        ОбщегоНазначенияКлиент.СообщитьПользователю("В этом месяце начисления не выполнены", , , , Истина);
		Возврат;
    КонецЕсли;
	
КонецПроцедуры 

&НаСервере
Функция ДанныеПоМесяцуНачисленияНаСервере(Дата, Ссылка) 
    
    ДатаЗапроса = ДобавитьМесяц(Дата, -1);
	
	Запрос = Новый Запрос;
    Запрос.Текст = 
        "ВЫБРАТЬ
        |   ВКМ_ВзаиморасчетыССотрудникамиОбороты.Сотрудник КАК Сотрудник,
        |   ВКМ_ВзаиморасчетыССотрудникамиОбороты.СуммаПриход КАК СуммаПриход
        |ИЗ
        |   РегистрНакопления.ВКМ_ВзаиморасчетыССотрудниками.Обороты(&НачалоПериода, &КонецПериода, Месяц, ) 
        |		КАК ВКМ_ВзаиморасчетыССотрудникамиОбороты";

    Запрос.УстановитьПараметр("НачалоПериода", НачалоМесяца(ДатаЗапроса));
    Запрос.УстановитьПараметр("КонецПериода", КонецМесяца(ДатаЗапроса)); 
    
    Выборка = Запрос.Выполнить().Выбрать();
	
	МассивСтруктур = Новый Массив;
		
	Пока Выборка.Следующий() Цикл
		
		Сотрудник = Новый Структура;
		Сотрудник.Вставить("Сотрудник",Выборка.Сотрудник);
		Сотрудник.Вставить("Сумма", Выборка.СуммаПриход);
		МассивСтруктур.Добавить(Сотрудник);
		
	КонецЦикла;
	
	Возврат МассивСтруктур;
	
КонецФункции 

#КонецОбласти

