import 'package:allobaby/Config/Color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:allobaby/API/local/Storage.dart';

class Help extends StatelessWidget {
  final HelpController controller = Get.put(HelpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help".tr,
        ),
      ),
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Us'.tr),
                  SizedBox(height: 16),
                  TextField(
                    controller: controller.feedbackController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)
                      ),
                      hintText: "Tell us what's going on".tr,
                      filled: true,
                      fillColor: Colors.grey[300]
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Tell us why you're reaching us".tr),
                  SizedBox(
                    height: 48,
                    child: DropdownSearch<String>(
                      validator: (v) => v == null ? "Select Weekdays" : null,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Select a Reason",
                          border: OutlineInputBorder()
                        )
                      ),
                      items: [
                        'Something not Working'.tr,
                        'Feature Request'.tr,
                        'Question'.tr,
                        'FeedBack'.tr,
                        'Other'.tr,
                      ],
                      selectedItem: controller.selectedReason.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedReason.value = value;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("How do you feel? (Optional)".tr),
                  SizedBox(height: 15),
                  GetBuilder<HelpController>(
                    builder: (controller) {
                      return Wrap(
                        spacing: 10.0,
                        children: List.generate(emojis.length, (index) {
                          return ChoiceChip(
                            labelPadding: EdgeInsets.all(4),
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)
                            ),
                            label: Text(
                              (emojis[index]).toUpperCase(),
                              style: TextStyle(fontSize: 24),
                            ),
                            selectedColor: PrimaryColor,
                            selected: controller.selectedEmoji.value == emojis[index],
                            onSelected: (value) {
                              controller.selectedEmoji.value = 
                                value ? emojis[index] : '';
                                controller.update();
                            },
                          );
                        }),
                      );
                    }
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          // if (controller.isLoading.value)
          //   Container(
          //     color: Colors.black.withOpacity(0.3),
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
        ],
      )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Row(children: [
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
              )
            ),
            onPressed: controller.isLoading.value ? null : controller.submitFeedback,
            child: Text(
              'SEND'.tr,
              style: TextStyle(color: White),
            ),
          ),
        ]),
      ),
    );
  }
}

List<String> emojis = ['😀', '🙂', '😐', '🙁', '😠'];




class HelpController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final feedbackController = TextEditingController();
  
  var selectedReason = 'Something not Working'.obs;
  var selectedEmoji = ''.obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }

  Future<void> submitFeedback() async {
    if (feedbackController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your feedback',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading(true);
      
      final userid = await Storage.getUserID();
      final phone = await Storage.getUserPhone();

      await _firestore.collection("AllobabyHelp").add({
        'feedback': feedbackController.text,
        'reason': selectedReason.value,
        'emoji': selectedEmoji.value,
        'id': userid,
        'userPhone': phone,
        'timestamp': FieldValue.serverTimestamp(),
      });

      feedbackController.clear();
      selectedReason.value = 'Something not Working';
      selectedEmoji.value = '';

      Get.snackbar(
        'Success',
        'Your feedback has been submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );

      await Future.delayed(Duration(seconds: 1));
      Get.back();

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit feedback. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}