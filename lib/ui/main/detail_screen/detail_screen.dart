import 'package:flutter/material.dart';
import 'package:vendor/core/model/park_history_model.dart';
import 'package:vendor/ui/main/detail_screen/components/item_card.dart';

class DetailScreen extends StatelessWidget {
  final List<ParkHistory> data;
  final String title;

  const DetailScreen({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: data.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int i) {
            return ItemCard(parkHistory: data[i]);
          }): Center(child: Text("No Park"),),
    );
  }
}
