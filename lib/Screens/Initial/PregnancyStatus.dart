
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Initial/ParentsDetails.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Pregnancystatus extends StatelessWidget {
   Pregnancystatus({super.key});

   List<String> ls = ["Iam trying to conceive","Iam pregnant","I have a baby"];
   List<String> lm = ["Trying to conceive","Pregnant","I have a baby"];



  Signupcontroller sc = Get.put(Signupcontroller());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Image.asset(
            //   "assets/reportsicon.png",
            //   scale: 1,
            //   width: 100,
            //   height: 100,
            // ),
           const SizedBox(
              height: 20,
            ),
                Text(
                  sc.gender=="Female" ?"Pregnancy Status".tr : "Partner Pregnancy Status".tr,
                  style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
            SizedBox(
              height: 40,
            ),
        
      
        

                
                                Column(
                  children: [
                                            GetBuilder(
                  init: Signupcontroller(),
                  builder:(controller) => 

                  ListView.builder(
                    itemCount: ls.length,
                    shrinkWrap: true,
                    itemBuilder:(context, index) => 
                             
                             
                              Column(
                                children: [

                                  Card(
                                    color: controller.data["pregnancyStatus"]==ls[index]?PrimaryColor:White,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color:  
                        controller.data["pregnancyStatus"]==ls[index]?PrimaryColor
                        :Black
                        
                        )),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        highlightColor: accentColor.withOpacity(0.1),
                        
                        splashColor: accentColor.withOpacity(0.8),
                        onTap: () => 
                        controller.updateData("pregnancyStatus", ls[index]),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: ListTile(
                            // leading: Image.asset(
                            //   "assets/labReports/$img",
                            //   scale: 12,
                            // ),
                            title: Text(
                             sc.gender=="Female"?ls[index] : lm[index],
                              style: TextStyle(fontSize: 18,
                              color: controller.data["pregnancyStatus"]==ls[index]?White:Black,
                              fontWeight: controller.data["pregnancyStatus"]==ls[index]?FontWeight.bold:FontWeight.normal
                              ),
                            ),
                            trailing:
                                Icon(Icons.arrow_forward_ios_rounded, color: Black),
                          ),
                        ))),
                                                SizedBox(
              height: 20,
            ),
                                ],
                              )
                        
                        
                        
                        )
                        
                        ),


                        Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Flexible(
                      //   child: OutlinedButton(
                      //     onPressed: () => Get.to(() => AddressDetails(),
                      //         transition: Transition.rightToLeft),
                      //     style: ElevatedButton.styleFrom(
                      //         side: BorderSide(color: PrimaryColor),
                      //         minimumSize: Size(100, 40),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(40),
                      //         )),
                      //     child: Text(("Skip").toUpperCase()),
                      //   ),
                      // ),
                      Spacer(),
                      Flexible(
                        child: 
                        GetBuilder(
                          init: Signupcontroller(),
                          builder:(controller) => 
                        ElevatedButton(
                          onPressed: () {

                            if(controller.data["pregnancyStatus"]==""){

                              Get.snackbar("Status not Selected", 
                              "Please select Pregnancy Status",
                              snackPosition: SnackPosition.BOTTOM
                              );


                            }else {
                              Get.to(() => ParentDetails(),
                                  transition: Transition.rightToLeft);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: Text(("Continue".tr).toUpperCase()),
                        )),
                      ),
                    ])
                        

            
                  ],
            
            
            
            
            ),    
          ]),
        ),
      ),
    );
  }


}
