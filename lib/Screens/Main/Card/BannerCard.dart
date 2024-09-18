import 'package:flutter/material.dart';

class Bannercard extends StatelessWidget {
 final String title;
 final String description;
 final String imgurl;
 const  Bannercard({super.key, required this.title,required this.description, required this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(

                                                children: [
                                                 
                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Text(
                                                            title,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                        
                                                                        ),
                                                          ),
                                                        ),

                                                        SizedBox(height: 10,),

                                                                                                          Container(
                                                    height: 180,
                                                    width:double.infinity,
                                                    child: Image.network(
                                                      imgurl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(description),
                                                      
                                              

                                                ],
                                              ),
                                            ),
                                          );
  }
}