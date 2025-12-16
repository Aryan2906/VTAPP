import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
class VtopClient {
  static final cookieJar = CookieJar();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://vtop.vitbhopal.ac.in/vtop",
      followRedirects: true,
      validateStatus: (s) => s != null && s < 500,
      headers: {
        "User-Agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142 Safari/537.36",

        // AJAX headers
        "X-Requested-With": "XMLHttpRequest",        
        "Accept-Language": "en-US,en;q=0.9",
        "Origin": "https://vtop.vitbhopal.ac.in",
      },
    ),
  )
    ..interceptors.add(CookieManager(cookieJar))
    ..httpClientAdapter = IOHttpClientAdapter(
      validateCertificate: (X509Certificate, host, port) => true,
    );
}
