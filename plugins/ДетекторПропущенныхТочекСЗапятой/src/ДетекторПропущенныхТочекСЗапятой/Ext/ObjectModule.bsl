﻿
Перем Токены;
Перем Узлы;
Перем ТаблицаТокенов;
Перем ТаблицаОшибок;

Процедура Инициализировать(Парсер) Экспорт
	Токены = Парсер.Токены();
	ТаблицаТокенов = Парсер.ТаблицаТокенов();
	ТаблицаОшибок = Парсер.ТаблицаОшибок();
	Узлы = Парсер.Узлы();
	Результат = Новый Массив;
КонецПроцедуры // Инициализировать()

Функция Закрыть() Экспорт
	Возврат Неопределено;
КонецФункции // Закрыть()

Функция Подписки() Экспорт
	Перем Подписки;
	Подписки = Новый Массив;
	Подписки.Добавить("ПосетитьОператоры");
	Возврат Подписки;
КонецФункции // Подписки()

#Область РеализацияПодписок

Процедура ПосетитьОператоры(Операторы) Экспорт
	
	Для Каждого Оператор Из Операторы Цикл
		
		ПоследнийТокен = ТаблицаТокенов[Оператор.Конец];
		СледующийТокен = ТаблицаТокенов[Оператор.Конец + 1];
		
		Если СледующийТокен.Токен <> Токены.ТочкаСЗапятой Тогда
						
			Ошибка("Пропущена точка с запятой", Оператор.Конец);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры // ПосетитьОператоры()

#КонецОбласти // РеализацияПодписок

Процедура Ошибка(Текст, Начало, Конец = Неопределено)
	Если Конец = Неопределено Тогда
		Конец = Начало;
	КонецЕсли;
	ТокенНачала = ТаблицаТокенов[Начало];
	ТокенКонца = ТаблицаТокенов[Конец];
	Ошибка = ТаблицаОшибок.Добавить();
	Ошибка.Источник = "ДетекторПропущенныхТочекСЗапятой";
	Ошибка.ТекстОшибки = Текст;
	Ошибка.ПозицияНачала = ТокенНачала.Начало;
	Ошибка.НомерСтрокиНачала = ТокенНачала.НомерСтроки;
	Ошибка.НомерКолонкиНачала = ТокенНачала.НомерКолонки;
	Ошибка.ПозицияКонца = ТокенКонца.Конец;
	Ошибка.НомерСтрокиКонца = ТокенКонца.НомерСтроки;
	Ошибка.НомерКолонкиКонца = ТокенКонца.НомерКолонки;
КонецПроцедуры