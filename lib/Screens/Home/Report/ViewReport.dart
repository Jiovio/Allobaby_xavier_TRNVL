import 'package:allobaby/Components/forms.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';

class ViewReport extends StatelessWidget {
  const ViewReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap:() => showDialog(
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Black,
                            child: Material(
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  InteractiveViewer(
                                    child: Center(
                                        child: 
                                    //     Image.memory(
                                    //   base64Decode(controller.fileImage64),
                                    // )

                                    Image.network("https://i.pinimg.com/736x/13/e5/85/13e585664a1df5f548812b47a11f0889.jpg")
                                    
                                    
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: White,
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

            child: Container(
                            height: MediaQuery.of(context).size.height / 3.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4)),
                            child: Image.network("https://i.pinimg.com/736x/13/e5/85/13e585664a1df5f548812b47a11f0889.jpg")
                            ),
            ),

                          SizedBox(
                height: 10.0,
              ),


          TextButton.icon(
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            height: MediaQuery.of(context).size.height / 5,
                            color: White,
                            padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Choose photo from :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                FloatingActionButton(
                                    elevation: 0,
                                    tooltip: "Camera",
                                    onPressed: () {},
                                        // reportController.getImageFromCamera(),
                                    backgroundColor: Colors.amberAccent,
                                    child: Image.asset(
                                      'assets/General/camera.png',
                                      scale: 16,
                                    )),
                                FloatingActionButton(
                                    elevation: 0,
                                    focusColor: Colors.greenAccent,
                                    tooltip: "Gallery",
                                    onPressed: () {},
                                        // reportController.getImageFromGallery(),
                                    backgroundColor: Colors.indigoAccent,
                                    child: Image.asset(
                                      'assets/General/gallery.png',
                                      scale: 16,
                                    )),
                              ],
                            ),
                          )),
                  icon: Icon(Icons.add_a_photo),
                  label: Text("UPDATE IMAGE")),

                                SizedBox(
                height: 8.0,
              ),

              Text("Report Date - 17-07-24",
                  style: TextStyle(fontSize: 16)),

                                SizedBox(
                height: 10,
              ),

              searchBox("Select Type of Report",["ECG", "Blood Test", "HCG"] ),
                            SizedBox(
                height: 12.0,
              ),

                            TextFormField(
                // controller: reportController.reportDesc,
                decoration: InputDecoration(
                    labelText: "Write Description",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.text,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Description';
                  }
                  return null;
                },
              ),
                            SizedBox(
                height: 18.0,
              ),

                            Row(
                children: [
                  Flexible(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(300, 50),
                            side: BorderSide(color: Colors.redAccent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            )),
                        onPressed: () {},
                            // reportController.deleteReport(reportDetails.id),
                        child: Text(
                          "DELETE REPORT",
                          style: TextStyle(color: Colors.redAccent),
                        )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onPressed: () {},
                            // reportController.updateReport(reportDetails.id),
                        child: Text("UPDATE REPORT")),
                  ),
                ],
              )
            
            
          ],
          ),
        
        ),
        ),
    );
  }
}