import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';


class SubscriptionViewApp extends StatelessWidget {
   SubscriptionViewApp({super.key});

  final Maincontroller maincontroller = Get.put(Maincontroller());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      floatingActionButton:             InkWell(onTap: (){}, child: Container(
            width: Get.width*0.92,
            height: 50,
            decoration: BoxDecoration(
            color: PrimaryColor,
            borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Subscribe",style: TextStyle(fontSize: 16,color: White,fontWeight:FontWeight.w600),))) ),

      appBar: AppBar(title: Text("Subscription"),),

      body: SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
            
                GetBuilder<Maincontroller>(
              init: Maincontroller(),
            builder: (controller)=>
               controller.plan!=""?Column(
                 children: [
                Container(child: Text("Current Plan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: PrimaryColor,), ),width: double.infinity,),
            
                SizedBox(height: 20,),

                   Container(
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: PrimaryColor.withOpacity(0.2),borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: PrimaryColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.plan.string, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          Text("INR ${controller.planPrice}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                 ],
               ):Container()),
            
                SizedBox(height: 20,),
            
            _tabSection(context),
            
            
              ],
            ),
            ],


          ),
        ),
      ),
    );
  }

Widget _tabSection(BuildContext context,) {
  return DefaultTabController(

    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child:GetBuilder<Maincontroller>(
            init: Maincontroller(),
            builder: (controller) => TabBar(
            onTap: (value) {
              controller.planType = value.obs;
              print(value);
              controller.update();
            },
            indicatorColor: Colors.transparent,
            indicator: UnderlineTabIndicator(),
           enableFeedback: true,
            dividerHeight: 0,
            tabs: [
            Container(child: Tab(child: Text("Monthly",style: TextStyle(color: controller.planType==0.obs?White:Black),),) , width: double.infinity,
            decoration: BoxDecoration(color: controller.planType==0.obs?PrimaryColor:Colors.transparent,borderRadius: BorderRadius.circular(20)),),

                        Container(child: Tab(child: Text("Yearly",style: TextStyle(color: controller.planType==1.obs?White:Black),),) , width: double.infinity,
            decoration: BoxDecoration(color: controller.planType==1.obs?PrimaryColor:Colors.transparent,borderRadius: BorderRadius.circular(20)),),
            


          ])),
        ),
        SizedBox(height: 20,),
        Container( 
          //Add this to give height
          height: MediaQuery.of(context).size.height,
          child: TabBarView(children: [
            Container(
              child: monthlyList(),
            ),
            
            Container(
              child: yearlyList(),
            ),
         
          ]),
        ),
      ],
    ),
  );
}
}

List<prices> ls = [

  prices("Basic","",0),
  prices("Starter",
'User access for Basic Health Record.'
'Manual Data Entry by Pregnant Women in the Application.'
'AI Enabled Risk Categorization.'
'Pregnant Women health data stored in the Application.' 
'Health Monitoring by your Hospital medical team. '
  
  ,99),
  prices("Premium",
  'User access for Automated Health Record.' 
  'Automatic Bluetooth Data Entry.' 
  'AI Enabled Risk Categorization.' 
  'Pregnant Women and Child health data stored in the Application. '
  'Interactive questions asked by the app regarding Mood, Sleep, Hydration.' 
  'Timely alerts for taking medication. '
  'Health Monitoring by your Hospital medical team.' 
  'Telemedicine.'
 ' Virtual consultation.' 
  'Broadcast messages regarding Camps, offers, other information. '
  'General Awareness Information from Hospital.' 
'Monitors Sleep, Activities, Reminders.' 
  ,299),
  prices("Executive","",399),



];



List<prices> lsYearly = [

  prices("Basic","",0),
  prices("Starter",
'User access for Basic Health Record.'
'Manual Data Entry by Pregnant Women in the Application.'
'AI Enabled Risk Categorization.'
'Pregnant Women health data stored in the Application.' 
'Health Monitoring by your Hospital medical team. '
  
  ,999),
  prices("Premium",
  'User access for Automated Health Record.' 
  'Automatic Bluetooth Data Entry.' 
  'AI Enabled Risk Categorization.' 
  'Pregnant Women and Child health data stored in the Application. '
  'Interactive questions asked by the app regarding Mood, Sleep, Hydration.' 
  'Timely alerts for taking medication. '
  'Health Monitoring by your Hospital medical team.' 
  'Telemedicine.'
 ' Virtual consultation.' 
  'Broadcast messages regarding Camps, offers, other information. '
  'General Awareness Information from Hospital.' 
'Monitors Sleep, Activities, Reminders.' 
  ,2990),
  prices("Executive","",3990),



];

class prices {
  prices(this.name,this.details,this.price);
  String name;
  String details;
  int price;
}

Widget monthlyList() {

  return Column(
    children: [

      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 10,),
        itemCount: ls.length,
        itemBuilder: (context, index) {

          prices c = ls[index];

          

          return  GetBuilder<Maincontroller>(
            init: Maincontroller(),
          builder: (controller)=>
          InkWell(
            onTap: () {
              controller.plan= c.name.obs;
              controller.planPrice = c.price;
              controller.update();
              
            },
            child: Container(
              width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color:controller.plan==c.name? PrimaryColor.withOpacity(0.1):White,borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: controller.plan==c.name ?PrimaryColor:Colors.grey)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${c.name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          Text("INR ${c.price}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                        ],
                      ),
SizedBox(height: 5,),

            
                      Visibility(
                        visible: c.details!="",
                        child: Text.rich(
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: PrimaryColor),
                                      TextSpan(
                                        children: c.details.split('.').map((item) => 
                                          TextSpan(
                                            text: item.trim() + '.\n',
                                            // style: TextStyle(height: 1.5),x
                                          )
                                        ).toList(),
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                      )
            
                      
                    ],
                  ),
                ),
          )
          );
        }, )
                    
    ],
  );
}

Widget yearlyList() {

  return Column(
    children: [

      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 10,),
        itemCount: ls.length,
        itemBuilder: (context, index) {

          prices c = lsYearly[index];

          

          return  GetBuilder<Maincontroller>(
            init: Maincontroller(),
          builder: (controller)=>
          InkWell(
            onTap: () {
              controller.plan= c.name.obs;
              controller.planPrice = c.price;
              controller.update();
              
            },
            child: Container(
              width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color:controller.plan==c.name? PrimaryColor.withOpacity(0.1):White,borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: controller.plan==c.name ?PrimaryColor:Colors.grey)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${c.name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          Text("INR ${c.price}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                        ],
                      ),
SizedBox(height: 5,),

            
                      Visibility(
                        visible: c.details!="",
                        child: Text.rich(
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: PrimaryColor),
                                      TextSpan(
                                        children: c.details.split('.').map((item) => 
                                          TextSpan(
                                            text: item.trim() + '.\n',
                                            // style: TextStyle(height: 1.5),x
                                          )
                                        ).toList(),
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                      )
            
                      
                    ],
                  ),
                ),
          )
          );
        }, )
                    
    ],
  );
}

