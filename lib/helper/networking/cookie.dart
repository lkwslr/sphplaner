import 'package:http/http.dart' as http;

class CookieStore {
  static Map _cookies = {};

  static _addCookie(String setCookie) {
    if (setCookie.toLowerCase().startsWith("set-cookie")) {
      setCookie = setCookie.substring(12);
    }
    List partCookie = setCookie.split("; ");
    Map<String, String> cookie = {
      "name": partCookie[0].toString().split("=")[0],
      "value": partCookie[0].toString().split("=")[1]
    };
    _cookies[cookie['name']] = cookie['value'];
  }

  static saveCookies(http.Response response) {
    for (MapEntry header in response.headers.entries) {
      if (header.key.toString().toLowerCase() == "set-cookie") {
        List cookies = header.value.toString().split(",");
        for (String cookie in cookies) {
          _addCookie(cookie);
        }
      }
    }
  }

  static getCookies() {
    String cookies = "";
    for (MapEntry cookie in _cookies.entries) {
      if (cookie.value != "") {
        cookies += "${cookie.key}=${cookie.value}; ";
      }
    }
    return cookies;
  }

  static getSID() {
    if (_cookies.containsKey('sid')) {
      return _cookies['sid'];
    }
    return "";
  }

  static clearCookies() {
    _cookies = {};
  }
}
