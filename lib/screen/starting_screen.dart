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
      body: Stack(
        children: [
          // Háttérkép beállítása
          Positioned.fill(
            child: Image.asset(
              'assets/images/home.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Átlátszó fekete réteg a háttérkép fölé
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // A többi widget a háttérkép fölé kerül
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'Enter city name',
                      floatingLabelBehavior: FloatingLabelBehavior
                          .never, // Ne lebegjen, hanem legyen a border alatt
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),                       
                      ),
                      filled: true, // Kitölti a hátteret fehérrel
                      fillColor:
                          Colors.white, // Fehér háttérszín a beviteli mezőnél                     
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a city name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState?.validate() ?? false) {
                        navigateToHomeScreen(context, value);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        navigateToHomeScreen(context, _cityController.text);
                      }
                    },
                    child: const Text('Sending'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
