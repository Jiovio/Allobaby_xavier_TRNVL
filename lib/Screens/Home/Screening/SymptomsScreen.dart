import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

SingleChildScrollView SymptomsScreen() => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Symptoms".tr,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 10.0,
              children: List.generate(
                symptomsList.length,
                (index) =>  GetBuilder<Selfscreeningcontroller>(
                  
                  builder: (controller) => 
                  OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: controller.symptomsMap.containsKey(symptomsList[index].title) 
                                  && (controller.symptomsMap[symptomsList[index].title]!)
                                ? const BorderSide(color: PrimaryColor, width: 1.5)
                                : const BorderSide(color: Colors.grey),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                          controller.symptomSelect(
                               symptomsList[index].title);

                              //  print(controller.symptomsMap);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: controller.symptomsMap.containsKey(symptomsList[index].title) 
                                  && (controller.symptomsMap[symptomsList[index].title]!)?
                                  PrimaryColor:Colors.grey
                  
                                  // color:
                                  //     controller.symptomsSelected.contains(index)
                                  //         ? PrimaryColor
                                  //         : Colors.grey,
                                ),
                                child: Image.asset(
                                  symptomsList[index].image,
                                  height: 80,
                                  width: 80,
                                  color: controller.symptomsMap.containsKey(symptomsList[index].title) 
                                  && (controller.symptomsMap[symptomsList[index].title]!)?White:White,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                symptomsList[index].title,
                                style: TextStyle(
                                    color: 
                                    controller.symptomsMap.containsKey(symptomsList[index].title) 
                                  && (controller.symptomsMap[symptomsList[index].title]!)
                                        ? PrimaryColor
                                        : Black,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),

                              
                            ],
                          )),
                ),
              ),
            ),

             GetBuilder<Selfscreeningcontroller>(

               builder: (controller) =>  Column(
                 children: [
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextField(
                      onTap: () {},
                      controller: controller.symptomDesc,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      cursorColor: PrimaryColor,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      onChanged: (val) {},
                      decoration: const InputDecoration(
                        hintText: "Add your symptom description",
                        hintStyle: TextStyle(fontSize: 18),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        filled: true,
                        fillColor: Black100,
                      ),
                    ),
                               ),


                               SizedBox(
                                width: double.infinity,
                                height: 50,
                                 child: ElevatedButton(onPressed: (){
                                  controller.submitSymptoms();
                                 }, child: 
                                 Text("Submit".tr)),
                               ),

                               SizedBox(height: 20,)
                 ],
               ),
             )
     
             

          ],
        ),
      ),
    );

List<Symptoms> symptomsList = [
  Symptoms(title: 'Normal'.tr, image: 'assets/BottomSheet/Symptoms/normal.png'),
  Symptoms(
      title: 'Body pain'.tr, image: 'assets/BottomSheet/Symptoms/boad_pain.png'),
  Symptoms(
      title: 'Burning Stomach'.tr,
      image: 'assets/BottomSheet/Symptoms/burning_in_stomach.png'),
  Symptoms(
      title: 'Cold cough'.tr, image: 'assets/BottomSheet/Symptoms/cold_cough.png'),
  Symptoms(
      title: 'Dizziness'.tr, image: 'assets/BottomSheet/Symptoms/dizziness.png'),
  Symptoms(
      title: 'Headache'.tr, image: 'assets/BottomSheet/Symptoms/headache.png'),
  Symptoms(
      title: 'Vomiting'.tr, image: 'assets/BottomSheet/Symptoms/vomiting.png'),
  Symptoms(title: 'Other'.tr.tr, image: 'assets/BottomSheet/Symptoms/sad.png')
];

class Symptoms {
  String title;
  String image;
  Symptoms({required this.title, required this.image});
}
