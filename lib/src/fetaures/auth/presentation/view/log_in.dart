import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/model/login_request_model.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_bloc.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_event.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/bloc/auth_state.dart';
import 'package:online_exam_app/src/fetaures/auth/presentation/view/register.dart';
import 'package:online_exam_app/src/fetaures/exam/presentation/view/exams_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'Email cannot be empty' : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) =>
                        value!.isEmpty ? 'Password cannot be empty' : null,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                    if (state is AuthLoginSuccess) {
                      print('${state.loginModel?.userId}');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExamsView(
                                    userId: state.loginModel?.userId,
                                  )));
                    }
                    if (state is AuthFailure) {
                      print('Xetaaa: ${state.error}');
                    }
                  }, builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        _validate();
                      },
                      child: Text('Login'),
                    );
                  })
                ],
              )),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterView()),
                  );
                },
                child: Text('Create an account'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _validate() {
    _formkey.currentState?.validate();

    BlocProvider.of<AuthBloc>(context).add(
      LoginRequested(
        LoginRequest(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      ),
    );
  }
}
