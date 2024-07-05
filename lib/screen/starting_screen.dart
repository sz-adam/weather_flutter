import 'package:flutter/material.dart';
import 'package:flutter_weather/screen/home_screen.dart';

class StartingScreen extends StatelessWidget {
  StartingScreen({Key? key}) : super(key: key);

  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void navigateToHomeScreen(BuildContext context, String city) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(city: city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Enter city name',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city name';
                  }
                  return null;
                },
                // Ha a form érvényes, navigál a HomeScreen-re
                onFieldSubmitted: (value) {
                  if (_formKey.currentState?.validate() ?? false) {
                    navigateToHomeScreen(context, value);
                  }
                },
              ),
              const SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}
