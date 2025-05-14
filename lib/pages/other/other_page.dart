import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workshop_0/pages/other/other_controller.dart';

class OtherPage extends GetView<OtherController> {
  const OtherPage({super.key});

  static const title = 'Other';
  static const route = '/other';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(controller.content)),
    );
  }
}
