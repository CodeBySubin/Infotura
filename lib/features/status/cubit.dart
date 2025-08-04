import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum InternetStatus { connected, disconnected }

class InternetCubit extends Cubit<InternetStatus> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription _subscription;

  InternetCubit() : super(InternetStatus.connected) {
    _subscription = _connectivity.onConnectivityChanged.listen((_) => _checkConnection());
    _checkConnection(); 
  }
  Future<void> _checkConnection() async {
    final isConnected = await InternetConnectionChecker.createInstance().hasConnection;
    emit(isConnected ? InternetStatus.connected : InternetStatus.disconnected);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
