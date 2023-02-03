import 'package:flutter/material.dart';

class CustomCardDetails extends StatelessWidget {
  final List<Map> details;
  const CustomCardDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      //color: Colors.yellow,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 3 / 2),
          itemCount: details.length,
          itemBuilder: (context, index) {
            final hr = details[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 1, color: Colors.grey.shade300)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                          radius: 18,
                          backgroundColor: hr['color'],
                          child: Image.asset(
                            hr['icon'],
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          )),
                      Text(
                        hr['title'],
                        style: TextStyle(
                          color: hr['color'],
                        ),
                      ),
                      Text(
                        hr['count'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                            fontSize: 25),
                      ),
                    ]),
              ),
            );
          }),
    );
  }
}
