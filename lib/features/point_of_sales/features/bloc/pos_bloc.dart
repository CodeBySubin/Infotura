import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotura/features/point_of_sales/domain/repository/repository%20.dart';
import '../bloc/pos_event.dart';
import '../bloc/pos_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  final BillRepository repository;
  final InternetConnectionChecker internetChecker;
  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;

  PosBloc(this.repository, this.internetChecker) : super(PosState.initial()) {
    on<AddBill>(_onAddBill);
    on<LoadSalesList>(_onLoadSalesList);

    _connectionSubscription = internetChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        add(LoadSalesList());
      }
    });
  }

  Future<void> _onAddBill(AddBill event, Emitter<PosState> emit) async {
    try {
      await repository.saveBillLocally(event.bill);
      if (await internetChecker.hasConnection) {
        await repository.syncBillToServer(event.bill);
      }
    } catch (e) {
      emit(PosState.error("Failed to add bill: $e"));
    }
  }

  Future<void> _onLoadSalesList(LoadSalesList event, Emitter<PosState> emit) async {
    emit(PosState.loading());
    try {
      final isOnline = await internetChecker.hasConnection;
      if (isOnline) {
        await repository.syncUnsyncedBills();
        final remoteBills = await repository.getRemoteBills();
        final remoteIds = remoteBills.map((e) => e.id).toList();
        await repository.cleanUpLocalStorage(remoteIds);
        await repository.cacheBillsLocally(remoteBills);
        emit(PosState.loaded(remoteBills));
      } else {
        final localBills = await repository.getLocalBills();
        emit(PosState.loaded(localBills));
      }
    } catch (e) {
      emit(PosState.error("Failed to load bills: $e"));
    }
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}