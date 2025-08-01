import 'package:flutter/material.dart';
import 'package:infotura/core/constants/app_colors.dart';

Widget loader({Color color = AppColors.primary}) {
  return Center(child: CircularProgressIndicator(color: color));
}
