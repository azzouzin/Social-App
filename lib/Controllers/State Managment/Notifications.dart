import 'dart:async';
import 'dart:convert';
import 'dart:io';
// ignore: unnecessary_import
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutterlocalnotificationsexample');

const String portName = 'notificationsendport';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoidprint
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoidprint
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

/// IMPORTANT: running the following code on its own won't work as there is
/// setup required for each platform head project.
///
/// Please download the complete example app from the GitHub repository where
/// all the setup has been done
Future<void> configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

class PaddedElevatedButton extends StatelessWidget {
  const PaddedElevatedButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      );
}

class NotScreen extends StatelessWidget {
  NotController notcontroller = Get.put(NotController());
  final TextEditingController linuxIconPathController = TextEditingController();

  static const String routeName = '/';

  bool get didNotificationLaunchApp =>
      notcontroller.notificationAppLaunchDetails?.didNotificationLaunchApp ??
      false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Obx(() {
        return notcontroller.isloading == true
            ? Center(
                child: LinearProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Text(
                            'Tap on a notification when it appears to trigger'
                            ' navigation'),
                      ),
                      InfoValueString(
                        title: 'Did notification launch app?',
                        value: didNotificationLaunchApp,
                      ),
                      if (didNotificationLaunchApp) ...<Widget>[
                        const Text('Launch notification details'),
                        InfoValueString(
                            title: 'Notification id',
                            value: notcontroller.notificationAppLaunchDetails!
                                .notificationResponse?.id),
                        InfoValueString(
                            title: 'Action id',
                            value: notcontroller.notificationAppLaunchDetails!
                                .notificationResponse?.actionId),
                        InfoValueString(
                            title: 'Input',
                            value: notcontroller.notificationAppLaunchDetails!
                                .notificationResponse?.input),
                        InfoValueString(
                          title: 'Payload:',
                          value: notcontroller.notificationAppLaunchDetails!
                              .notificationResponse?.payload,
                        ),
                      ],
                      PaddedElevatedButton(
                        buttonText: 'Show plain notification with payload',
                        onPressed: () async {
                          await notcontroller.showNotification();
                        },
                      ),
                      PaddedElevatedButton(
                        buttonText:
                            'Show plain notification that has no title with '
                            'payload',
                        onPressed: () async {
                          await notcontroller.showNotificationWithNoTitle();
                        },
                      ),
                      PaddedElevatedButton(
                        buttonText:
                            'Show plain notification that has no body with '
                            'payload',
                        onPressed: () async {
                          await notcontroller.showNotificationWithNoBody();
                        },
                      ),
                      PaddedElevatedButton(
                        buttonText: 'Show notification with custom sound',
                        onPressed: () async {
                          await notcontroller.showNotificationCustomSound();
                        },
                      ),
                      if (kIsWeb || !Platform.isLinux) ...<Widget>[
                        PaddedElevatedButton(
                          buttonText:
                              'Schedule notification to appear in 5 seconds '
                              'based on local time zone',
                          onPressed: () async {
                            await notcontroller.zonedScheduleNotification();
                          },
                        ),
                        PaddedElevatedButton(
                          buttonText:
                              'Schedule notification to appear in 5 seconds '
                              'based on local time zone using alarm clock',
                          onPressed: () async {
                            await notcontroller
                                .zonedScheduleAlarmClockNotification();
                          },
                        ),
                        PaddedElevatedButton(
                          buttonText: 'Repeat notification every minute',
                          onPressed: () async {
                            await notcontroller.repeatNotification();
                          },
                        ),
                        PaddedElevatedButton(
                          buttonText:
                              'Schedule daily 10:00:00 am notification in your '
                              'local time zone',
                          onPressed: () async {
                            await notcontroller
                                .scheduleDailyTenAMNotification();
                          },
                        ),
                      ],
                      PaddedElevatedButton(
                        buttonText: 'Show notification with no sound',
                        onPressed: () async {
                          await notcontroller.showNotificationWithNoSound();
                        },
                      ),
                      const Divider(),
                      const Text(
                        'Notifications with actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      if (Platform.isAndroid) ...<Widget>[
                        const Text(
                          'Android-specific examples',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            'notifications enabled: $notcontroller.notificationsEnabled'),
                        PaddedElevatedButton(
                          buttonText: 'Request permission (API 33+)',
                          onPressed: () => notcontroller.requestPermissions(),
                        ),
                        PaddedElevatedButton(
                          buttonText:
                              'Show plain notification as public on every '
                              'lockscreen',
                          onPressed: () async {
                            await notcontroller.showPublicNotification();
                          },
                        ),
                        PaddedElevatedButton(
                          buttonText:
                              'Show notification that times out after 3 seconds',
                          onPressed: () async {
                            await notcontroller.showTimeoutNotification();
                          },
                        ),
                        PaddedElevatedButton(
                          buttonText: 'Show insistent notification',
                          onPressed: () async {
                            await notcontroller.showInsistentNotification();
                          },
                        ),
                      ],
                    ]),
                  ),
                ),
              );
      }),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage(
    this.payload, {
    Key? key,
  }) : super(key: key);

  static const String routeName = '/secondPage';

  final String? payload;

  @override
  State<StatefulWidget> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  String? payload;

  @override
  void initState() {
    super.initState();
    payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('payload ${payload ?? ''}'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ],
          ),
        ),
      );
}

