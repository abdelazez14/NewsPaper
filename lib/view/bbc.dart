import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/controller/news_controller.dart';
import 'package:get/get.dart';

class BBCPage extends GetWidget {
  const BBCPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put(NewsController());
    return Scaffold(
      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount:snapshot.data["articles"].length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              CachedNetworkImage(imageUrl: snapshot.data["articles"][index]["urlToImage"]!,
                                fit: BoxFit.fill,
                                height: 150,
                                width: double.infinity,
                              ),
                              Text(snapshot.data["articles"][index]["author"]),
                              Text(snapshot.data["articles"][index]["title"],style: TextStyle(fontSize: 12,color: Colors.black38),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
