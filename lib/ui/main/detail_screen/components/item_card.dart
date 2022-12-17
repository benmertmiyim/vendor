import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendor/core/model/enums.dart';
import 'package:vendor/core/model/park_history_model.dart';

class ItemCard extends StatelessWidget {
  final ParkHistory parkHistory;

  ItemCard({Key? key, required this.parkHistory}) : super(key: key);

  DateTime? closedTime;
  late DateTime requestTime;

  @override
  Widget build(BuildContext context) {
    closedTime = parkHistory.closedTime != null
        ? parkHistory.closedTime!.toDate()
        : null;
    requestTime = parkHistory.requestTime.toDate();

    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(parkHistory.customerName),
            Text(
              "Status: " + statusConvert2(parkHistory.status),
            ),
            Row(
              children: [
                Text(
                  DateFormat('dd-MM-yyyy – kk:mm').format(requestTime),
                ),
                const Text(" / "),
                closedTime != null
                    ? Text(
                        DateFormat('dd-MM-yyyy – kk:mm').format(closedTime!),
                      )
                    : const Text("-"),
              ],
            ),
            parkHistory.status == Status.completed
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Time: ${parkHistory.totalTime}",
                      ),
                      Text(
                        "Total Price: ${parkHistory.totalPrice}",
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
