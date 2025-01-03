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
  String? _postMonth;
  String? _expiresMonth;

  Future<void> _selectMonth(
    BuildContext context,
    ValueChanged<String?> onSelected,
  ) async {
    final now = DateTime.now();
    // 現在の年月の1日を初期日として設定
    final initialDate = DateTime(now.year, now.month, 1);
    final result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: '月を選択',
      selectableDayPredicate: (date) => date.day == 1,
    );

    if (result != null) {
      onSelected('${result.year}-${result.month.toString().padLeft(2, '0')}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('株主優待の追加'),
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
            ListTile(
              title: Text('届く予定月: ${_postMonth ?? "未選択"}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () {
                _selectMonth(context, (value) {
                  setState(() {
                    _postMonth = value;
                  });
                });
              },
            ),
            ListTile(
              title: Text('期限月: ${_expiresMonth ?? "未選択"}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () {
                _selectMonth(context, (value) {
                  setState(() {
                    _expiresMonth = value;
                  });
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                widget.onAdd(
                  ShareholderBenefits(
                    name: name,
                    postDay: DateTime.parse('${_postMonth!}-01'),
                    expiresDay: _expiresMonth != null
                        ? DateTime.parse('${_expiresMonth!}-01')
                        : null,
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
