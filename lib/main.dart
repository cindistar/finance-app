import 'package:finance_app/presentation/graphics/controller/graphics_controller.dart';
import 'package:finance_app/presentation/home/controller/transactions_controller.dart';
import 'package:finance_app/presentation/income/controller/add_transaction_controller.dart';
import 'package:finance_app/presentation/profile/controller/profile_controller.dart';
import 'package:finance_app/presentation/splash/controller/splash_controller.dart';
import 'package:finance_app/presentation/transactions/controller/update_transaction_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'locator.dart';
import 'locator.dart' as locator;
import 'my_app.dart';
import 'presentation/expenses/controller/expenses_controller.dart';
import 'presentation/income/controller/income_controller.dart';
import 'presentation/login/controller/auth_controller.dart';
import 'presentation/transactions/controller/delete_transaction_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  locator.setup();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => UpdateTransactionController(
            transactionsRepository: getIt(),
            authRepository: getIt(),
          ),
        ),
        Provider(
          create: (_) => DeleteTransactionController(
            transactionsRepository: getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddTransactionController(
            transactionsRepository: getIt(),
            authRepository: getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileController(
            authRepository: getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SplashController(
            authRepository: getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthController(
            authRepository: getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ExpensesController(
            transactionRepository: getIt(),
            authRepository: getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => IncomeController(
            transactionsRepository: getIt(),
            authRepository: getIt(),
          ),
        ),
        Provider(
          create: (_) => TransactionsController(
            transactionsRepository: getIt(),
            authRepository: getIt(),
          ),
        ),
        Provider(
          create: (_) => GraphicsController(
            transactionsRepository: getIt(),
            authRepository: getIt(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
  //
}
