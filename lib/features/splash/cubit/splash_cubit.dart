import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/features/home/presentation/pages/home_screen.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startTime() async {
    var duration = const Duration(seconds: 1);
    Timer(duration, go);
  }

  void go() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const HomeScreen());
  }
}
