import 'package:flutter/material.dart';

class WeatherTextField extends StatelessWidget {
  final ValueChanged<String> onSubmitted;

  const WeatherTextField({required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          decoration:const InputDecoration(
            hintText: 'Enter a city name',
            border: OutlineInputBorder(),
            labelText: 'City',
          ),
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}