import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qwiker_rider/core/di/dependency_injection.dart';
import 'package:qwiker_rider/core/global_functions.dart';
import 'package:qwiker_rider/core/routing/views_name.dart';
import 'package:qwiker_rider/features/home/presentation/view/home_view.dart';
import 'package:qwiker_rider/features/profile/presentation/view/complete_profile_data.dart';
import 'package:qwiker_rider/features/auth/presentation/view/login_view.dart';
import 'package:qwiker_rider/features/auth/presentation/view/pin_code_input_view.dart';
import 'package:qwiker_rider/features/onpoarding/view/onpoarding_view.dart';
import 'package:qwiker_rider/features/request_ride/data/request_ride_repo_imple/request_ride_repo_imple.dart';
import 'package:qwiker_rider/features/request_ride/presentation/manager/request_a_ride_cubit/request_a_ride_cubit.dart';
import 'package:qwiker_rider/features/request_ride/presentation/manager/serch_place_cubit/search_place_cubit.dart';
import 'package:qwiker_rider/features/request_ride/presentation/view/confirm_ride_view.dart';
import 'package:qwiker_rider/features/request_ride/presentation/view/search_view.dart';
import 'package:qwiker_rider/features/request_ride/presentation/widgets/on_going_tirp_view.dart';

class AppRouter {
  final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        // return const TestUiView();
        if (isFirstTime ?? false) {
          return const OnBoardingView();
        } else if (FirebaseAuth.instance.currentUser == null) {
          return const LogInView();
        } else if (hasProfile ?? false) {
          return const HomeView();
        } else {
          return const CompleteProfileDataView();
        }
      },
    ),
    GoRoute(
      name: ViewsName.logInView,
      path: ViewsName.logInView,
      builder: (context, state) => const LogInView(),
    ),
    GoRoute(
      name: ViewsName.completeProfileInfoView,
      path: ViewsName.completeProfileInfoView,
      builder: (context, state) => const CompleteProfileDataView(),
    ),
    GoRoute(
      path: ViewsName.pinCodeInputView,
      builder: (context, state) => const PinCodeInputView(),
    ),
    GoRoute(
      name: ViewsName.homeView,
      path: ViewsName.homeView,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: ViewsName.searchView,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchPlaceCubit(
                requestRideRepoImple: getIt<RequestRideRepoImple>()),
          ),
          BlocProvider.value(
            value: getIt<RequestARideCubit>(),
          ),
        ],
        child: const SearchView(),
      ),
    ),
    GoRoute(
      path: ViewsName.confirmRideView,
      builder: (context, state) => const ConfirmRideView(),
    ),
    GoRoute(
        path: ViewsName.onGoingTrip,
        builder: (context, state) => const OnGoingTripView()),
  ]);
}
