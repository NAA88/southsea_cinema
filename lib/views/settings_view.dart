import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefAddress = 'user_address';
const String prefEmail = 'user_email';
const String prefPatronNumber = 'user_patron_number';
const String prefEmailNews = 'user_email_news';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() {
    return _SettingsViewState();
  }
}

class _SettingsViewState extends State<SettingsView> {
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronNumberController;
  bool _receiveEmailNews = false;
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _patronNumberController = TextEditingController();
    _loadSettings();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _patronNumberController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final String? savedAddress = await prefs.getString(prefAddress);
    final String? savedEmail = await prefs.getString(prefEmail);
    final String? savedPatronNumber = await prefs.getString(prefPatronNumber);
    final bool? savedEmailNews = await prefs.getBool(prefEmailNews);

    String address = '';
    if (savedAddress != null) {
      address = savedAddress;
    }

    String email = '';
    if (savedEmail != null) {
      email = savedEmail;
    }

    String patronNumber = '';
    if (savedPatronNumber != null) {
      patronNumber = savedPatronNumber;
    }

    bool emailNews = false;
    if (savedEmailNews != null) {
      emailNews = savedEmailNews;
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _addressController.text = address;
      _emailController.text = email;
      _patronNumberController.text = patronNumber;
      _receiveEmailNews = emailNews;
    });
  }

  Future<void> _saveSettings() async {
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();
    final String patronNumber = _patronNumberController.text.trim();

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString(prefAddress, address);
    await prefs.setString(prefEmail, email);
    await prefs.setString(prefPatronNumber, patronNumber);
    await prefs.setBool(prefEmailNews, _receiveEmailNews);

    final UserSettings settings = UserSettings(
      address: address,
      email: email,
      patronNumber: patronNumber,
      receiveEmailNews: _receiveEmailNews,
    );

    if (!mounted) {
      return;
    }
    setState(() {
      _confirmationMessage = 'Settings saved for ${settings.email}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Settings',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                hintText: 'Enter your address',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email Address',
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _patronNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Patron Number',
                hintText: 'Enter your patron number',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Preferences', style: cinemaMutedStyle),
            Row(
              children: [
                const Expanded(
                  child: Text('Receive news by email', style: cinemaBodyStyle),
                ),
                Switch(
                  value: _receiveEmailNews,
                  onChanged: (bool value) {
                    setState(() {
                      _receiveEmailNews = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CinemaButton(
                  label: 'CANCEL',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 16),
                CinemaButton(
                  label: 'SAVE SETTINGS',
                  onPressed: _saveSettings,
                ),
              ],
            ),
            if (_confirmationMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                _confirmationMessage,
                style: const TextStyle(color: cinemaBrand),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
