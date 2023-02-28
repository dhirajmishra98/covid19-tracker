import 'dart:convert';
import 'package:covid19_tracker_app/Services/api_collections.dart';
import "package:http/http.dart" as http;

import '../Model/WorldStatesModel.dart';

class StateServices{

  Future<WorldStatesModel> fetchWorldStateRecords () async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
  
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountryList () async{
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    } else{
      throw Exception("Error");
    }
  }


}