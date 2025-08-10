import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:saas_mosque/features/room/features/home/presentation/presentation/screens/home_screen.dart';
import 'package:saas_mosque/features/room/presentation/screens/room_screen.dart';
import 'package:saas_mosque/features/splash/presentation/screen/splash_screen.dart';
import 'package:saas_mosque/injection_container.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/campaigns/presentation/bloc/campaigns_bloc.dart';
import '../../features/campaigns/presentation/screens/campaigns_screen.dart';
import '../../features/room/features/home/presentation/presentation/bloc/home_bloc_bloc.dart';

part 'router_config.main.dart';
