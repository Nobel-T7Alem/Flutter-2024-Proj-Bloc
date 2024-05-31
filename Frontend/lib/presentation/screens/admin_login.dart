import 'package:Sebawi/data/models/validate_form.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/admin_login/admin_login_bloc.dart';
import '../Events/admin_login_event.dart';
import '../States/admin_login_state.dart';
import '../widgets/custom_button.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLoginBloc()..add(const AdminLoginInitialEvent()),
      child: BlocListener<AdminLoginBloc, AdminLoginState>(
        listener: (context, state) {
          if (state is AdminLoginSuccess) {
            context.go('/admin_page');
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go('/');
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white,),
              ),
              title: const Text('Admin Login Page', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
              backgroundColor: Colors.green[700],
            ),
            body: BlocBuilder<AdminLoginBloc, AdminLoginState>(
                builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextFormField(
                          labelText: "Enter Admin Username",
                          obscureText: false,
                          onChange: (val) {
                            BlocProvider.of<AdminLoginBloc>(context).add(
                                UsernameChangedEvent(
                                    username: ValidateForm(value: val!)));
                          }),
                      CustomTextFormField(
                          labelText: "Enter Admin Password",
                          obscureText: true,
                          onChange: (val) {
                            BlocProvider.of<AdminLoginBloc>(context).add(
                                PasswordChangedEvent(
                                    password: ValidateForm(value: val!)));
                          }),
                      if (state.apiError != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Text(
                            state.apiError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 40),
                      CustomButton(
                          buttonText: 'Login',
                          buttonColor: const Color.fromARGB(255, 83, 171, 71),
                          buttonTextColor: Colors.white,
                          buttonAction: () {
                            BlocProvider.of<AdminLoginBloc>(context)
                                .add(const AdminLoginSubmitted(username: '', password: ''));
                          }),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
