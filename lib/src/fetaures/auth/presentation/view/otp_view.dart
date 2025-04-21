import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/model/set_pin_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_event.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_state.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/view/log_in.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/view/exams_view.dart';
import 'package:pinput/pinput.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key, this.pinCode, this.userId});
  final String? pinCode;
  final int? userId;

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String enteredPin = "";

  @override
  Widget build(BuildContext context) {
    print('UserId: ${widget.userId}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Code'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(const LogoutRequested());
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthPinSuccess) {
            print('Success');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ExamsView(userId: widget.userId),
              ),
            );
          }
          if (state is AuthFailure) {
            print('Error: ${state.error}');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Xəta baş verdi')),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.pinCode == null
                      ? Text('Set Pin Code',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))
                      : Text('Enter Pin Code',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Pinput(
                    length: 4,
                    keyboardType: TextInputType.number,
                    onCompleted: (pin) {
                      enteredPin = pin;

                      final userId = widget.userId ?? 0;
                      print('UserId: $userId');
                      final request = SetPinRequestModel(
                        userId: userId,
                        pinCode: enteredPin,
                      );
                      print('Request1: ${request.userId} ${request.pinCode} ');

                      if (widget.pinCode == null || widget.pinCode!.isEmpty) {
                        print('Set Pin: ${request.pinCode}');
                        BlocProvider.of<AuthBloc>(context)
                            .add(SetPinEvent(request));
                      } else {
                        print('Check Pin: ${request.pinCode}');

                        BlocProvider.of<AuthBloc>(context)
                            .add(CheckPinEvent(request));
                      }
                    },
                  ),
                  if (state is AuthLoading) ...[
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
