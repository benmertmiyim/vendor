import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/core/view/auth_view.dart';
import 'package:vendor/ui/main/comments_screen/components/comment_widget.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ratings"),
        centerTitle: true,
      ),
      body: authView.authProcess == AuthProcess.idle
          ? (authView.ratingList!.isNotEmpty
          ? ListView.builder(
          itemCount: authView.ratingList!.length,
          itemBuilder: (BuildContext context, int i) {
            return CommentWidget(rateModel: authView.ratingList![i]);
          })
          : const Center(
        child: Text("You dont have any rating."),
      ))
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
