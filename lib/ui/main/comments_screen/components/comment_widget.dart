import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendor/core/model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final RateModel rateModel;

  const CommentWidget({Key? key, required this.rateModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Security:"),
                Row(
                  children: [
                    Text(rateModel.security.toStringAsFixed(2)),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Accessibility:"),
                Row(
                  children: [
                    Text(rateModel.accessibility.toStringAsFixed(2)),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Service Quality:"),
                Row(
                  children: [
                    Text(rateModel.serviceQuality.toStringAsFixed(2)),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Rate Date:"),
                Text(DateFormat('dd-MM-yyyy – kk:mm')
                    .format(rateModel.commentDate.toDate())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Comment: "),
                Expanded(child: Text(rateModel.message != "" ? rateModel.message : "-",))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
