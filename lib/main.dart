// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:worldbook/logic/cubit/sort_group_cubit.dart';
import 'package:worldbook/presentation/screens/homescreen.dart';
import 'package:worldbook/services/countries.dart';
import 'package:worldbook/themes/darktheme.dart';
import 'package:worldbook/themes/lighttheme.dart';

import 'logic/bloc/country_bloc.dart';
import 'logic/bloc_observer.dart';



void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  BlocOverrides.runZoned(
        () => runApp(const MyApp()),
    blocObserver: CountryBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Countries>(
        create: (context) => Countries(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CountryBloc>(
              create: (context) => CountryBloc(
                countries:
                RepositoryProvider.of<Countries>(context),
              ),
            ),
            BlocProvider<SortGroupCubit>(
              create: (context) => SortGroupCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const HomeScreen(),
          ),
        ));
  }
}

