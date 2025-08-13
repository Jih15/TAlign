import 'package:flutter/material.dart';

class FormTest extends StatefulWidget {
  final int index;
  final Function(Map<String, dynamic>) onSave;

  const FormTest({super.key, required this.index, required this.onSave});

  @override
  _FormTestState createState() => _FormTestState();
}

class _FormTestState extends State<FormTest> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSave({
                  'title': _titleController.text,
                  'isNew': false,
                });
                _titleController.clear(); // Bersihkan form setelah simpan
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}