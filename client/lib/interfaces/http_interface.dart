abstract class IClientHttp {
  Future post(String url, dynamic data);
  Future get(String url);
  Future update(String url,dynamic data);
  Future delete(String url);
}
