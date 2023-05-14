import 'package:booking_car/blocs/bloc/auth/auth_bloc.dart';
import 'package:booking_car/blocs/cubit/car/car_cubit.dart';
import 'package:booking_car/blocs/cubit/car_expense/car_expense_cubit.dart';
import 'package:booking_car/blocs/cubit/car_info/car_info_cubit.dart';
import 'package:booking_car/blocs/cubit/car_schedule/car_schedule_cubit.dart';
import 'package:booking_car/blocs/cubit/categories/categories_cubit.dart';
import 'package:booking_car/blocs/cubit/contract_group/contract_group_cubit.dart';
import 'package:booking_car/blocs/cubit/maintenance/maintenance_cubit.dart';
import 'package:booking_car/blocs/cubit/receive_contract/receive_contract_cubit.dart';
import 'package:booking_car/blocs/cubit/registry/registry_cubit.dart';
import 'package:booking_car/blocs/cubit/rent_contract/rent_contract_cubit.dart';
import 'package:booking_car/blocs/cubit/transfer_contract/transfer_contract_cubit.dart';
import 'package:booking_car/constants.dart';
import 'package:booking_car/navigation_drawer.dart';
import 'package:booking_car/resources/repositories/repositories.dart';
import 'package:booking_car/screens/auth/login_screen.dart';
import 'package:booking_car/splash/splash_screen.dart';
import 'package:booking_car/models/contract_group.dart';
import 'package:booking_car/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:booking_car/blocs/cubit/user/user_cubit.dart';
import 'package:sizer/sizer.dart';
import 'router/router_generation.dart' as router;

Future<void> main() async {
  final userRepository = UserRepository();
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: primaryColor,
      statusBarBrightness: Brightness.dark));
  await Firebase.initializeApp(
    name: "booking_car",
    options: FirebaseOptions(
        apiKey: "AIzaSyD4MTes4cfF7Z8fG0VWTEURgjub4eVT0cY",
        appId: "1:446393418311:android:a705192b3b5bcf1ae8e762",
        messagingSenderId: "446393418311",
        storageBucket: "carmanaager-upload-file.appspot.com",
        projectId: "carmanaager-upload-file"),
  );
  configLoading();
  runApp(MultiProvider(providers: [
    BlocProvider(create: (_) => CarCubit()),
    BlocProvider(create: (_) => InfoCubit()),
    BlocProvider(create: (_) => ContractGroupCubit()),
    BlocProvider(create: (_) => TransferContractCubit()),
    BlocProvider(create: (_) => ReceiveContractCubit()),
    BlocProvider(create: (_) => UserCubit()..getUser),
    BlocProvider(create: (_) => RentContractCubit()),
    BlocProvider(create: (_) => MaintenanceCubit()),
    BlocProvider(create: (_) => RegistryCubit()),
    BlocProvider(create: (_) => CarScheduleCubit()),
    BlocProvider(create: (_) => CarExpenseCubit()),
    BlocProvider(create: (_) => CategoriesCubit()..loadCategories()),
    BlocProvider<AuthBloc>(create: (context) {
      return AuthBloc(userRepository: userRepository)..add(AppStarted());
    }),
  ], child: MyApp(userRepository: userRepository)));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  MyApp({Key? key, required this.userRepository}) : super(key: key);

  // This widget is the root of your application.
  Locale? _locale;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ATSHARE',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: EasyLoading.init(),
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      onGenerateRoute: router.Router.generateRoute,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFFEEF1F8),
        primarySwatch: primarySwatch,
        fontFamily: "Intel",
        textTheme: TextTheme(
            // bodyText2: TextStyle(fontWeight: FontWeight.w400),
            ),
        dividerColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      // home: const OnbodingScreen(),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return SplashScreen();
          }
          if (state is AuthAuthenticated) {
            return NavigationHomeScreen();
          }

          if (state is AuthUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }

          if (state is AuthLoading) {
            return LoadingIndicator();
          }
          return LoadingIndicator();
        }, // home: HomeScreen(),
      ),
    );
  }
  // static _MyAppState of(BuildContext context) =>
  //     context.findAncestorStateOfType<_MyAppState>()!;
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                strokeWidth: 4.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
/*
#####################################################################
#	Nhân quả không nợ chúng ta thứ gì, cho nên xin đừng oán giận	#
#                                _oo0oo_							#
#                               088888880							#
#                               88" . "88							#
#                              (| __ __ |)							#
#                                0\ = /0							#
#                             ___/'---'\___							#
#                           .' \\|     |// '. 						#
#                          / \\|||  :  |||// \\						#
#                         /_ ||||| -:- |||||- \\					#
#                        |   | \\\  -  /// |   |					#
#                        | \_|  ''\---/''  |_/ |					#
#                        \  .-\__  '-'  __/-.  /					#
#                      ___'. .'  /--.--\  '. .'___					#
#                   ."" '<  '.___\_<|>_/___.' >'  "". 				#
#                  | | : '-  \'.;'\ _ /';.'/ - ' : | |				#
#                  \  \ '_.   \_ __\ /__ _/   .-' /  /				#
#           =========='-.____'.___ \_____/___.-'____.-'==========	#
#       	                    '=---='								#
#																	#
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Đức Phật nơi đây phù hộ code con chạy không Bug. Nam mô a di đà Phật
*/