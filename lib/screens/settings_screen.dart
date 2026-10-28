import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/clock_settings.dart';

/// Screen for customizing clock settings, preferences, and display labels.
/// Demonstrates Form validation, Provider state modification, and navigation.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelController;

  @override
  void initState() {
    super.initState();
    final clockSettings = context.read<ClockSettings>();
    _labelController = TextEditingController(text: clockSettings.clockLabel);
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newLabel = _labelController.text.trim();
    context.read<ClockSettings>().setClockLabel(newLabel);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Clock label updated to "$newLabel"!'),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetDefaults() {
    context.read<ClockSettings>().resetDefaults();
    _labelController.text = 'DIGITAL CLOCK';
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings reset to default values!'),
        backgroundColor: Colors.blueGrey,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clockSettings = context.watch<ClockSettings>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock Settings'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.settings_suggest,
                    size: 64,
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Customize Your Clock',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Configure display banner and time formatting preferences.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Clock Label Input Field
                  TextFormField(
                    controller: _labelController,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      labelText: 'Clock Banner Label',
                      hintText: 'Enter title (e.g. DIGITAL CLOCK, MY WORKSPACE)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title),
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

                  // 24-Hour Format Switch
                  Card(
                    color: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.white12),
                    ),
                    child: SwitchListTile(
                      title: const Text(
                        '24-Hour Time Format',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        clockSettings.is24HourFormat
                            ? 'Currently 24-Hour (e.g., 14:30:45)'
                            : 'Currently 12-Hour (e.g., 02:30:45 PM)',
                        style: const TextStyle(color: Colors.white60),
                      ),
                      value: clockSettings.is24HourFormat,
                      activeColor: Colors.cyanAccent,
                      onChanged: (bool value) {
                        clockSettings.setTimeFormat(value);
                      },
                      secondary: const Icon(Icons.access_time_filled),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Save Button
                  ElevatedButton.icon(
                    onPressed: _saveSettings,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Settings'),
                  ),
                  const SizedBox(height: 12),

                  // Reset Defaults Button
                  OutlinedButton.icon(
                    onPressed: _resetDefaults,
                    icon: const Icon(Icons.restore),
                    label: const Text('Reset to Defaults'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: const BorderSide(color: Colors.white30),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Active Configuration Summary Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Current Active Settings',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Banner Label: "${clockSettings.clockLabel}"',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Display Mode: ${clockSettings.is24HourFormat ? "24-Hour Military Format" : "12-Hour AM/PM Format"}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
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
