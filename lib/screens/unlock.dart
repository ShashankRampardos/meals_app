import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meals_app/screens/tabs.dart';

class UnlockScreen extends StatefulWidget {
  const UnlockScreen({super.key});

  @override
  State<UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends State<UnlockScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool? canAuthenticate;

  @override
  initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showBottomSheet();
    // });
    _checkBiometrics();
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticateUser());
  }

  Future<void> _checkBiometrics() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool isDeviceSupported = await auth.isDeviceSupported();
    setState(() {
      canAuthenticate = canAuthenticateWithBiometrics || isDeviceSupported;
    });
  }

  Future<void> _authenticateUser() async {
    try {
      final bool isAuthenticated = await auth.authenticate(
        localizedReason:
            'Please scan the finger print of use password/pattern to unlock meals app',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      if (isAuthenticated && mounted) {
        Navigator.pop(context); // close bottom sheet
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => const TabsScreen()),
        );
      }
    } catch (e) {
      print('Auth failed: $e');
    }
  }

  // void _showBottomSheet() {
  //   showModalBottomSheet(
  //     useSafeArea: true,
  //     isDismissible: true,
  //     enableDrag: false,
  //     //isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext ctx) {
  //       return Authenticate();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                size: 100,
                color: Theme.of(context).colorScheme.onSurface,
                Icons.lock,
              ),
              SizedBox(height: 10),
              Text(
                'Authentication required to unlock the app',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 100),
              TextButton(
                onPressed: _authenticateUser,
                child: Text(
                  'Unlock',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
