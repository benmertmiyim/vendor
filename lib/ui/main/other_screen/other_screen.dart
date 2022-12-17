import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendor/core/view/auth_view.dart';
import 'package:vendor/core/view/notification_view.dart';
import 'package:vendor/ui/components/went_wrong_widget.dart';
import 'package:vendor/ui/main/other_screen/components/tile_widget.dart';

import '../comments_screen/comments_screen.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    NotificationView notificationView = Provider.of<NotificationView>(context);

    if (authView.authProcess == AuthProcess.idle) {
      if (authView.vendorModel != null) {
        return ListView(
          children: [
            Column(
              children: [
                TileWidget(
                  subTitle: authView.vendorModel!.managerName,
                  title: "Manager Name",
                ),
                TileWidget(
                  subTitle: authView.vendorModel!.email,
                  title: "Email",
                ),
                TileWidget(
                  subTitle: authView.vendorModel!.phone,
                  title: "Phone",
                ),
                TileWidget(
                  subTitle: authView.vendorModel!.vendorID,
                  title: "Vendor ID",
                ),
                TileWidget(
                  subTitle: authView.vendorModel!.parkName,
                  title: "Park Name",
                ),
                TileWidget(
                  subTitle: authView.vendorModel!.rating.toStringAsFixed(2),
                  title: "Total Rating",
                ),
                Row(
                  children: [
                    Expanded(
                      child: TileWidget(
                        subTitle: authView.vendorModel!.security.toStringAsFixed(2),
                        title: "Security",
                      ),
                    ),
                    Expanded(
                      child: TileWidget(
                        subTitle:
                            authView.vendorModel!.accessibility.toStringAsFixed(2),
                        title: "Accessibility",
                      ),
                    ),
                    Expanded(
                      child: TileWidget(
                        subTitle:
                            authView.vendorModel!.serviceQuality.toStringAsFixed(2),
                        title: "Service",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TileWidget(
                        title: "Hourly Price",
                        subTitle: "${authView.vendorModel!.hourlyPrice} ₺",
                        onClick: () {
                          final myController = TextEditingController();
                          Alert(
                              context: context,
                              title: "Hourly Price",
                              content: Column(
                                children: <Widget>[
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: authView
                                          .vendorModel!.hourlyPrice
                                          .toString(),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    controller: myController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,

                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  onPressed: () async {
                                    if(myController.text.isNotEmpty){
                                      if(double.parse(myController.text) != 0){
                                        authView.setHourlyPrice(double.parse(myController.text));
                                        Navigator.pop(context);
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Price can not be 0"),
                                          ),
                                        );
                                      }
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Price can not be empty"),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ]).show();
                        },
                      ),
                    ),
                    Expanded(
                      child: TileWidget(
                        title: "Start Price",
                        subTitle: "${authView.vendorModel!.startPrice} ₺",
                        onClick: () {
                          final myController = TextEditingController();
                          Alert(
                              context: context,
                              title: "Start Price",
                              content: Column(
                                children: <Widget>[
                                  TextField(
                                    controller: myController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: authView
                                          .vendorModel!.startPrice
                                          .toString(),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  onPressed: () async {
                                    if(myController.text.isNotEmpty){
                                      if(double.parse(myController.text) != 0){
                                        authView.setStartPrice(double.parse(myController.text));
                                        Navigator.pop(context);
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Price can not be 0"),
                                          ),
                                        );
                                      }
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Price can not be empty"),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ]).show();
                        },
                      ),
                    ),
                  ],
                ),
                TileWidget(
                  subTitle:
                      "${authView.vendorModel!.latitude} - ${authView.vendorModel!.longitude}",
                  title: "Location",
                ),
                TileWidget(
                  subTitle: authView.vendorModel!.iban,
                  title: "IBAN",
                ),
                TileWidget(
                  subTitle: authView.vendorModel!.vkn,
                  title: "VKN",
                ),
                TileWidget(
                  title: "Image List",
                  onClick: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletHistoryScreen(),
                      ),
                    );*/
                  },
                ),
                TileWidget(
                  title: "Comments",
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommentsScreen(),
                      ),
                    );
                  },
                ),
                TileWidget(
                  title: "Wallet History",
                  onClick: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletHistoryScreen(),
                      ),
                    );*/
                  },
                ),
                const TileWidget(
                  title: "Support",
                  subTitle: "+850 123 12 12",
                ),
                TileWidget(
                  title: "Logout",
                  onClick: () {
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "Logout",
                      desc: "Are you sure, do you want to logout?",
                      buttons: [
                        DialogButton(
                          color: Colors.red,
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            authView.signOut();
                            notificationView.logout();
                          },
                        ),
                        DialogButton(
                          color: Colors.green,
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                  },
                  isLogout: true,
                ),
              ],
            ),
          ],
        );
      } else {
        return const WentWrongWidget();
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
