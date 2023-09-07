import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_app/bloc/categories/categories_bloc.dart';
import 'package:flutter_fic7_app/bloc/logout/logout_bloc.dart';
import 'package:flutter_fic7_app/bloc/products/products_bloc.dart';
import 'package:flutter_fic7_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic7_app/pages/auth/auth_page.dart';
import 'package:flutter_fic7_app/pages/dashboard/dashboard_page.dart';
import 'package:flutter_fic7_app/pages/splash/splash_page.dart';
import 'package:flutter_fic7_app/utils/light_themes.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!) {
                return const DashboardPage();
              } else {
                return const AuthPage();
              }
            },
          )),
    );
  }
}
