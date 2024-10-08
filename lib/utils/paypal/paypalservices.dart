import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'dart:convert' as convert;

class PaypalServices {
  String domain = "https://api.sandbox.paypal.com";
  String clientId = "Ab4vS4vmfQFgUuQMH49F9Uy3L1FdNHtfGrASCyjNijm_EkHWCFM96ex0la-YFbwavw41R3rTKU3k_Bbm";
  String secret = "EDjvPfYgTYqdYWR2BfOiBW4dz_jeeuadqH7Z98pZMDvY33PcViiooqYFWVPFSGbfKBfNOb3LnroSI1hv";

  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      print("ClientCredential::"+client.username+" "+client.password);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return "0";
    }
    catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>?> createPaypalPayment(transaction, access_token) async {
    print("ACCESS-TOKEN::"+access_token.toString());
    try {
      var response = await http.post(Uri.parse('$domain/v1/payments/payment'),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer" + access_token
          });
      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "Content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}

