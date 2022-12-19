import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/core/view/auth_view.dart';
import 'package:vendor/core/view/park_view.dart';
import 'package:vendor/ui/main/detail_screen/detail_screen.dart';
import 'package:vendor/ui/main/home_screen/components/info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    ParkView parkView = Provider.of<ParkView>(context);
    AuthView authView = Provider.of<AuthView>(context);

    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Park Status",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                authView.authProcess == AuthProcess.idle ? Switch(
                  value: authView.status, onChanged: (bool value) {
                    authView.changeStatus(value);
                  setState(() {
                    authView.status = value;
                  });
                },):const CircularProgressIndicator(),

              ],
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          children: <Widget>[
            InfoWidget(
              color: Colors.blue,
              number: parkView.parkHistory.length.toStringAsFixed(0),
              description: "Today Total Parks",
              page: DetailScreen(
                data: parkView.parkHistory,
                title: "Today Total Parks",
              ),
            ),
            InfoWidget(
              color: Colors.green,
              number: parkView.activePark.length.toStringAsFixed(0),
              description: "Active Parks",
              page: DetailScreen(
                data: parkView.activePark,
                title: "Active Parks",
              ),
            ),
            InfoWidget(
              color: Colors.orange,
              number: parkView.approvalPark.length.toStringAsFixed(0),
              description: "Awaiting Approval",
              page: DetailScreen(
                data: parkView.approvalPark,
                title: "Awaiting Approval",
              ),
            ),
            InfoWidget(
              color: Colors.red,
              number: parkView.canceledPark.length.toStringAsFixed(0),
              description: "Today Rejected Parks",
              page: DetailScreen(
                data: parkView.canceledPark,
                title: "Today Rejected Parks",
              ),
            ),
            InfoWidget(
              color: Colors.yellow,
              number: "${parkView.totalEarnings.toStringAsFixed(0)} ₺",
              description: "Today's Earnings",
              page: DetailScreen(
                data: parkView.parkHistory,
                title: "Today's Earnings",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
