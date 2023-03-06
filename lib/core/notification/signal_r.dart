import 'package:flutter/foundation.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';

import '../constants/app_settings.dart';
import '../utils/shared_preferences/SharedPreferencesHelper.dart';

class SignalR {
  final serverUrl = "${AppSettings.baseUrl1}/signalr";
  HubConnection? hubConnection;
  int tryNumber = 10;

  start({required ValueChanged<Map> onReceived}) async {
    if (hubConnection != null &&
        hubConnection!.state == HubConnectionState.Connected) {
      return;
    }

    String token = AppSharedPreferences.accessToken;

    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl,
            options: HttpConnectionOptions(
                transport: HttpTransportType.LongPolling,
                accessTokenFactory: () async => token))
        .build();

    hubConnection!.onclose(
      ({error}) {
        if (kDebugMode) {
          print(error);
        }
      },
    );

    try {
      await hubConnection!.start();
      hubConnection!.on('getNotification', (arguments) {
        Map res = arguments!.single as Map;
        onReceived(res);
      });
      if (kDebugMode) {
        print('Signal R Connected');
      }
      tryNumber = 10;
    } catch (e) {
      if (kDebugMode) {
        print('Signal R error');
        print(e);
      }
      if (tryNumber >= 0) {
        if (kDebugMode) {
          print('Signal R reconnecting ...');
        }
        start(onReceived: onReceived);
        tryNumber--;
      }
    }
  }

  close() {
    if (kDebugMode) {
      print('Signal R closed');
    }
    if (hubConnection != null) hubConnection!.stop();
  }
}
