import 'package:flutter/material.dart';

class PayBillsPage extends StatefulWidget {
  const PayBillsPage({super.key});

  @override
  PayBillsPageState createState() => PayBillsPageState(); // Removed underscore.
}

class PayBillsPageState extends State<PayBillsPage> {
  // Removed underscore.
  String biller = '';
  double amount = 0.0;
  String paymentMethod = '';

  void _confirmPayment() {
    if (biller.isNotEmpty && amount > 0 && paymentMethod.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentConfirmationPage(
            biller: biller,
            amount: amount,
            paymentMethod: paymentMethod,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Bills')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Biller'),
              onChanged: (value) {
                setState(() {
                  biller = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Payment Method'),
              value: paymentMethod.isEmpty ? null : paymentMethod,
              items: const [
                DropdownMenuItem(
                  value: 'Bank Account',
                  child: Text('Bank Account'),
                ),
                DropdownMenuItem(
                  value: 'Mobile Wallet',
                  child: Text('Mobile Wallet'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  paymentMethod = value ?? '';
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmPayment,
              child: const Text('Proceed to Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentConfirmationPage extends StatelessWidget {
  final String biller;
  final double amount;
  final String paymentMethod;

  const PaymentConfirmationPage({
    super.key,
    required this.biller,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Biller: $biller'),
            Text('Amount: \$${amount.toStringAsFixed(2)}'),
            Text('Payment Method: $paymentMethod'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Successful')),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Confirm Payment'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
