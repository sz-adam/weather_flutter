import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(       
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 0, 0),
            borderRadius: BorderRadius.circular(15), // Beállítja a border radius-t
          ),
          child: const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Today',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.sunny,
                    size: 60,
                    color: Colors.yellow,
                  ),
                  Text(
                    '13°',
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
