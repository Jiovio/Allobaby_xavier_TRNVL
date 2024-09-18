import 'package:flutter/material.dart';

class Avatarcard extends StatelessWidget {
 final String title;
 final String description;
 final String imgurl;
 const Avatarcard({super.key, required this.title,required this.description, required this.imgurl});

  @override
  Widget build(BuildContext context) {
    return  Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          title,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 8.0),
                                                          child: Text(description),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    height: 90,
                                                    // height: double.negativeInfinity,
                                                    width: 90,
                                                    child: Image.network(
                                                      imgurl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
  }
}