import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/budgeting/expenses_screen.dart';
import 'package:frontend/utils/theme/theme.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:frontend/models/ModelProvider.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const Blink());
}

class Blink extends StatefulWidget {
  const Blink({Key? key}) : super(key: key);

  @override
  State<Blink> createState() => _BlinkState();
}

class _BlinkState extends State<Blink> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(api);

    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      // Add both Amplify Auth Cognito and Amplify API plugins
      //await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyAPI()]);
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
        child: MaterialApp(
      //builder: Authenticator.builder(),
      debugShowCheckedModeBanner: false,
      title: 'Blink',
      theme: BlinkThemes().blinkmainTheme(),
      home: const ExpensesScreen(),
    ));
  }
}
