import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/Screens/Home/Screening/SymptomsScreen.dart';
import 'package:allobaby/Screens/Home/Screening/Vitals/Vitals.dart';
import 'package:allobaby/Screens/Home/Screening/summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelfScreening extends StatefulWidget {
  const SelfScreening({super.key});

  @override
  State<SelfScreening> createState() => _SelfScreeningState();
}

class _SelfScreeningState extends State<SelfScreening> {
    int i=0;
    PageController pg = PageController();

  void _updateCurrentPageIndex(int index) {
    pg.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }


  Selfscreeningcontroller controller = Get.put(Selfscreeningcontroller());


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Self Screening"),
      ),


      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pg,
        onPageChanged: (index) {
          print(pg);
          // serviceController.pagechanged(index);
        },
        children: [
          SymptomsScreen(),
          VitalsScreen(),
          summary(),


        ],
      ),


      bottomNavigationBar: Container(
                padding: EdgeInsets.only(top: 6.0, left: 20, right: 20, bottom: 10),
        color: Get.isDarkMode ? darkGrey2 : White,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                      Visibility(
                        visible: true,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryColor,
                            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // primary: PrimaryColor,
                            foregroundColor: Colors.white

                          ),
                          onPressed: () {
                            // pageController.pageController.animateToPage(
                            //     pageController.pageChanged - 1,
                            //     duration: Duration(milliseconds: 300),
                            //     curve: Curves.easeInOut);

                            _updateCurrentPageIndex(i>0?i--:0);

setState(() {
  
});
                          },
                          child: Text("BACK"),
                        ),
                      ),



                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          // primary: PrimaryColor,
                          backgroundColor: PrimaryColor,
                          foregroundColor: Colors.white
                          
                        ),
                        // onPressed: () => serviceController.addCheckupDetails(),
                        onPressed: () {
                          
                        },
                        child: Text("SAVE"),
                      ),


                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: PrimaryColor,
                          textStyle: TextStyle(color: White),
                          foregroundColor: Colors.white
                        ),
                        onPressed: () {

                          pg.nextPage(duration: Duration(milliseconds: 300),curve: Curves.linear);


// _updateCurrentPageIndex(i<1?i++:1);

// setState(() {
  
// });
                        },
                        child: Text("NEXT"),
                      )

        ],),
      ),
    );
  }
}