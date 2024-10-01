/// index [EN,RU,...]
int _ = 1;
const _langs = {'en': 0, 'ru': 1, 'de': 2, 'kk': 3, 'uz': 4, 'ar': 5};

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
    'Қосылмады',
    'Uzilldi',
    'غير متصل',
  ][_];

  final connecting = [
    'Connecting',
    'Подключение',
    'Verbindung',
    'Қосылу',
    'Ulanish',
    'التوصيل',
  ][_];

  final fetching = [
    'Fetching',
    'Обновление',
    'Aktualisierung',
    'Жаңарту',
    'Yangilash',
    'تحديث',
  ][_];

  final disconnecting = [
    'Disconnecting',
    'Отключение',
    'Abbruch',
    'Ажырату',
    'Ajratish',
    'قطع الاتصال',
  ][_];

  final problemsTitle = [
    'Connection problem',
    'Проблема с соединением',
    'Verbindungsprobleme',
    'Қосылу мәселесі',
    'Ulanish muammosi',
    'مشكلة الاتصال',
  ][_];

  final maintenanceTitle = [
    'Service maintenance',
    'Обслуживание системы',
    'Systemwartung',
    'Сервистік қызмет көрсету',
    "Xizmat ko'rsatish",
    'صيانة الخدمة',
  ][_];

  final secsBeforeReconnect = [
    'Retrying after',
    'Повторная попытка через',
    'Erneuter Versuch nach',
    'Кейін қайталау',
    'Keyin qayta urinish',
    'إعادة المحاولة بعد',
  ][_];

  final searchingTitle = [
    'Network waiting',
    'Ожидание сети',
    'Warte auf Netz',
    'Желіні күту',
    'Tarmoq kutmoqda',
    'شبكة الانتظار',
  ][_];

  final searchingSubtitle = [
    'Provide access',
    'Обеспечьте доступ',
    'Zugang gewähren',
    'Рұқсат беру',
    "Kirishni ta'minlash",
    'توفير إمكانية الوصول',
  ][_];

  final lastSyncPrefix = [
    'Synchronized',
    'Cинхронизировано',
    'Synchroniziert',
    'Синхрондалған',
    'Sinxronlashtirildi',
    'متزامن',
  ][_];

  final idle = [
    'Connected',
    'Подключено',
    'Verbunden',
    'Қосылған',
    'Ulangan',
    'متصل',
  ][_];
  final fetchedCounts = [
    'Pieces downloaded',
    'Скачано данных',
    'Heruntergeladene Stücke',
    'Бөліктер жүктелді',
    'Yuklab olingan qismlar',
    'القطع التي تم تنزيلها',
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
Bitte sicherstellen, dass das System keine Einschränkungen für den Zugang zum Internet hat.''',
    '''لا توجد حالياً شبكة واي فاي أو اتصال خلوي.
توفير قناة اتصال إنترنت واحدة على الأقل.
إذا تم تمكين وضع الطائرة، فإن الشبكة الخلوية غير متوفرة,
ولكن يمكنك استخدام اتصالات wifi إذا كانت متوفرة.
إذا كان جهازك يحتوي على آليات تقييد الوصول إلى الشبكة,
تأكد من منح جميع الأذونات للتطبيق.
تأكد من أن النظام ليس لديه أي قيود على الوصول إلى الإنترنت''',
    '''Қазіргі уақытта wifi немесе ұялы байланыс жоқ.
Интернетке қосылудың кем дегенде бір арнасын қамтамасыз етіңіз.
Егер ұшақ режимі қосылған болса, онда ұялы желі қол жетімді емес,
бірақ қол жетімді болса, wifi қосылымдарын пайдалануға болады.
Егер сіздің құрылғыңызда желіге кіруді шектеу механизмдері болса,
қолданбаға барлық рұқсаттардың берілгеніне көз жеткізіңіз.
Жүйеде интернетке кіруге ешқандай шектеулер жоқ екеніне көз жеткізіңіз''',
    '''Hozirda simsiz yoki uyali aloqa mavjud emas.
Kamida bitta internetga kirish kanalini taqdim eting.
Agar samolyot rejimi yoqilgan bo'lsa, u holda uyali tarmoq mavjud emas,
agar mavjud bo'lsa, siz ulanishlardan foydalanishingiz mumkin.
Agar qurilmangizda tarmoqqa kirishni cheklash mexanizmlari mavjud bo'lsa,
ilovaga barcha ruxsatlar berilganligiga ishonch hosil qiling.
Tizimda internetga kirishda hech qanday cheklovlar yo'qligiga ishonch hosil qiling''',
  ][_];
}
