import 'package:chitter/components/formWidget/rounded_button.dart';
import 'package:chitter/components/formWidget/textfield.dart';
import 'package:chitter/controller/PostController.dart';
import 'package:chitter/screens/feeds/feed_screen.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';


class CommentForm extends StatelessWidget {
   CommentForm({Key? key,required this.pid}) : super(key:key);

   final int pid;


  final _formContentKey = GlobalKey<FormState>();
  final content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Form(
      key:_formContentKey,
      child: Container(
        margin: const EdgeInsets.all(1),
        child: Row(
          children: [
            Expanded(child: TextInputField(
              controller: content,
              hintText: "Comment",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Comment is Empty!";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              prefixIcon: const Icon(Icons.message_outlined),
            ),),
            const SizedBox(width:10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (_formContentKey.currentState!.validate()) {
                  try{
                    var resp = await RestAPI().createComment({
                      "content":content.text,
                      "pid":pid
                    });
                    Get.find<PostController>().fetchPostById(pid);

                  }catch(e){
                    Utility().logger.e(e);
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
