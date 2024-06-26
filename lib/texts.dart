/// index [EN,RU,...]
int _ = 1;
const _langs = {'en': 0, 'ru': 1, 'de': 2, 'kk': 3,};

Texts get txt => Texts.instance;

class Texts {
  /// Use before accessing / initializing to instance
  static void setLocale(String localeCode) {
    assert(_langs.containsKey(localeCode),
    'localeCode=$localeCode does not supported');
    _ = _langs[localeCode]!;
    _instance = Texts();
  }

  static Texts _instance = Texts();

  static Texts get instance => _instance;

  final disconnected = [
    'Disconnected',
    'Не подключено',
    'Keine Verbindung',
    'Ажыратылған'
  ][_];

  final connecting = [
    'Connecting',
    'Подключение',
    'Verbindung',
    'Қосылуда'
  ][_];

  final fetching = [
    'Fetching',
    'Обновление',
    'Aktualisierung',
    'Жаңарту'
  ][_];

  final disconnecting = [
    'Disconnecting',
    'Отключение',
    'Abbruch',
    'Ажыратылуда'
  ][_];

  final problemsTitle = [
    'Connection problem',
    'Проблема с соединением',
    'Verbindungsprobleme',
    'Қосылым мәселесі'
  ][_];

  final maintenanceTitle = [
    'Service maintenance',
    'Обслуживание системы',
    'Systemwartung',
    'Жүйеге техникалық қызмет көрсету'
  ][_];

  final secsBeforeReconnect = [
    'Retrying after',
    'Повторная попытка через',
    'Erneuter Versuch nach',
    'Кейін қайталау'
  ][_];

  final searchingTitle = [
    'Network waiting',
    'Ожидание сети',
    'Warte auf Netz',
    'Желіні күту'
  ][_];

  final searchingSubtitle = [
    'Provide access',
    'Обеспечьте доступ',
    'Zugang gewähren',
    'Қол жеткізуді қамтамасыз ету'
  ][_];

  final lastSyncPrefix = [
    'Synchronized',
    'Cинхронизировано',
    'Synchroniziert',
    'Синхрондалған'
  ][_];

  final idle = [
    'Connected',
    'Подключено',
    'Verbunden',
    'Қосылды'
  ][_];
  final fetchedCounts = [
    'Pieces downloaded',
    'Скачано данных',
    'Heruntergeladene Stücke',
    'Деректер жүктелді'
  ][_];

  final searchingExplanation = [
    '''There is currently no wifi or cellular connection.
Provide at least one internet access channel.
If airplane mode is enabled, then the cellular network is unavailable,
but you can use wifi connections if available.
If your device has network access restriction mechanisms,
make sure all permissions are granted to the application.
Make sure that the system does not have any restrictions on access to the internet''',
    '''WiFi или сотовое соединение в данный момент отсутствует. 
Обеспечьте хотя бы один канал выхода в интернет.
Если включен режим "в самолете", то сотовая сеть недоступна,
но можно использовать WiFi подключения при их наличии.
Если на устройстве есть механизы ограничения доступа к сети,
убедитесь что приложению выданы все разрешения. 
Убедитесь, что в системе отсутствуют возможные ограничения на доступ к интернету''',
    '''Es gibt derzeit keine WLAN- oder Mobilfunkverbindung.
Bitte mindestens einen Internetzugangskanal zur Verfügung stellen.
Wenn der Flugzeugmodus aktiviert ist, ist das Mobilfunknetz nicht verfügbar, aber Sie können, falls verfügbar, WLAN-Verbindungen verwenden.
Wenn Ihr Gerät über Mechanismen zur Beschränkung des Netzwerkzugriffs verfügt,
stellen Sie sicher, dass alle Berechtigungen für die Anwendung erteilt werden.
Bitte sicherstellen, dass das System keine Einschränkungen für den Zugang zum Internet hat.

Übersetzt mit www.DeepL.com/Translator (kostenlose Version)
    ''',
    '''Қазіргі уақытта Wi-Fi немесе ұялы байланыс жоқ.
Кем дегенде бір интернетке кіру арнасын қамтамасыз етіңіз.
Ұшақ режимі қосылса, ұялы желі қолжетімсіз болады,
бірақ бар болса, Wi-Fi қосылымдарын пайдалануға болады.
Құрылғыңызда желіге кіруді шектеу механизмдері болса,
қолданбаға барлық рұқсаттардың берілгенін тексеріңіз.
Жүйеде интернетке кіруге ешқандай шектеулер жоқ екеніне көз жеткізіңіз'''
  ][_];
}
