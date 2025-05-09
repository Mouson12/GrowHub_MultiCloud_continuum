import 'package:flutter/material.dart';
import 'package:growhub/common/widgets/loading_screen.dart';
import 'package:growhub/config/routing.dart';
import 'package:growhub/config/themes/theme.dart';
import 'package:growhub/features/api/api_repository.dart';
import 'package:growhub/features/api/core/api_client.dart';
import 'package:growhub/features/api/core/auth_client.dart';
import 'package:growhub/features/api/cubit/alert/alert_cubit.dart';
import 'package:growhub/features/api/cubit/config_data/config_data_cubit.dart';
import 'package:growhub/features/api/cubit/device/device_cubit.dart';
import 'package:growhub/features/api/cubit/dosage_history/dosage_history_cubit.dart';
import 'package:growhub/features/api/cubit/user/user_cubit.dart';
import 'package:growhub/features/api/services/api_service.dart';
import 'package:growhub/features/api/services/auth_service.dart';
import 'package:growhub/features/api/services/secure_storage_service.dart';
import 'package:growhub/features/api/cubit/sensor/sensor_cubit.dart';
import 'package:growhub/features/bottom_app_bar/cubit/path_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Clients
    final authClient = AuthClient();
    final apiClient = ApiClient();

    // Services
    final authService = AuthService(authClient);
    final apiService = ApiService(apiClient);
    final secureStorageService = SecureStorageService();

    // Repository
    final apiRepository = ApiRepository(
      authService: authService,
      apiService: apiService,
      secureStorageService: secureStorageService,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DosageHistoryCubit(apiRepository)),
        BlocProvider(
            create: (context) => UserCubit(apiRepository)..autoLogin()),
        BlocProvider(
          create: (context) => SensorCubit(apiRepository),
        ),
        BlocProvider(
          create: (context) => PathCubit(),
        ),
        BlocProvider(
          create: (context) => AlertCubit(apiRepository),
        ),
        BlocProvider(
          create: (context) => DeviceCubit(apiRepository),
        ),
        BlocProvider(
          create: (context) => ConfigDataCubit(),
        ),
      ],
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserStateStartApp) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoadingScreen(),
            );
          }

          final isLoggedIn = state is UserStateLoaded;

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: GHRouter(isLoggedIn: isLoggedIn).router,
            theme: GHTheme.theme(context),
          );
        },
      ),
    );
  }
}
