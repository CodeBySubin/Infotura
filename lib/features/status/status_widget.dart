import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotura/features/status/cubit.dart';

class InternetStatusScreen extends StatelessWidget {
  const InternetStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetStatus>(
      builder: (context, status) {
        final isConnected = status == InternetStatus.connected;
        return Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: isConnected ? Colors.green : Colors.red,
            ),
            child: Text(
              isConnected ? 'Online' : 'Offline',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
