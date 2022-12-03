import 'package:flutter/material.dart';
import 'package:vendor/ui/main/home_screen/components/info_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: true,
      crossAxisCount: 2,
      children: const <Widget>[
        InfoWidget(color: Colors.blue, number: 15, description: "Today Total Parks", page: HomeScreen()),
        InfoWidget(color: Colors.green, number: 4, description: "Active Parks", page: HomeScreen()),
        InfoWidget(color: Colors.orange, number: 1, description: "Awaiting Approval", page: HomeScreen()),
        InfoWidget(color: Colors.yellow, number: 305.5, description: "Today's Earnings", page: HomeScreen()),
        InfoWidget(color: Colors.orange, number: 12, description: "Today Total Parks", page: HomeScreen()),
        InfoWidget(color: Colors.orange, number: 12, description: "Today Total Parks", page: HomeScreen()),
      ],
    );
  }
}
