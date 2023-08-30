import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/data/cart_items.dart';
import 'package:flutter_bloc_tutorial/features/admin/bloc/admin_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/error/bloc/error_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/login/ui/loginPage.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/admin_product_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/product_bloc.dart';
import 'package:flutter_bloc_tutorial/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        Provider<CartRepo>(
          create: (context) => CartRepo(),
        ),
        BlocProvider(
            create: (context) =>
                HomeBloc(Provider.of<CartRepo>(context, listen: false))),
        BlocProvider(
            create: (context) =>
                CartBloc(Provider.of<CartRepo>(context, listen: false))),
        BlocProvider(
            create: (context) =>
                ProductBloc(Provider.of<CartRepo>(context, listen: false))),
        BlocProvider<ErrorBloc>(create: (context) => ErrorBloc(), lazy: false),
        BlocProvider(create: (context) => AdminBloc()),
        BlocProvider(create: (context) => AdminProductBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
          useMaterial3: true,
        ),
        home: Login(),
      ),
    );
  }
}
