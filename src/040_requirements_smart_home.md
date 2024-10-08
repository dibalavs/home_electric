# Требования к системе "умный дом"

## Общие требования

::: {.alert .warning}
Основная идея в умного дома в том, что он должен управлять существующей автоматикой а не заменять ее собой. 
:::

Контроллер умного дома не должен быть единой точкой отказа. Так при его поломке или зависании система должна продолжить функционировать в ручном режиме - должно быть возможно включать/выключать свет выключателями, открывать/закрывать шторы, отключать/включать электричество мастер выключателями. При отказе контроллера - будут теряться удобства такие как: сценарии, голосовое управление, разные энергосберегающие оптимизации.

Система должна функционировать полностью offline. Не должна использовать никакие облака, online сервисы. Как следствие этого - на роутере должен быть запрещен выход в интернет для контроллера (за исключением когда нужно загрузить обновления), и проброс портов UPnP.

Датчики и исполнительные устройства должны быть проводными, чтобы не зависеть координатора/роутера/батареек.

## Основные сценарии

**"Утро"** - После восхода солнца, но не ранее 8 утра, во всех комнатах открываются шторы, отключается ночной свет (ночник), выключается колыбельная в детской.

**"Вечер"** - После захода солнца, но не позже 21 вечера, во всех комнатах закрываются шторы. 

**"Ночь"** - После 22 вечера, начинает действовать "ночной свет" - в коридоре и санузлах, при обнаружении движения, загорается LED лента, на малой мощности, чтобы в ночи можно было ходить и не слепило глаза. Если в детской задан ночник - то загорается LED лента на заданной мощности. Если задана мелодия "колыбельной" - то в детской она включается через динамик оповещения.

**"Будильник"** - в установленное время в заданной комнате - через динамик оповещения звучит мелодия или звук.

**"Расписание"** - В заданное время динамик оповещения голосом напоминает о событии.

**"Экономия"** - При отсутствии движения в туалете (5 минут) или ванной (10 минут) или коридоре (10 минут) в соответствующем помещении выключается свет.

**"Автосвет"** - При входе в туалет или ванную, там автоматически включается свет.

**Осушение ванной"** - При достижении влажности 70% в ванной - включается вытяжной вентилятор. При уменьшении влажности менее 50% - он выключается.

**"Мы ушли"** - При уходе всех из квартиры, И подаче голосовому ассистенту команды "мы ушли" - в квартире выключаются:

- Свет во всех комнатах.
- Группы рабочих розеток (куда подключен телевизор и обвязка. Эти группы также имеют отдельных выключатель).
- Теплый пол (если он включен).
- Кондиционеры (нужно подумать, так как они управляются по IR и не имеют явного состояния).
- Мощность приточной вентиляции уменьшается. 

**"Мы пришли"** - При регистрации движения в квартире (нужно подумать чтобы на кошку не реагировал) восстанавливается состояние теплого пола, кондиционеров, и приточной вентиляции которое было на момент подачи команды "Мы ушли".

## Голосовой ассистент

Команда активации ассистента должна быть выбрана такой, чтобы исключить случайное срабатывание, если она будет произнесена по телевизору или в разговоре.

Команды делятся на 2 категории - управление оборудованием квартиры и запрос информации.

Голосовые команды будут работать по следующей схеме:

\
Человек: <команда активации> \
Дом: <звук> \
Человек: <сама команда> \
Дом: <ответ (если запрос информации)> \
Дом: <статус - ок или ошибка> \
Дом: <повтор команды> (нужно для целей отладки)

Пример (полужирным - ответ голосового ассистента): Слушай дом. **<звук>**. открой шторы на кухне. **Готово. Открой шторы на кухне.**

### Управление

Команда на управление оборудованием имеет следующий формат:

<действие> - <объект> - [<помещение>]

Пример: "включи свет на кухне"

Если помещение не указано, то используется то помещение, в котором голосовой асистент услышал команду.
Для кухни/гостинной, так как эти 2 помещения объединены, используется то помещение, где последним было зафиксировано движение.

**Шторы**: \
"Открой шторы". \
"Открой шторы на кухне". \
"Закрой шторы во всех комнатах". \
"Закрой шторы". \
"Приоткрой шторы". \
"Призакрой шторы". \
"Открой шторы на 20%". \
"Закрой шторы на 20%".

**Освещение**: \
"Включи свет". \
"Выключи свет на кухне". \
"Выключи свет во всех комнатах".

**Ночной свет**: \
"Включи ночной свет". \
"Выключи ночной свет на кухне". \
"Выключи ночной свет во всех комнатах".

**Мы ушли**

### Запрос информации

Вопросительные предложения имеют вид:\
<вопрос> - <параметр> - [<помещение>]

"Какая температура на кухне?" \
"Какой климат в гостинной?" (ответом будут - данные по температуре, влажности, уровне CO2) \
"Какая температура на улице?"