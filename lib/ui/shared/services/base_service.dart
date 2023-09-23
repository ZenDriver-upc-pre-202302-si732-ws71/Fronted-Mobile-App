class BaseService {
  //final String baseUri = "https://zendrivers.azurewebsites.net";
  final String baseUri = "https://localhost:7078";
  final String apiVersion = "api/v1";

  String produceUri(String endUri) => "$baseUri/$apiVersion/$endUri";
}