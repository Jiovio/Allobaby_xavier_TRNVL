import 'package:allobaby/API/Requests/NewsAPI.dart';
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

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // This allows content to flow behind the app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 16, top: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          // title: Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //   decoration: BoxDecoration(
          //     color: Colors.black.withOpacity(0.3),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child:const Text(
          //     "Awareness",
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 18,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ),
      ),
      body: FutureBuilder(
        future: Newsapi.getReels(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Stack(
              children: [
                // PageView
                PageView.builder(
                  itemCount: data.length,
                  controller: _pageViewController,
                  scrollDirection: Axis.vertical, // Optional: Make it scroll vertically like TikTok
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      _pageViewController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                    },
                    child: Storyplayer(
                      url: data[index]["videourl"],
                      title: data[index]["title"],
                      description: data[index]["description"],
                    ),
                  ),
                ),
                
                // Optional: Page indicator
                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          data.length,
                          (index) => Container(
                            width: 4,
                            height: 20,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: _pageViewController.positions.isNotEmpty &&
                                      _pageViewController.page?.round() == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_library_outlined,
                    size: 48,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Sorry No Awareness Post".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}