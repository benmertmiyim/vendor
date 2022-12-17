import 'package:flutter/material.dart';

class WentWrongWidget extends StatelessWidget {
  const WentWrongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          //Image.asset("assets/images/went_wrong.jpg"), //TODO ADD IMAGE
          SizedBox(height: 16,),
          Text("Something Went Wrong !",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
          Text("Please try again later",style: TextStyle(fontSize: 16,color: Colors.black54,),),
        ],
      ),
    );
  }
}
