class Apiroutes {
  String baseUrl = "http://localhost:8000";

  String otpSessionCreation = "/auth/otp";

  String getUrl(String route){

    return baseUrl+route;
  }
}