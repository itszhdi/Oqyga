import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:oqyga_frontend/core/app.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51Sgmk64Nqh5X1eStwGWJkyi2uOwPd2K96gfEzW7gcXchG687TUvt3nVG5JeLT4J4HD4flCKNtS9ucbFYjaEZUmq500LH9PK2Uz";
  await Stripe.instance.applySettings();

  await initDependencies();
  runApp(const App());
}
