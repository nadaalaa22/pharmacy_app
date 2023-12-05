
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/pharmacy/data/datasource/cart_remote_ds.dart';
import 'package:pharmacy_app/pharmacy/data/datasource/medicine_remote_ds.dart';
import 'package:pharmacy_app/pharmacy/data/datasource/user_order_remote_ds.dart';
import 'package:pharmacy_app/pharmacy/presentation/bloc/cart/cart_bloc.dart';
import 'package:pharmacy_app/pharmacy/presentation/bloc/medicine/medicine_bloc.dart';
import 'package:pharmacy_app/pharmacy/presentation/bloc/user_order/user_order_bloc.dart';
import 'package:pharmacy_app/user/data/datasorce/authentication_remote_ds/authentication.dart';
import 'package:pharmacy_app/core/db_helper.dart';
import 'package:pharmacy_app/user/data/datasorce/user_remote_ds/user_remote_ds.dart';
import 'package:pharmacy_app/user/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:pharmacy_app/user/presentation/bloc/user_data_bloc/user_data_bloc.dart';
import 'package:pharmacy_app/user/presentation/pages/login_page.dart';
import 'package:pharmacy_app/user/presentation/pages/sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(Firebase.apps.first);
  //await AuthenticationImp().signOut() ;
  //MedicineRemoteDsImpl(dbHelper: RemoteDBHelperImp()).setMedicines() ;
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc(AuthenticationImp(),UserDBModelImp(dbHelper:RemoteDBHelperImp()) )),
          BlocProvider<UserDataBloc>(create: (context) => UserDataBloc(UserDBModelImp(dbHelper:RemoteDBHelperImp()))),
          BlocProvider<MedicineBloc>(create: (context) => MedicineBloc(MedicineRemoteDsImpl(dbHelper:RemoteDBHelperImp()))),
          BlocProvider<CartBloc>(create: (context) => CartBloc(cartRemoteDs: CartRemoteDsImpl(dbHelper: RemoteDBHelperImp()))),
          BlocProvider<UserOrderBloc>(create: (context) => UserOrderBloc(UserOrderRemoteDsImpl(dbHelper: RemoteDBHelperImp()))),
        ],
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

