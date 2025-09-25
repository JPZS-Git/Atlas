import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsentPageOBPage extends StatefulWidget {
  final VoidCallback onConsentGiven;

  const ConsentPageOBPage({super.key, required this.onConsentGiven});

  @override
  State<ConsentPageOBPage> createState() => _ConsentPageOBPageState();
}

class _ConsentPageOBPageState extends State<ConsentPageOBPage> {
  bool _marketingConsent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Sua privacidade é importante para nós.',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: const Color.fromARGB(255, 30, 30, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Concorde com os Termos e Condições',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ao ativar esta opção, você aceita nossos termos de uso e política de privacidade. O consentimento é necessário para continuar.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: Text(
                          'Aceito os Termos e Condições',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                        ),
                        value: _marketingConsent,
                        onChanged: (value) {
                          setState(() {
                            _marketingConsent = value;
                          });
                        },
                        inactiveThumbColor: Colors.grey,
                        activeTrackColor: const Color(0xFF26A69A), 
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: _marketingConsent
                    ? () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('marketing_consent', true);
                        widget.onConsentGiven();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _marketingConsent
                      ? const Color(0xFF26A69A) 
                      : Colors.white,
                  foregroundColor:
                      _marketingConsent ? Colors.white : Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Salvar e Continuar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}