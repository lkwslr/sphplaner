import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'crypto.dart';

String generateUUID() {
  const pattern = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx-xxxxxx3xx';
  var uuid = '';
  for (var i = 0; i < pattern.length; i++) {
    if (pattern[i] == 'x' || pattern[i] == 'y') {
      uuid += Random().nextInt(16).toRadixString(16);
    } else {
      uuid += pattern[i];
    }
  }
  return uuid;
}

class SPH {
  final String user;
  final String password;
  String ikey = "";
  final int timeout = 30;
  final String baseDomain = "start.schulportal.hessen.de";
  final String baseURL = "https://start.schulportal.hessen.de";
  final String schoolID;
  Map _cookie = {};
  late RSACrypto rsa;
  AESCrypto aes = AESCrypto();
  String sessionKey = "";

  String get cookie {
    String buildCookie = "";
    for (String key in _cookie.keys) {
      buildCookie += "$key=${_cookie[key]}; ";
    }
    return buildCookie;
  }

  set cookie(String value) {
    _cookie[value.split("=")[0]] = value.split("=")[1];
  }

  SPH(this.user, this.password, this.schoolID) {
    _cookie = {"i": schoolID};
  }

  Future<String> login() async {
    sessionKey = aes.encrypt(generateUUID(), generateUUID());

    try {
      ikey = "";
      _cookie = {'i': schoolID};
      await getIkey();

      await getPublicKey();

      await postRSAHandshake();
      await ajaxLogin();

      await ajaxLoginUser();

      return "";
    } catch (error) {
      return "ERROR=$error";
    }
  }

  Future<void> getIkey() async {
    http.Response response = await get("/index.php?i=$schoolID");
    dom.Document doc = parse(response.body);

    for (dom.Element input in doc.getElementsByTagName('input')) {
      if (input.attributes['name'] == "ikey") {
        ikey = input.attributes['value'] ?? "";
        return;
      }
    }
    throw Exception("Unable to find ikey");
  }

  Future<void> getPublicKey() async {
    http.Response response = await get("/ajax.php?f=rsaPublicKey");
    Map data = jsonDecode(response.body);
    if (data.containsKey('publickey')) {
      rsa = RSACrypto(data['publickey']);
    } else {
      throw Exception("No public RSA-Key found");
    }
  }

  Future<void> postRSAHandshake() async {
    String encryptedSessionKey = rsa.encrypt(sessionKey);
    Map data = {'key': encryptedSessionKey};
    int s = Random().nextInt(1999);
    http.Response response = await post("/ajax.php?f=rsaHandshake&s=$s", data);
    Map rsp = jsonDecode(response.body);

    String decryptChallenge = aes.decrypt(rsp['challenge'], sessionKey);

    if (sessionKey != decryptChallenge) {
      throw Exception("Decrypted challenge does not match the session key!");
    }
  }

  Future<void> ajaxLogin() async {
    if (cookie.contains('sid')) {
      String sid = cookie.split("sid=")[1].split(";")[0];
      await post("/ajax_login.php", {'name': sid});
    } else {
      throw Exception("Cannot find sid");
    }
  }

  Future<void> ajaxLoginUser() async {
    String formData =
        "f=alllogin&art=all&sid=&ikey=$ikey&user=$user&passw=${Uri.encodeComponent(password)}";

    String encryptedFormData = aes.encrypt(formData, sessionKey);
    Map data = {'crypt': encryptedFormData};

    http.Response response = await post("/ajax.php", data);

    if (response.body.isEmpty || response.body.contains("Fehler")) {
      throw Exception("Failed to login<");
    }
  }

  Future<void> logout() async {
    await get("/index.php?logout=1");
  }

  Future<http.Response> get(String url) async {
    if (sessionKey.isEmpty &&
        !(url.startsWith("/index") || url.startsWith("/ajax"))) {
      String status = await login();
      if (status.isNotEmpty) {
        throw TimeoutException;
      }
    }
    http.Response response = await http
        .get(Uri.parse("$baseURL$url"), headers: {'Cookie': cookie}).timeout(
            Duration(seconds: timeout), onTimeout: () {
      throw TimeoutException;
    });

    for (MapEntry cookie in response.headers.entries) {
      if (cookie.key == 'set-cookie') {
        List cookies = cookie.value.toString().split(",");
        for (String cookieElement in cookies) {
          this.cookie = cookieElement.split("; ")[0];
        }
      }
    }
    return response;
  }

  Future<http.Response> post(String url, Map data) async {
    if (sessionKey.isEmpty &&
        !(url.startsWith("/index") || url.startsWith("/ajax"))) {
      String status = await login();
      if (status.isNotEmpty) {
        throw TimeoutException;
      }
    }
    http.Response response = await http
        .post(Uri.parse("$baseURL$url"),
            headers: {'Cookie': cookie}, body: data)
        .timeout(Duration(seconds: timeout), onTimeout: () {
      throw TimeoutException;
    });

    for (MapEntry cookie in response.headers.entries) {
      if (cookie.key == 'set-cookie') {
        List cookies = cookie.value.toString().split(",");
        for (String cookieElement in cookies) {
          this.cookie = cookieElement.split("; ")[0];
        }
      }
    }

    return response;
  }

  String encrypt(String plaintext) {
    return aes.encrypt(plaintext, sessionKey);
  }
}
