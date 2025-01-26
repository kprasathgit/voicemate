import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:voicemate/src/common/url.dart';

class GoogleAuthService {
  var headers = {'Content-Type': 'application/json'};

  // final GoogleSignIn googleSignIn = GoogleSignIn(
  //   scopes: ['email', 'profile'],
  // );

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      // final GoogleSignInAccount? googleSignInAccount =
      //     await googleSignIn.signInSilently();

      // GoogleSignInAuthentication auth;
      // String? idToken;
      // if (googleSignInAccount != null) {
      //   auth = await googleSignInAccount.authentication;
      //   idToken = googleSignInAccount.id;
      // } else {
      //   if (kIsWeb) {
      //     googleSignIn.signIn();
      //     return null; // Return null to indicate button rendering
      //   } else {
      //     // Initiate regular sign-in for mobile platforms
      //     final GoogleSignInAccount? newSignInAccount =
      //         await googleSignIn.signIn();
      //     if (newSignInAccount != null) {
      //       auth = await newSignInAccount.authentication;
      //       idToken = newSignInAccount.id;
      //     } else {
      //       return null; // User canceled the sign-in process
      //     }
      //   }
      // }

      // auth.idToken;
      // if (idToken != null) {
      //   final String sessionToken = await sendTokenToBackend(idToken);
      //   return googleSignInAccount;
      // }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> sendTokenToBackend(String idToken) async {
    var response = await http.post(Uri.parse(Urls.googleAuthUrl),
        headers: headers, body: jsonEncode({"idToken": idToken}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['sessionToken'];
    }
    throw Exception("Failed to validate token with backend: ${response.body}");
  }

  Future webSignIn(String id) async {
    try {
      var request = http.Request("POST",
          Uri.parse("http://localhost:8085/usermanagement/oauth/userregister"));

      request.headers.addAll(headers);
      request.body = id;

      http.StreamedResponse streamedResponse = await request.send();
      if (streamedResponse.statusCode != 200) {
        var errbody = json.decode(await streamedResponse.stream.bytesToString())
            as Map<String, dynamic>;
      }

      // headers.addAll({'Authorization': 'Bearer $id'});
      // var response = await http.get(
      //   Uri.parse("http://localhost:8085/usermanagement/oauth/userregister"),
      //   headers: headers,
      // );

      // if (response.statusCode == 200) {
      //   print("Response: ${response.body}");
      // } else {
      //   print("Error: ${response.statusCode}, Body: ${response.body}");
      // }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Future<List<CustomerDetail>> getUserPlans(String mobileNo) async {
  //   try {
  //     // Ensure internet connection
  //     await Commonwidget.ensureInternet();
  //     var requestAutorization = await CommonValues.secureKey();
  //     String encryptedRequest = await CommonValues.encryptRequestData(mobileNo);

  //     var request = http.Request("POST", Uri.parse(CommonUrl.registration));
  //     request.headers.addAll(headers);
  //     request.headers.addAll({'Authorization': 'Bearer $requestAutorization'});

  //     if (CommonValues.getCookie()) {
  //       request.headers.addAll({
  //         'Cookie':
  //             'JWebScheme=${SignUpController.loginAppUser!.logInCredential}'
  //       });
  //     } else if (CommonValues.appUser != null) {
  //       request.headers.addAll(
  //           {'Cookie': 'JWebScheme=${CommonValues.appUser!.LogInCredential}'});
  //     }
  //     request.body = encryptedRequest;

  //     http.StreamedResponse streamedResponse = await request.send();

  //     if (streamedResponse.statusCode != 200) {
  //       // var errbody = json.decode(await streamedResponse.stream.bytesToString())
  //       //     as Map<String, dynamic>;
  //       // return Future.error(errbody["returnObject"] ?? "Somethng Went Wrong");
  //       return Future.error(CommonValues.commonException);
  //     }
  //     // var body = json.decode(await streamedResponse.stream.bytesToString());

  //     DataResponseParam body = DataResponseParam.fromMap(
  //         json.decode(await streamedResponse.stream.bytesToString())
  //             as Map<String, dynamic>);
  //     var data = json.decode(await CommonValues.decryptKey(body.toJson()))
  //         as Map<String, dynamic>;

  //     List<CustomerDetail> lstCustomerDetails = List.empty(growable: true);

  //     if (data.isNotEmpty && data['status']) {
  //       var lstDynamic = data['returnObject'] as List<dynamic>;
  //       if (lstDynamic.isEmpty) {
  //         // return Future.error(const Text('Customer Details Not Found..!'));
  //         return [];
  //       }
  //       for (Map<String, dynamic> element in lstDynamic) {
  //         lstCustomerDetails.add(CustomerDetail.fromMap(element));
  //       }
  //       return lstCustomerDetails;
  //     }
  //     if (data.isNotEmpty && !data['status']) {
  //       return Future.error(data['returnObject']);
  //     }
  //     return [];
  //   } on SocketException {
  //     return Future.error(CommonValues.socketException);
  //   } on Exception {
  //     // return Future.error(e.toString());
  //     return Future.error(CommonValues.commonException);
  //   }
  // }
}
