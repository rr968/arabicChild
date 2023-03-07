/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unicode_moyasar/unicode_moyasar.dart';

void main() async {
  /// await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentView(amount: 100),
    );
  }
}

class PaymentView extends StatefulWidget {
  final double amount;
  const PaymentView({Key? key, required this.amount}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text("Checkout"),
          shape: const Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          )),
      body: MoyasarPayment(
        moyasarPaymentData: MoyasarPaymentData(
          appName: "App Name",
          secretKey: "sk_test_rb9t7aUSFB9qLWsKoGRgm48mavCthrqa1A11jeVN",
          publishableSecretKey:
              "pk_test_o2hGGCfRdscvmesVgcuRpgGUUwUA2c1A7f5TuPSB",
          purchaseAmount: widget.amount,
          locale: PaymentLocale.ar,
          paymentEnvironment: PaymentEnvironment.test,
          paymentOptions: [
            PaymentOption.card,
            PaymentOption.applepay,
            PaymentOption.stcpay,
          ],
        ),
        onPaymentSucess: (response) {
          //TODO Handle success payment response
          debugPrint("Success ------> ${response.toMap()}");

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SucessPage(),
            ),
          );
        },
        onPaymentFailed: (response) {
          //TODO Handle failed payment response
          debugPrint("Failed ------> ${response.toMap()}");
        },
      ),
    );
  }
}

class SucessPage extends StatelessWidget {
  const SucessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sucess"),
      ),
      body: Center(
        child: Text("Payment Sucess"),
      ),
    );
  }
}
*/
