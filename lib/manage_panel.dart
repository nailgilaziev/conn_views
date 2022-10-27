import 'package:common_widgets/labeled_checkbox.dart';
import 'package:conn_core/conn_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnManagePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LineConnectivityStatus>(
      builder:
          (BuildContext context, LineConnectivityStatus line, Widget child) {
        return Consumer<WsConnectionService>(
          builder: (context, conn, _) {
            final connectCallback = !line.manualConnectAvailable
                ? null
                : () => conn.manualConnect();
            final closeCallback =
            !line.manualCloseAvailable ? null : () => conn.manualClose();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
//                  initialValue: conn.urlProvider.hostUrl,
                  decoration: const InputDecoration(
                      labelText: 'ws/wss url',
                      helperText: 'changes will be applied after reconnect',
                      hintText: 'wss://host.domain/events'),
//                  onFieldSubmitted: (t) => conn.urlProvider.hostUrl = t,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _AutoReconnectParamsPanel(),
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                            child: const Text('connect'),
                            onPressed: connectCallback,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                              child: const Text('disconnect'),
                              onPressed: closeCallback),
                          const SizedBox(width: 8),
                          ElevatedButton(
                              child: const Text('logs'),
                              onPressed: () => throw UnimplementedError()),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AutoReconnectParamsPanel extends StatefulWidget {
  @override
  __AutoReconnectParamsPanelState createState() =>
      __AutoReconnectParamsPanelState();
}

class __AutoReconnectParamsPanelState extends State<_AutoReconnectParamsPanel> {
  final controllerAttemptsCount = TextEditingController();
  final controllerSecs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoReconnect>(
      builder: (BuildContext context, AutoReconnect conf, Widget child) {
        controllerAttemptsCount.text = conf.immediatelyAttempts.toString();
        controllerSecs.text = conf.waitingSecs.toString();
        return Column(
          children: <Widget>[
            LabeledCheckbox(
              title: 'auto reconnect on failure',
              value: conf.on,
              onChanged: (bool v) => conf.on = v,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controllerAttemptsCount,
                    onChanged: (t) => conf.immediatelyAttempts = int.parse(t),
                    keyboardType: const TextInputType.numberWithOptions(),
                  ),
                ),
                const SizedBox(width: 8),
                const Flexible(
                  child: Text('reconnect immediately attempts count'),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controllerSecs,
                    onChanged: (t) => conf.waitingSecs = int.parse(t),
                    keyboardType: const TextInputType.numberWithOptions(),
                  ),
                ),
                const SizedBox(width: 8),
                const Flexible(child: Text('waiting secs before reconnect')),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controllerSecs.dispose();
    controllerAttemptsCount.dispose();
    super.dispose();
  }
}
