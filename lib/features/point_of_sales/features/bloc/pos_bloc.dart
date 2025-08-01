import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotura/features/point_of_sales/domain/repository%20.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:infotura/features/point_of_sales/features/bloc/pos_event.dart';
import 'package:infotura/features/point_of_sales/features/bloc/pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  final BillRepository repository;
  final InternetConnectionChecker internetChecker;

  PosBloc(this.repository, this.internetChecker) : super(const Initial()) {
    on<AddBill>((event, emit) async {
      try {
        // ✅ Always save bill locally first
        await repository.saveBillLocally(event.bill);

        // ✅ If online, also sync with server
        final isOnline = await internetChecker.hasConnection;
        if (isOnline) {
          await repository.syncBillToServer(event.bill);
        }
      } catch (e) {
        emit(PosState.error("Failed to add bill: $e"));
      }
    });

    on<LoadSalesList>((event, emit) async {
      emit(const PosState.loading());
      try {
        final isOnline = await internetChecker.hasConnection;

        if (isOnline) {
          // ✅ Sync all unsynced local bills to server
          await repository.syncUnsyncedBills();

          // ✅ Optionally refresh local cache from server
          final remoteBills = await repository.getRemoteBills();

          // ✅ You can update local cache here too if needed
          await repository.cacheBillsLocally(remoteBills);

          emit(PosState.loaded(remoteBills));
        } else {
          // ✅ Load only local bills if offline
          final localBills = await repository.getLocalBills();
          emit(PosState.loaded(localBills));
        }
      } catch (e) {
        emit(PosState.error("Failed to load bills: $e"));
      }
    });
  }
}
