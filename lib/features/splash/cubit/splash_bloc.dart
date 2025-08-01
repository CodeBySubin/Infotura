import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.initial());

  Future<void> initialize() async {
    emit(const SplashState.loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(const SplashState.loaded());
  }
}