class InfoValueString extends StatelessWidget {
  const InfoValueString({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String title;
  final Object? value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: '$title ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '$value',
              )
            ],
          ),
        ),
      );
}

class NotController extends GetxController {
  late NotificationAppLaunchDetails? notificationAppLaunchDetails;
  var isloading = true.obs;

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  Future<void> showNotificationWithNoBody() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
        id++, 'plain title', null, notificationDetails,
        payload: 'item x');
  }

  Future<void> showNotificationWithNoTitle() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin
        .show(id++, null, 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> showNotificationCustomSound() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      channelDescription: 'your other channel description',
      sound: RawResourceAndroidNotificationSound('slowspringboard'),
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      sound: 'slowspringboard.aiff',
    );
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      sound: AssetsLinuxSound('sound/slowspringboard.mp3'),
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id++,
      'custom sound notification title',
      'custom sound notification body',
      notificationDetails,
    );
  }

  Future<void> zonedScheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> zonedScheduleAlarmClockNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        123,
        'scheduled alarm clock title',
        'scheduled alarm clock body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'alarmclockchannel', 'Alarm Clock Channel',
                channelDescription: 'Alarm Clock Notification')),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showNotificationWithNoSound() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('silent channel id', 'silent channel name',
            channelDescription: 'silent channel description',
            playSound: false,
            styleInformation: DefaultStyleInformation(true, true));
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentSound: false,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
        macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
  }

  Future<void> showTimeoutNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('silent channel id', 'silent channel name',
            channelDescription: 'silent channel description',
            timeoutAfter: 3000,
            styleInformation: DefaultStyleInformation(true, true));
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'timeout notification',
        'Times out after 3 seconds', notificationDetails);
  }

  Future<void> showInsistentNotification() async {
    // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAGINSISTENT
    const int insistentFlag = 4;
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            additionalFlags: Int32List.fromList(<int>[insistentFlag]));
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, 'insistent title', 'insistent body', notificationDetails,
        payload: 'item x');
  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> repeatNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id++,
      'repeating title',
      'repeating body',
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleDailyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        nextInstanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  /// To test we don't validate past dates when using `matchDateTimeComponents`
  Future<void> cheduleDailyTenAMLastYearNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        nextInstanceOfTenAMLastYear(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime nextInstanceOfTenAMLastYear() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(tz.local, now.year - 1, now.month, now.day, 10);
  }

  tz.TZDateTime nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.monday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> showPublicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            visibility: NotificationVisibility.public);
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++,
        'public notification title',
        'public notification body',
        notificationDetails,
        payload: 'item x');
  }

  Future<Widget> getActiveNotificationsDialogContent() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 23) {
        return const Text(
          '"getActiveNotifications" is available only for Android 6.0 or newer',
        );
      }
    } else if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      final List<String> fullVersion = iosInfo.systemVersion!.split('.');
      if (fullVersion.isNotEmpty) {
        final int? version = int.tryParse(fullVersion[0]);
        if (version != null && version < 10) {
          return const Text(
            '"getActiveNotifications" is available only for iOS 10.0 or newer',
          );
        }
      }
    }

    try {
      final List<ActiveNotification>? activeNotifications =
          await flutterLocalNotificationsPlugin.getActiveNotifications();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Active Notifications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.black),
          if (activeNotifications!.isEmpty)
            const Text('No active notifications'),
          if (activeNotifications.isNotEmpty)
            for (ActiveNotification activeNotification in activeNotifications)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'id: ${activeNotification.id}\n'
                    'channelId: ${activeNotification.channelId}\n'
                    'groupKey: ${activeNotification.groupKey}\n'
                    'tag: ${activeNotification.tag}\n'
                    'title: ${activeNotification.title}\n'
                    'body: ${activeNotification.body}',
                  ),
                  if (Platform.isAndroid && activeNotification.id != null)
                    TextButton(
                      child: const Text('Get messaging style'),
                      onPressed: () {
                        getActiveNotificationMessagingStyle(
                            activeNotification.id!, activeNotification.tag);
                      },
                    ),
                  const Divider(color: Colors.black),
                ],
              ),
        ],
      );
    } on PlatformException catch (error) {
      return Text(
        'Error calling "getActiveNotifications"\n'
        'code: ${error.code}\n'
        'message: ${error.message}',
      );
    }
  }

  Future<void> getActiveNotificationMessagingStyle(int id, String? tag) async {
    Widget dialogContent;
    try {
      final MessagingStyleInformation? messagingStyle =
          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()!
              .getActiveNotificationMessagingStyle(id, tag: tag);
      if (messagingStyle == null) {
        dialogContent = const Text('No messaging style');
      } else {
        dialogContent = SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('person: ${formatPerson(messagingStyle.person)}\n'
                'conversationTitle: ${messagingStyle.conversationTitle}\n'
                'groupConversation: ${messagingStyle.groupConversation}'),
            const Divider(color: Colors.black),
            if (messagingStyle.messages == null) const Text('No messages'),
            if (messagingStyle.messages != null)
              for (final Message msg in messagingStyle.messages!)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('text: ${msg.text}\n'
                        'timestamp: ${msg.timestamp}\n'
                        'person: ${formatPerson(msg.person)}'),
                    const Divider(color: Colors.black),
                  ],
                ),
          ],
        ));
      }
    } on PlatformException catch (error) {
      dialogContent = Text(
        'Error calling "getActiveNotificationMessagingStyle"\n'
        'code: ${error.code}\n'
        'message: ${error.message}',
      );
    }
  }

  String formatPerson(Person? person) {
    if (person == null) {
      return 'null';
    }

    final List<String> attrs = <String>[];
    if (person.name != null) {
      attrs.add('name: "${person.name}"');
    }
    if (person.uri != null) {
      attrs.add('uri: "${person.uri}"');
    }
    if (person.key != null) {
      attrs.add('key: "${person.key}"');
    }
    if (person.important) {
      attrs.add('important: true');
    }
    if (person.bot) {
      attrs.add('bot: true');
    }
    if (person.icon != null) {
      attrs.add('icon: ${formatAndroidIcon(person.icon)}');
    }
    return 'Person(${attrs.join(', ')})';
  }

  String formatAndroidIcon(Object? icon) {
    if (icon == null) {
      return 'null';
    }
    if (icon is DrawableResourceAndroidIcon) {
      return 'DrawableResourceAndroidIcon("${icon.data}")';
    } else if (icon is ContentUriAndroidIcon) {
      return 'ContentUriAndroidIcon("${icon.data}")';
    } else {
      return 'AndroidIcon()';
    }
  }

  bool notificationsEnabled = false;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    // needed if you intend to initialize in the `main` function
    WidgetsFlutterBinding.ensureInitialized();

    await configureLocalTimeZone();

    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text(
            'text1',
            'Action 1',
            buttonTitle: 'Send',
            placeholder: 'Placeholder',
          ),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
          DarwinNotificationAction.plain(
            'id4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.authenticationRequired,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
      notificationCategories: darwinNotificationCategories,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    isAndroidPermissionGranted();
    requestPermissions();
    configureDidReceiveLocalNotificationSubject();
    configureSelectNotificationSubject();

    isloading.value = false;
  }

  @override
  void onClose() {
    // Close resources
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.onClose();
  }

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      notificationsEnabled = granted;
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();

      notificationsEnabled = granted ?? false;
    }
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      print(receivedNotification);
    });
  }

  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      Get.to(
        SecondPage(payload),
      );
    });
  }
}
