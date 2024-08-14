import 'package:allobaby/Screens/Home/Awareness/StoryPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Awareness extends StatefulWidget {
  const Awareness({super.key});

  @override
  State<Awareness> createState() => _AwarenessState();
}

class _AwarenessState extends State<Awareness> {
   late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
    void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
                appBar: AppBar(
                  title: Text("Awareness"),
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),

                body: PageView.builder(
  itemCount: 2,
  controller: _pageViewController,
  itemBuilder: (context, index) => InkWell(
    onTap: (){_pageViewController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);},
    child: Storyplayer()),
),
    );
  }


  awarenessWhatsappStyle() {
    return PageView(

    );
  }
  noAwareness() {

    return Center(
                  child: Text(
                    "Sorry No Awareness Post".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                );
  }

  awarenessList() {

  }
}