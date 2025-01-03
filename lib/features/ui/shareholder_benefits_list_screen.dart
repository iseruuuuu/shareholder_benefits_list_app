import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shareholder_benefits_list_app/features/core/shareholder_benefits.dart';
import 'package:shareholder_benefits_list_app/features/ui/add_screen.dart';
import 'package:shareholder_benefits_list_app/features/util/datetime_to_string_converter.dart';
import 'package:auto_animated/auto_animated.dart';

class ShareholderBenefitsListScreen extends StatefulWidget {
  const ShareholderBenefitsListScreen({super.key});

  @override
  State<ShareholderBenefitsListScreen> createState() =>
      _ShareholderBenefitsListScreenState();
}

class _ShareholderBenefitsListScreenState
    extends State<ShareholderBenefitsListScreen> {
  List<ShareholderBenefits> _todoList = [];
  bool _isLoading = true;

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
      _isLoading = false;
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
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: const Color(0xFFF2F2F7),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          forceMaterialTransparency: true,
        ),
      ),
      body: _isLoading
          ? SizedBox()
          : _todoList.isEmpty
              ? const Center(child: Text('リストが空です'))
              : LiveList(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  itemCount: _todoList.length,
                  itemBuilder: (context, index, animation) {
                    final item = _todoList[index];
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeOut)),
                        ),
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  '届く予定月: ${item.postDay.toLocal().toShortDateString()}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                if (item.expiresDay != null)
                                  Text(
                                    '期限月: ${item.expiresDay!.toLocal().toShortDateString()}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeTodoItem(index),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.black,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPage(onAdd: _addTodoItem),
              ),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
