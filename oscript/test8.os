// Пример автоматического исправления ошибок.
// Данный скрипт расставляет пропущенные точки с запятой в исходниках в указанной папке.

ПодключитьСценарий("..\src\ПарсерВстроенногоЯзыка\Ext\ObjectModule.bsl", "Парсер");
ПодключитьСценарий("..\plugins\РасстановкаПропущенныхТочекСЗапятой\src\РасстановкаПропущенныхТочекСЗапятой\Ext\ObjectModule.bsl", "РасстановкаПропущенныхТочекСЗапятой");

Если АргументыКоманднойСтроки.Количество() = 0 Тогда
	ВызватьИсключение "Укажите в качестве параметра путь к папке с модулями bsl";
КонецЕсли;

ПутьКМодулям = АргументыКоманднойСтроки[0];
Файлы = НайтиФайлы(ПутьКМодулям, "*.bsl", Истина);

Парсер = Новый Парсер;
Плагин = Новый РасстановкаПропущенныхТочекСЗапятой;

ЧтениеТекста = Новый ЧтениеТекста;

Отчет = Новый Массив;

Количество = 0;

Для Каждого Файл Из Файлы Цикл
	Если Файл.ЭтоФайл() Тогда
		ЧтениеТекста.Открыть(Файл.ПолноеИмя, "UTF-8");
		Исходник = ЧтениеТекста.Прочитать();
		ЧтениеТекста.Закрыть();
		Попытка
			Парсер.Пуск(Исходник, Плагин);
			ИсправленныйИсходник = Плагин.Закрыть();
			Если ИсправленныйИсходник <> Неопределено Тогда
				ЗаписьТекста = Новый ЗаписьТекста;
				ЗаписьТекста.Открыть(Файл.ПолноеИмя, "UTF-8");
				ЗаписьТекста.Записать(ИсправленныйИсходник);
				ЗаписьТекста.Закрыть();
				Количество = Количество + 1;
			КонецЕсли;
		Исключение
			Сообщить(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецПопытки;
	КонецЕсли;
КонецЦикла;

Сообщить(СтрШаблон("Исправлено %1 исходников", Количество));