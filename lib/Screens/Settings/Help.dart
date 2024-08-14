
import 'package:allobaby/Config/Color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Help extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help".tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact Us'.tr),
              SizedBox(
                height: 16,
              ),
              TextField(
                // controller: settingsController.feedback,
                maxLines: 5,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: "Tell us what's going on".tr,
                    filled: true,
                    fillColor: Colors.grey[300]),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Tell us why you're reaching us".tr),
              SizedBox(
                height: 48,
                child: DropdownSearch<String>(
                      validator: (v) => v == null ? "Select Weekdays" : null,
                      // mode: Mode.MENU,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "",
                          border: OutlineInputBorder(
                            
                          )
                        )
                      ),
                      // showSelectedItem: true,
                      items: [
                        'Something not Working'.tr,
                        'Feature Request'.tr,
                        'Question'.tr,
                        'FeedBack'.tr,
                        'Other'.tr,
                      ],
                      // dropdownSearchDecoration: InputDecoration(),
                      // selectedItem: settingsController.reachingUs.value.tr,
                      onChanged: (value) {
                        // settingsController.reachingUs.value = value!;
                      },
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("How do you feel? (Optional)".tr),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 10.0,
                children: List.generate(emojis.length, (index) {
                  return ChoiceChip(
                        labelPadding: EdgeInsets.all(4),
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        label: Text(
                          (emojis[index]).toUpperCase(),
                          style: TextStyle(fontSize: 24),
                        ),
                        selectedColor: PrimaryColor,
                        // ignore: unrelated_type_equality_checks
                        // selected: settingsController.feel == emojis[index],
                        selected: false,
                        onSelected: (value) {
                          // settingsController.feel.value = emojis[index];
                        },
                      );
                }),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Row(children: [
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                // primary: PrimaryColor,
                minimumSize: Size(100, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40))),
            onPressed: () => {},
            // settingsController.sendFeedBack(),
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
