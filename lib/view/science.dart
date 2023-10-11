import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/controller/science_controller.dart';


class SciencePage extends GetWidget {
  const SciencePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScienceController scienceController=Get.put(ScienceController());
    return Scaffold(
      body: FutureBuilder(
        future: scienceController.scienceData(),
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
                              Text(snapshot.data["articles"][index]["author"]),
                              Text(snapshot.data["articles"][index]["title"],style: const TextStyle(fontSize: 12,color: Colors.black38),),
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
