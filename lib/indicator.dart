import 'package:app_logs/app_logs.dart';
import 'package:conn_core/conn_core.dart';
import 'package:conn_views/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_utils/functions.dart';

class ConnIndicator extends StatelessWidget {
  const ConnIndicator({this.idleTitle});

  final String? idleTitle;

  String lineStatusToString(LineStatus ls) {
    switch (ls) {
      case LineStatus.searching:
        return txt.searchingTitle;
      case LineStatus.waiting:
        return txt.problemsTitle;
      case LineStatus.connecting:
        return txt.connecting;
      case LineStatus.fetching:
        return txt.fetching;
      case LineStatus.idle:
        return txt.idle;
      case LineStatus.disconnecting:
        return txt.disconnecting;
      default:
        return txt.disconnected;
    }
  }

  @override
  Widget build(BuildContext context) {
    String mapLineStatus(LineStatus ls) {
      if (ls == LineStatus.idle && idleTitle != null) return idleTitle!;
      return lineStatusToString(ls);
    }

    return Consumer<LineConnectivityStatus>(builder:
        (BuildContext context, LineConnectivityStatus line, Widget? child) {
      final iconPlaceholder = Container(
        width: 48,
        height: 48,
      );

      Widget central() {
        if (line.status == LineStatus.waiting)
          return _ReconnectWaitingLabel(line: line);
        if (line.status == LineStatus.searching) return _SearchingLabel();
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            mapLineStatus(line.status),
            style:
                TextStyle(fontSize: line.status == LineStatus.idle ? 17 : 15),
            overflow: TextOverflow.fade,
          ),
          if (line.status == LineStatus.fetching && line.fetchedChunksCount > 2)
            Text(
              '${txt.fetchedCounts}: ${line.fetchedChunksCount}',
              style: const TextStyle(fontSize: 8),
              overflow: TextOverflow.fade,
            ),
          if (line.status != LineStatus.idle) LastSyncTextLabel()
        ]);
      }

      Widget leftWidget() {
        if (line.err != null)
          return IconButton(
              icon: Stack(children: [
                const Icon(Icons.warning),
                if (line.errCount > 1)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            line.errCount < 2 ? '' : '${line.errCount}',
                            textScaleFactor: 0.6,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  )
              ]),
              onPressed: () {
                final report = AppLogger.items();
                _showMsg(context, line.err.toString(), report);
              });
        if (line.status == LineStatus.searching)
          return IconButton(
              icon:
                  const Icon(Icons.signal_cellular_connected_no_internet_4_bar),
              onPressed: () {
                // TODO(n): reachability must SHOW SYSTEM STATE on/off wifi / net /airplane mode / restrictions
                _showMsg(
                  context,
                  txt.searchingExplanation,
                );
              });
        return iconPlaceholder;
      }

      Widget rightWidget() {
        if ([LineStatus.waiting, LineStatus.disconnected].contains(line.status))
          return IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final conn =
                  Provider.of<ConnectionService>(context, listen: false);
              conn.manualConnect();
            },
          );
        else if (line.status == LineStatus.idle)
          return iconPlaceholder;
        else
          return Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(15),
            child: const CircularProgressIndicator(
              strokeWidth: 1.8,
              //valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
      }

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (line.status != LineStatus.idle || line.err != null) leftWidget(),
          Flexible(
              child: GestureDetector(
            child: central(),
            onLongPress: () {
              _showMsg(context, line.err?.toString() ?? '', AppLogger.items());
            },
          )),
          if (line.status != LineStatus.idle || line.err != null) rightWidget()
        ],
      );
    });
  }

  void _showMsg(BuildContext context, String msg, [Iterable<LogItem>? logs]) =>
      showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 800,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: errorInfoWidget(msg, logs ?? [], context),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });

  Column errorInfoWidget(
      String msg, Iterable<LogItem> logs, BuildContext context) {
    Color levelColor(String? l) {
      final darkMode =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      switch (l) {
        case 'E':
          return darkMode ? Colors.red[400]! : Colors.red[700]!;
        case 'W':
          return darkMode ? Colors.orange[300]! : Colors.orange[800]!;
        case 'S':
          return darkMode ? Colors.green[300]! : Colors.green[800]!;
        case 'I':
          return darkMode ? Colors.white : Colors.black;
        default:
          return darkMode ? Colors.grey[400]! : Colors.grey[800]!;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            msg,
            textScaleFactor: 0.9,
            style: TextStyle(color: Colors.red[700]),
          ),
        ),
        ...logs.map(
          (l) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: l.toString().substring(0, 22),
                style: TextStyle(fontSize: 6, color: levelColor(null)),
                children: [
                  TextSpan(
                    text: l.toString().substring(22, l.toString().length),
                    style: TextStyle(
                      fontSize: 8,
                      color: levelColor(l.toString()[17]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchingLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThreeRowWidget(
      title: txt.searchingTitle,
      subtitle: txt.searchingSubtitle,
      lastSyncWidget: LastSyncTextLabel(),
    );
  }
}

class _ReconnectWaitingLabel extends StatelessWidget {
  const _ReconnectWaitingLabel({Key? key, required this.line})
      : super(key: key);
  final LineConnectivityStatus line;

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoReconnect>(
      builder: (context, ar, child) {
        final title =
            ar.waitingForMaintenance ? txt.maintenanceTitle : txt.problemsTitle;
        final time = beautyTime(ar.secsBeforeReconnect);
        final subtitle = '${txt.secsBeforeReconnect} $time';

        return ThreeRowWidget(
            title: title, subtitle: subtitle, lastSyncWidget: child!);
      },
      child: LastSyncTextLabel(),
    );
  }
}

class ThreeRowWidget extends StatelessWidget {
  const ThreeRowWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.lastSyncWidget})
      : super(key: key);
  final String title;
  final String subtitle;
  final Widget lastSyncWidget;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 13),
            overflow: TextOverflow.fade,
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
          ),
          lastSyncWidget,
          const SizedBox(height: 2),
        ],
      );
}

class LastSyncTextLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LineConnectivityStatus>(builder: (context, line, _) {
      if (line.lastSync == null) return SizedBox.shrink();
      final s = formattedDateTime(line.lastSync!, adaptiveToNow: true);
      return Text(
        '${txt.lastSyncPrefix}: $s',
        style: const TextStyle(fontSize: 8),
        overflow: TextOverflow.fade,
      );
    });
  }
}
