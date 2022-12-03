import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final Color color;
  final double number;
  final String description;
  final Widget page;

  const InfoWidget(
      {Key? key,
      required this.color,
      required this.number,
      required this.description,
      required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (c) => page));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(number.toString(),style: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              Text(description,textAlign: TextAlign.center,maxLines: 2,style: const TextStyle(fontSize: 16,)),
            ],
          ),
        ),
      ),
    );
  }
}
