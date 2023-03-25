import 'package:device_preview/device_preview.dart';
import 'package:ecom_clean_code/app/router/app_router.dart';
import 'package:ecom_clean_code/app/theme/theme_data.dart';
import 'package:ecom_clean_code/features/home/presentation/cubit/product_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/categories/presentation/cubit/category_cubit.dart';
import 'features/login/presentation/blocs/login_cubit.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (_) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CategoryCubit>(),
        ),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Ecommerce App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        onGenerateRoute: _appRouter.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}
