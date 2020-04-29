﻿
#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отмена, СтандартнаяОбработка)

	Если СтрНайти(СтрокаСоединенияИнформационнойБазы (), "File=") = 0 Тогда
		Сообщить("Только для файловых баз");
	КонецЕсли;

	ЭтотОбъект.Вывод = "Дерево";

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отмена)

	УстановитьВидимостьЭлементов(ЭтотОбъект);

КонецПроцедуры

#КонецОбласти // СобытияФормы

#Область Команды

&НаКлиенте
Процедура КомандаВыполнить(Команда)

	ЭтотОбъект.Результат.Очистить();
	ОчиститьСообщения();
	ВыполнитьНаСервере();

КонецПроцедуры

&НаКлиенте
Процедура КомандаСравнитьСИсходником(Команда)

	КаталогВременныхФайлов = КаталогВременныхФайлов();

	ПутьИсходника = КаталогВременныхФайлов + Строка(Новый УникальныйИдентификатор);
	ЭтотОбъект.Исходник.Записать(ПутьИсходника);

	ПутьРезультата = КаталогВременныхФайлов + Строка(Новый УникальныйИдентификатор);
	ЭтотОбъект.Результат.Записать(ПутьРезультата);

	#Если ТолстыйКлиентУправляемоеПриложение Тогда

	СравнениеФайлов = Новый СравнениеФайлов;
	СравнениеФайлов.СпособСравнения = СпособСравненияФайлов.ТекстовыйДокумент;
	СравнениеФайлов.ИгнорироватьПустоеПространство = Ложь;
	СравнениеФайлов.УчитыватьРазделителиСтрок = Истина;
	СравнениеФайлов.УчитыватьРегистр = Истина;
	СравнениеФайлов.ПервыйФайл = ПутьИсходника;
	СравнениеФайлов.ВторойФайл = ПутьРезультата;
	СравнениеФайлов.ПоказатьРазличия();

	#КонецЕсли

КонецПроцедуры

&НаКлиенте
Процедура КомандаСравнитьСИсходникомWinMerge(Команда)

	КаталогВременныхФайлов = КаталогВременныхФайлов();

	ПутьИсходника = КаталогВременныхФайлов + Строка(Новый УникальныйИдентификатор);
	ЭтотОбъект.Исходник.Записать(ПутьИсходника);

	ПутьРезультата = КаталогВременныхФайлов + Строка(Новый УникальныйИдентификатор);
	ЭтотОбъект.Результат.Записать(ПутьРезультата);

	ЗапуститьПриложение(СтрШаблон("C:\Program Files (x86)\WinMerge\WinMergeU.exe %1 %2", ПутьИсходника, ПутьРезультата));

КонецПроцедуры

#КонецОбласти // Команды

#Область СобытияЭлементов

&НаКлиенте
Процедура ВыводПриИзменении(Элемент)

	Если ЭтотОбъект.Вывод = "Дерево" Тогда
		ЭтотОбъект.Результат.Очистить();
	КонецЕсли;

	УстановитьВидимостьЭлементов(ЭтотОбъект);

КонецПроцедуры

&НаКлиенте
Процедура СтрогийРежимПриИзменении(Элемент)

	СброситьКэш();

КонецПроцедуры

&НаКлиенте
Процедура СоздаватьГлобальноеОкружениеПриИзменении(Элемент)

	СброситьКэш();

КонецПроцедуры

&НаКлиенте
Процедура ДеревоВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтрокаДерева = ЭтотОбъект.Дерево.НайтиПоИдентификатору(ВыбраннаяСтрока);
	Если СтрокаДерева.НомерСтроки > 0 Тогда
		ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
		ЭтотОбъект.Элементы.Исходник.УстановитьГраницыВыделения(СтрокаДерева.Позиция, СтрокаДерева.Позиция + СтрокаДерева.Длина);
		ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТокеныВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Строка = ЭтотОбъект.Токены.НайтиПоИдентификатору(ВыбраннаяСтрока);
	Если Строка.НомерСтроки > 0 Тогда
		ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
		ЭтотОбъект.Элементы.Исходник.УстановитьГраницыВыделения(Строка.Позиция, Строка.Позиция + Строка.Длина);
		ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОшибкиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Строка = ЭтотОбъект.Ошибки.НайтиПоИдентификатору(ВыбраннаяСтрока);
	Если Строка.ПозицияНачала > 0 Тогда
		ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
		ЭтотОбъект.Элементы.Исходник.УстановитьГраницыВыделения(Строка.ПозицияНачала, Строка.ПозицияКонца);
		ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаменыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
	Строка = ЭтотОбъект.Замены.НайтиПоИдентификатору(ВыбраннаяСтрока);
	ЭтотОбъект.Элементы.Исходник.УстановитьГраницыВыделения(Строка.Позиция, Строка.Позиция + Строка.Длина);
	ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.Исходник;
