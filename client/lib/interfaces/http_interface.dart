abstract class IClientHttp {
  Future post(String url);
  Future get(String url);
  Future update(String url);
  Future delete(String url);
}
