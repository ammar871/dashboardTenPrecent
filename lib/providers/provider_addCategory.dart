import 'package:flutter/cupertino.dart';


import 'package:http/http.dart' as http;

class ProviderAddCategory extends ChangeNotifier {

  bool loading = false;


  // uploadImage(filepath,String name) async {
  //    loading=true;
  //   var uri = Uri.parse("https://www.appweb.website/100top/api/dashboard/add-category?name=$name&");
  //    var request = http.MultipartRequest('POST', uri);
  //    request.files.add(await http.MultipartFile.fromPath('image', filepath));
  //    var res = await request.send();
  //
  //   if(res.statusCode==200){
  //
  //     loading=false;
  //     print(res);
  //
  //   }else{
  //     print("no");
  //     loading=false;
  //
  //   }
  //   notifyListeners();
  // }


  void uploadSelectedFile(filepath, String name) async {
    loading = true;
    var uri = Uri.parse(
        "https://www.appweb.website/100top/api/dashboard/add-category?");
    //---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      uri,
    );
    //-----add other fields if needed
    request.fields["name"] = name;

    //-----add selected file with request
    request.files.add(new http.MultipartFile(
        "image", filepath.readStream, filepath.size,
        filename: filepath.name));

    //-------Send request
    var resp = await request.send();

    //------Read response

    if (resp.statusCode == 200) {
      loading = false;
    } else {
      loading = false;
    }
    //-------Your response
    print(resp);
    notifyListeners();
  }
}