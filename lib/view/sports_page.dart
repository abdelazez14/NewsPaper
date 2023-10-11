import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/controller/sports_controller.dart';


class SportsPage extends GetWidget {
  const SportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SportsController sportsController=Get.put(SportsController());

    return Scaffold(
      body: FutureBuilder(
        future: sportsController.sportsData(),
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
                              // CachedNetworkImage(imageUrl: snapshot.data["articles"][index]["urlToImage"]!,
                              //   fit: BoxFit.fill,
                              //   height: 150,
                              //   width: double.infinity,
                              // ),
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