КонецПроцедуры

&НаКлиенте
Процедура ПлагиныПутьНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ВыбратьПуть(Элемент, ЭтотОбъект, РежимДиалогаВыбораФайла.Открытие, "(*.epf)|*.epf");

КонецПроцедуры

&НаКлиенте
Процедура ПлагиныПутьОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПоказатьФайл(ЭтотОбъект.Элементы.Плагины.ТекущиеДанные.Путь);
КонецПроцедуры

&НаКлиенте
Процедура ПлагиныПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Если Не Копирование Тогда
		Отказ = Истина;
		НоваяСтрока = ЭтотОбъект.Плагины.Добавить();
		НоваяСтрока.Вкл = Истина;
		ЭтотОбъект.Элементы.Плагины.ТекущаяСтрока = НоваяСтрока.ПолучитьИдентификатор();
		ЭтотОбъект.ТекущийЭлемент = ЭтотОбъект.Элементы.ПлагиныПуть;
		ЭтотОбъект.Элементы.Плагины.ИзменитьСтроку();
		ВыбратьПуть(ЭтотОбъект.Элементы.ПлагиныПуть, ЭтотОбъект, РежимДиалогаВыбораФайла.Открытие, "(*.epf)|*.epf");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПлагиныПутьПараметровНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ВыбратьПуть(Элемент, ЭтотОбъект, РежимДиалогаВыбораФайла.Открытие, "(*.json)|*.json");

КонецПроцедуры

&НаКлиенте
Процедура ПутьБакендаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ВыбратьПуть(Элемент, ЭтотОбъект, РежимДиалогаВыбораФайла.Открытие, "(*.epf)|*.epf");

КонецПроцедуры

&НаКлиенте
Процедура ПутьБакендаОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПоказатьФайл(ЭтотОбъект.Элементы.Плагины.ТекущиеДанные.Путь);
КонецПроцедуры

#КонецОбласти // СобытияЭлементов

#Область Прочее

