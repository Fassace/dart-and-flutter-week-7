import 'package:flutter/material.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  SendMoneyPageState createState() => SendMoneyPageState();
}

class SendMoneyPageState extends State<SendMoneyPage> {
  String recipient = '';
  double amount = 0.0;
  String paymentMethod = '';

  void _confirmTransaction() {
    if (recipient.isNotEmpty && amount > 0 && paymentMethod.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionConfirmationPage(
            recipient: recipient,
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
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Recipient'),
              onChanged: (value) {
                setState(() {
                  recipient = value;
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
              onPressed: _confirmTransaction,
              child: const Text('Proceed to Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionConfirmationPage extends StatelessWidget {
  final String recipient;
  final double amount;
  final String paymentMethod;

  const TransactionConfirmationPage({
    super.key,
    required this.recipient,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Transaction Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Recipient: $recipient'),
            Text('Amount: \$${amount.toStringAsFixed(2)}'),
            Text('Payment Method: $paymentMethod'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaction Successful')),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Confirm and Send'),
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
