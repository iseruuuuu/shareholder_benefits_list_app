import 'package:flutter/material.dart';
import 'package:shareholder_benefits_list_app/features/core/shareholder_benefits.dart';

class AddPage extends StatefulWidget {
  final ValueChanged<ShareholderBenefits> onAdd;

  const AddPage({super.key, required this.onAdd});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _purchaseDayController = TextEditingController();
  final TextEditingController _postDayController = TextEditingController();
  final TextEditingController _expiresDayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO作成'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '株主優待の名称'),
            ),
            TextField(
              controller: _purchaseDayController,
              decoration: const InputDecoration(labelText: '購入日 (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _postDayController,
              decoration:
                  const InputDecoration(labelText: '届く予定日 (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _expiresDayController,
              decoration: const InputDecoration(labelText: '期限日 (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final purchaseDay = DateTime.parse(_purchaseDayController.text);
                final postDay = DateTime.parse(_postDayController.text);
                final expiresDay = DateTime.parse(_expiresDayController.text);
                widget.onAdd(
                  ShareholderBenefits(
                    name: name,
                    purchaseDay: purchaseDay,
                    postDay: postDay,
                    expiresDay: expiresDay,
                    isUsed: false,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