&НаСервере
Процедура ВыполнитьНаСервере()

	ОбработкаОбъект = ЭтотОбъект.РеквизитФормыВЗначение("Объект");
	ФайлОбработки = Новый Файл(ОбработкаОбъект.ИспользуемоеИмяФайла);

	ПутьКФайлуПарсера = ФайлОбработки.Путь + "ПарсерВстроенногоЯзыка.epf";
	Парсер = ВнешниеОбработки.Создать(ПутьКФайлуПарсера, Ложь);

	ПутьКФайлуГлобальногоОкружения = ФайлОбработки.Путь + "ГлобальноеОкружение.epf";
	ГлобальноеОкружение = ВнешниеОбработки.Создать(ПутьКФайлуГлобальногоОкружения, Ложь);

	НовыйХэшПарсера = SHA1(Новый ДвоичныеДанные(ПутьКФайлуПарсера));
	Если НовыйХэшПарсера <> ЭтотОбъект.ХэшПарсера Тогда
		ЭтотОбъект.ХэшИсходника = "";
	КонецЕсли;
	ЭтотОбъект.ХэшПарсера = НовыйХэшПарсера;

	ТекстМодуля = ЭтотОбъект.Исходник.ПолучитьТекст();

	Начало = ТекущаяУниверсальнаяДатаВМиллисекундах();

	Окружение = Неопределено;
	Если ЭтотОбъект.СоздаватьГлобальноеОкружение Тогда
		Окружение = ГлобальноеОкружение.Создать(Парсер);
	КонецЕсли;

	Если ЭтотОбъект.Вывод = "NULL" Тогда

		Разобрать(Парсер, ТекстМодуля, Окружение);
		ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;

	ИначеЕсли ЭтотОбъект.Вывод = "АСД" Тогда

		Модуль = Разобрать(Парсер, ТекстМодуля, Окружение);
		ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;

		Если Модуль <> Неопределено Тогда
			ЗагрузитьТокены(Парсер);
			ЗаписьJSON = Новый ЗаписьJSON;
			ЗаписьJSON.SetString(Новый ПараметрыЗаписиJSON(, Chars.Tab));
			ЗаписатьJSON(ЗаписьJSON, Модуль, , "КонвертироватьЗначениеJSON", ЭтотОбъект);
			ЭтотОбъект.Результат.УстановитьТекст(ЗаписьJSON.Закрыть());
		КонецЕсли;

	ИначеЕсли ЭтотОбъект.Вывод = "Дерево" Тогда

		Модуль = Разобрать(Парсер, ТекстМодуля, Окружение);
		ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;

		Если Модуль <> Неопределено Тогда
			ЗагрузитьТокены(Парсер);
			ЗаполнитьДерево(Модуль);
		КонецЕсли;

	ИначеЕсли ЭтотОбъект.Вывод = "Плагины" Тогда

		Модуль = Разобрать(Парсер, ТекстМодуля, Окружение);

		Если Модуль = Неопределено Тогда
			ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
		Иначе
			СписокПлагинов = Новый Массив;
			ПараметрыПлагинов = Новый Соответствие;
			Для Каждого Строка Из ЭтотОбъект.Плагины.НайтиСтроки(Новый Структура("Вкл", Истина)) Цикл
				Плагин = ВнешниеОбработки.Создать(Строка.Путь, Ложь);
				СписокПлагинов.Добавить(Плагин);
				Если Не ПустаяСтрока(Строка.ПутьПараметров) Тогда
					ЧтениеJSON = Новый ЧтениеJSON;
					ЧтениеJSON.ОткрытьФайл(Строка.ПутьПараметров);
					ПараметрыПлагина = ПрочитатьJSON(ЧтениеJSON);
					ПараметрыПлагинов[Плагин.ЭтотОбъект] = ПараметрыПлагина;
				КонецЕсли;
			КонецЦикла;
			Парсер.Подключить(СписокПлагинов);
			Парсер.Посетить(Модуль, ПараметрыПлагинов);
			Результаты = Новый Массив;
			Для Каждого Плагин Из СписокПлагинов Цикл
				Результаты.Добавить(Плагин.Закрыть());
			КонецЦикла;
			ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
			ЭтотОбъект.Результат.УстановитьТекст(СтрСоединить(Результаты));
		КонецЕсли;

	ИначеЕсли ЭтотОбъект.Вывод = "Замены" Тогда

		Модуль = Разобрать(Парсер, ТекстМодуля, Окружение);

		Если Модуль = Неопределено Тогда
			ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
		Иначе
			СписокПлагинов = Новый Массив;
			ПараметрыПлагинов = Новый Соответствие;
			Для Каждого Строка Из ЭтотОбъект.Плагины.НайтиСтроки(Новый Структура("Вкл", Истина)) Цикл
				Плагин = ВнешниеОбработки.Создать(Строка.Путь, Ложь);
				СписокПлагинов.Добавить(Плагин);
				Если Не ПустаяСтрока(Строка.ПутьПараметров) Тогда
					ЧтениеJSON = Новый ЧтениеJSON;
					ЧтениеJSON.ОткрытьФайл(Строка.ПутьПараметров);
					ПараметрыПлагина = ПрочитатьJSON(ЧтениеJSON);
					ПараметрыПлагинов[Плагин.ЭтотОбъект] = ПараметрыПлагина;
				КонецЕсли;
			КонецЦикла;
			Парсер.Подключить(СписокПлагинов);
			Парсер.Посетить(Модуль, ПараметрыПлагинов);
			Для Каждого Плагин Из СписокПлагинов Цикл
				Плагин.Закрыть();
			КонецЦикла;
			Попытка
				ИсходникПослеЗамен = Парсер.ВыполнитьЗамены();
			Исключение
				Сообщить(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			КонецПопытки;
			ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
			Если ИсходникПослеЗамен = Неопределено Тогда
				ЭтотОбъект.Результат.Очистить();
			Иначе
				ЭтотОбъект.Результат.УстановитьТекст(ИсходникПослеЗамен);
			КонецЕсли;
			ЭтотОбъект.Замены.Загрузить(Парсер.ТаблицаЗамен());
			ЭтотОбъект.КоличествоЗамен = ЭтотОбъект.Замены.Количество();
			ЗагрузитьТокены(Парсер);
		КонецЕсли;

	ИначеЕсли ЭтотОбъект.Вывод = "Бакенд" Тогда

		Модуль = Разобрать(Парсер, ТекстМодуля, Окружение);

		Если Модуль = Неопределено Тогда
			ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
		Иначе
			Бакенд = ВнешниеОбработки.Создать(ЭтотОбъект.ПутьБакенда, Ложь);
			Текст = Бакенд.Посетить(Парсер, Модуль);
			ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
			ЭтотОбъект.Результат.УстановитьТекст(Текст);
		КонецЕсли;

	ИначеЕсли ЭтотОбъект.Вывод = "Токены" Тогда

		Попытка
			Парсер.Токенизировать(ЭтотОбъект.Исходник.ПолучитьТекст());
			ПрошлоВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
			ЗагрузитьТокены(Парсер);
		Исключение
			Сообщить("Возникло исключение! " + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецПопытки;

	КонецЕсли;

	Если ЭтотОбъект.ЗамерВремени И ПрошлоВМиллисекундах <> Неопределено Тогда
		Сообщить(СтрШаблон("%1 сек.", ПрошлоВМиллисекундах / 1000));
	КонецЕсли;

	ЭтотОбъект.Ошибки.Загрузить(Парсер.ТаблицаОшибок());
	ЭтотОбъект.КоличествоОшибок = ЭтотОбъект.Ошибки.Количество();

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьТокены(Парсер)
	ЭтотОбъект.Токены.Загрузить(Парсер.ТаблицаТокенов());
	ЭтотОбъект.КоличествоТокенов = ЭтотОбъект.Токены.Количество();
КонецПроцедуры

&НаСервере
Функция Разобрать(Парсер, ТекстМодуля, Окружение)

	НовыйХэшИсходника = SHA1(ПолучитьДвоичныеДанныеИзСтроки(ТекстМодуля));

	Если ЭтотОбъект.ИспользоватьКэшАСД И НовыйХэшИсходника = ЭтотОбъект.ХэшИсходника Тогда

		Модуль = ПолучитьИзВременногоХранилища(ЭтотОбъект.АдресКэшаАСД);

		ТаблицаОшибок = ПолучитьИзВременногоХранилища(ЭтотОбъект.АдресКэшаОшибок);
		ФильтрОшибок = Новый Структура;
		ФильтрОшибок.Вставить("Источник", "ПарсерВстроенногоЯзыка");
		Парсер.УстановитьТаблицуОшибок(ТаблицаОшибок.Скопировать(ФильтрОшибок));

		ТаблицаТокенов = ПолучитьИзВременногоХранилища(ЭтотОбъект.АдресКэшаТокенов);
		Парсер.УстановитьТаблицуТокенов(ТаблицаТокенов);

		Парсер.УстановитьИсходник(ТекстМодуля);

	Иначе

		Попытка

			Парсер.СтрогийРежим = ЭтотОбъект.СтрогийРежим;

			Модуль = Парсер.Разобрать(ТекстМодуля, Окружение);

			Модуль = Новый ФиксированнаяСтруктура(Модуль);

			ЭтотОбъект.АдресКэшаАСД = ПоместитьВоВременноеХранилище(Модуль, ЭтотОбъект.УникальныйИдентификатор);;
			ЭтотОбъект.АдресКэшаОшибок = ПоместитьВоВременноеХранилище(Парсер.ТаблицаОшибок().Скопировать(), ЭтотОбъект.УникальныйИдентификатор);
			ЭтотОбъект.АдресКэшаТокенов = ПоместитьВоВременноеХранилище(Парсер.ТаблицаТокенов(), ЭтотОбъект.УникальныйИдентификатор);
			ЭтотОбъект.ХэшИсходника = НовыйХэшИсходника;

		Исключение

			Сообщить("Возникло исключение! " + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));

		КонецПопытки;

	КонецЕсли;

	Возврат Модуль;

КонецФункции

&НаСервере
Процедура ЗаполнитьДерево(Модуль)
	ДеревоУзлов = ЭтотОбъект.Дерево.ПолучитьЭлементы();
	ДеревоУзлов.Очистить();
	СтрокаДерева = ДеревоУзлов.Добавить();
	СтрокаДерева.Имя = "Модуль";
	СтрокаДерева.Тип = Модуль.Тип;
	СтрокаДерева.Значение = "<...>";
	ЗаполнитьУзел(СтрокаДерева, Модуль);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьУзел(СтрокаДерева, Узел)
	Перем Начало, Конец;
	Если ТипЗнч(Узел) = Тип("Структура") И Узел.Свойство("Начало", Начало) И Узел.Свойство("Конец", Конец) Тогда
		СтрокаДерева.НомерСтроки = Начало.НомерСтроки;
		СтрокаДерева.Позиция = Начало.Позиция;
		СтрокаДерева.Длина = Конец.Позиция + Конец.Длина - Начало.Позиция;
	КонецЕсли;
	ЭлементыДерева = СтрокаДерева.ПолучитьЭлементы();
	Для Каждого Элемент Из Узел Цикл
		Если Элемент.Ключ = "Тип" Или Элемент.Ключ = "Начало" Или Элемент.Ключ = "Конец" Тогда
			Продолжить;
		КонецЕсли;
		Если ТипЗнч(Элемент.Значение) = Тип("Массив") Тогда
			СтрокаДерева = ЭлементыДерева.Добавить();
			СтрокаДерева.Имя = Элемент.Ключ;
			СтрокаДерева.Тип = СтрШаблон("Массив (%1)", Элемент.Значение.Количество());
			СтрокаДерева.Значение = "<...>";
			ЭлементыСтроки = СтрокаДерева.ПолучитьЭлементы();
			Индекс = 0;
			Для Каждого Элемент Из Элемент.Значение Цикл
				СтрокаДерева = ЭлементыСтроки.Добавить();
				СтрокаДерева.Имя = СтрШаблон("[%1]", Индекс);
				Индекс = Индекс + 1;
				Если Элемент = Неопределено Тогда
					СтрокаДерева.Значение = "Неопределено";
				ИначеЕсли ТипЗнч(Элемент) = Тип("Строка") Тогда
					СтрокаДерева.Тип = "Строка";
					СтрокаДерева.Значение = Элемент;
				Иначе
					Элемент.Свойство("Тип", СтрокаДерева.Тип);
					СтрокаДерева.Значение = "<...>";
					ЗаполнитьУзел(СтрокаДерева, Элемент);
				КонецЕсли;
			КонецЦикла;
		ИначеЕсли ТипЗнч(Элемент.Значение) = Тип("Структура") Тогда
			СтрокаДерева = ЭлементыДерева.Добавить();
			СтрокаДерева.Имя = Элемент.Ключ;
			Если Не Элемент.Значение.Свойство("Тип", СтрокаДерева.Тип) Тогда
				СтрокаДерева.Тип = "Структура";
			КонецЕсли;
			СтрокаДерева.Значение = "<...>";
			ЗаполнитьУзел(СтрокаДерева, Элемент.Значение);
		Иначе
			СтрокаДерева = ЭлементыДерева.Добавить();
			СтрокаДерева.Имя = Элемент.Ключ;
			СтрокаДерева.Значение = Элемент.Значение;
			СтрокаДерева.Тип = ТипЗнч(Элемент.Значение);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция КонвертироватьЗначениеJSON(Свойство, Значение, Другое, Отмена) Экспорт
	
	Если ТипЗнч(Значение) = Тип("СтрокаТаблицыЗначений") Тогда
		Возврат Значение.Индекс;
	ИначеЕсли Значение <> Null Тогда
		ВызватьИсключение "Невозможно преобразовать значение";
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьЭлементов(ЭтотОбъект)

	Элементы = ЭтотОбъект.Элементы;

	Элементы.СтраницаПлагины.Видимость = (ЭтотОбъект.Вывод = "Плагины" Или ЭтотОбъект.Вывод = "Замены");
	Элементы.СтраницаРезультатДерево.Видимость = (ЭтотОбъект.Вывод = "Дерево");
	Элементы.СтраницаРезультатТекст.Видимость = (
		ЭтотОбъект.Вывод = "Плагины"
		Или ЭтотОбъект.Вывод = "АСД"
		Или ЭтотОбъект.Вывод = "Бакенд"
		Или ЭтотОбъект.Вывод = "Замены"
	);
	Элементы.ПутьБакенда.Видимость = (ЭтотОбъект.Вывод = "Бакенд");
	Элементы.СтраницаРезультатТокены.Видимость = (
		ЭтотОбъект.Вывод = "АСД"
		Или ЭтотОбъект.Вывод = "Дерево"
		Или ЭтотОбъект.Вывод = "Токены"
		Или ЭтотОбъект.Вывод = "Замены"
	);
	Элементы.СтраницаЗамены.Видимость = (ЭтотОбъект.Вывод = "Замены");

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПуть(Элемент, Форма, РежимДиалога = Неопределено, Фильтр = Неопределено) Экспорт

	Если РежимДиалога = Неопределено Тогда
		РежимДиалога = РежимДиалогаВыбораФайла.ВыборКаталога;
	КонецЕсли;

	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалога);
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	ДиалогВыбораФайла.Фильтр = Фильтр;
	Если РежимДиалога = РежимДиалогаВыбораФайла.ВыборКаталога Тогда
		ДиалогВыбораФайла.Каталог = Элемент.ТекстРедактирования;
	Иначе
		ДиалогВыбораФайла.ПолноеИмяФайла = Элемент.ТекстРедактирования;
	КонецЕсли;

	ДополнительныеПараметры = Новый Структура("Элемент, Форма", Элемент, Форма);

	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработатьВыборФайла", ЭтотОбъект, ДополнительныеПараметры);

	ДиалогВыбораФайла.Показать(ОписаниеОповещения);

КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВыборФайла(Результат, ДополнительныеПараметры) Экспорт

	Если Результат <> Неопределено Тогда
		ИнтерактивноУстановитьЗначениеЭлементаФормы(
			Результат[0],
			ДополнительныеПараметры.Элемент,
			ДополнительныеПараметры.Форма
		);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ИнтерактивноУстановитьЗначениеЭлементаФормы(Значение, Элемент, Форма) Экспорт

	СтарыйВладелецФормы = Форма.ВладелецФормы;
	ЗакрыватьПриВыборе = Форма.ЗакрыватьПриВыборе;

	Форма.ВладелецФормы = Элемент;
	Форма.ЗакрыватьПриВыборе = Ложь;

	Форма.ОповеститьОВыборе(Значение);

	Если Форма.ВладелецФормы = Элемент Тогда
		Форма.ВладелецФормы = СтарыйВладелецФормы;
	КонецЕсли;

	Если Форма.ЗакрыватьПриВыборе = Ложь Тогда
		Форма.ЗакрыватьПриВыборе = ЗакрыватьПриВыборе;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПоказатьФайл(ПолноеИмя) Экспорт
	Если ПолноеИмя <> Неопределено Тогда
		НачатьЗапускПриложения(
			Новый ОписаниеОповещения("ОбработатьПоказатьФайл", ЭтотОбъект, ПолноеИмя),
			"explorer.exe /select, " + ПолноеИмя
		);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьПоказатьФайл(КодВозврата, ПолноеИмя) Экспорт
	// ничего не делать
КонецПроцедуры

&НаСервереБезКонтекста
Функция SHA1(ДвоичныеДанные)

	ХешированиеДанных = Новый ХешированиеДанных (ХешФункция .SHA1);
	ХешированиеДанных.Добавить("blob " + Format(ДвоичныеДанные.Size(), "NZ=0; NG=") + Char(0));
	ХешированиеДанных.Добавить(ДвоичныеДанные);

	SHA1 = ПолучитьHexСтрокуИзДвоичныхДанных(ХешированиеДанных.ХешСумма);

	Возврат SHA1;

КонецФункции

&НаКлиенте
Процедура СброситьКэш()

	ЭтотОбъект.ХэшИсходника = Неопределено;

КонецПроцедуры

#КонецОбласти
