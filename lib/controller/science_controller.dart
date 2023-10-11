import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;


class ScienceController extends GetxController{
  int currentIndex=0;
  scienceData()async{
    try{
      final url =Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=90947d7a9b2e438aa5575a74a95a43c2");
      http.Response response= await http.get(url);
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }
    }catch(e){
      Get.snackbar("Error",e.toString());
    }
    update();
  }


}