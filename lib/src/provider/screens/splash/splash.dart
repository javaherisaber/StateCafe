import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_cafe/base/resourceful_state.dart';
import 'package:state_cafe/src/provider/routes.dart';
import 'package:state_cafe/src/provider/screens/splash/splash_notifier.dart';
import 'package:state_cafe/widgets/view/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashNotifier(),
      child: const _SplashContent(),
    );
  }
}

class _SplashContent extends StatefulWidget {
  const _SplashContent();

  @override
  State<_SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends ResourcefulState<_SplashContent> {
  @override
  void onReady() {
    super.onReady();
    context.read<SplashNotifier>().onReady();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = context.watch<SplashNotifier>();
    if (notifier.shouldNavigateToHome) {
      notifier.consumeNavigation();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, ProviderRoutes.home);
      });
    } else if (notifier.shouldNavigateToLogin) {
      notifier.consumeNavigation();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, ProviderRoutes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SplashView();
  }
}
