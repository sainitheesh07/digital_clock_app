
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();

  String savedLabel = 'DIGITAL CLOCK';

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      savedLabel = _labelController.text.trim();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Clock label saved successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock Settings'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.settings, size: 60),
                  const SizedBox(height: 20),
                  const Text(
                    'Customize Your Clock',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _labelController,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      labelText: 'Clock label',
                      hintText: 'Enter a name for your clock',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.edit),
                    ),
                    validator: (value) {
                      final label = value?.trim() ?? '';

                      if (label.isEmpty) {
                        return 'Please enter a clock label';
                      }

                      if (label.length < 3) {
                        return 'Label must contain at least 3 characters';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveSettings,
                    child: const Text('Save Settings'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Current label: $savedLabel',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
