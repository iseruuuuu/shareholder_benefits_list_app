import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shareholder_benefits_list_app/features/core/shareholder_benefits.dart';
import 'package:shareholder_benefits_list_app/features/ui/add_screen.dart';
import 'package:shareholder_benefits_list_app/features/util/datetime_to_string_converter.dart';

class ShareholderBenefitsListScreen extends StatefulWidget {
  const ShareholderBenefitsListScreen({super.key});

  @override
  State<ShareholderBenefitsListScreen> createState() =>
      _ShareholderBenefitsListScreenState();
}

class _ShareholderBenefitsListScreenState
    extends State<ShareholderBenefitsListScreen> {
  List<ShareholderBenefits> _todoList = [];

  @override
  void initState() {
    super.initState();
    _loadTodoList();
  }

  Future<void> _loadTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoList = (prefs.getStringList('todoList') ?? [])
          .map((e) => ShareholderBenefits.fromJson(json.decode(e)))
          .toList();
    });
  }

  Future<void> _saveTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'todoList',
      _todoList.map((e) => json.encode(e.toJson())).toList(),
    );
  }

  void _addTodoItem(ShareholderBenefits item) {
    setState(() {
      _todoList.add(item);
    });
    _saveTodoList();
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _saveTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODOリスト'),
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final item = _todoList[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(
                '購入日: ${item.purchaseDay.toLocal().toShortDateString()}\n'
                    '届く予定日: ${item.postDay.toLocal().toShortDateString()}\n期限日: ${item.expiresDay.toLocal().toShortDateString()}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeTodoItem(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPage(onAdd: _addTodoItem),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
