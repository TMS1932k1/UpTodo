import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/business_logic/blocs/del_task/del_task_bloc.dart';
import 'package:todo_app/business_logic/blocs/load_tasks/load_tasks_bloc.dart';
import 'package:todo_app/business_logic/cubits/auth/auth_loading_cubit.dart';
import 'package:todo_app/business_logic/cubits/home/add_loading_cubit.dart';
import 'package:todo_app/business_logic/cubits/search/search_cubit.dart';
import 'package:todo_app/business_logic/cubits/sort/sort_cubit.dart';
import 'package:todo_app/presentation/screens/auth/auth_screen.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/presentation/screens/intro/intro_screen.dart';
import 'package:todo_app/themes/themes.dart';

bool? isFirst;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set orientation only portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Init firebase on app
  await Firebase.initializeApp();

  // Get [isFirst] in SF, check this is first run app
  final prefs = await SharedPreferences.getInstance();
  isFirst = prefs.getBool('isFirst');
  await prefs.setBool('isFirst', true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthLoadingCubit>(
          create: (context) => AuthLoadingCubit(),
        ),
        BlocProvider<AddLoadingCubit>(
          create: (context) => AddLoadingCubit(),
        ),
        BlocProvider<LoadTaskBloc>(
          create: (context) => LoadTaskBloc(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
        BlocProvider<SortCubit>(
          create: (context) => SortCubit(),
        ),
        BlocProvider<DelTaskBloc>(
          create: (context) => DelTaskBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeLight,
        darkTheme: themeDark,
        debugShowCheckedModeBanner: false,
        home: (isFirst == null || !isFirst!)
            ? const IntroScreen()
            : StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const HomeScreen();
                  } else {
                    return const AuthScreen();
                  }
                },
              ),
      ),
    );
  }
}
