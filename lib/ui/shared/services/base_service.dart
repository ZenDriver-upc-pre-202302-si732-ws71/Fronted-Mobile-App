class BaseService {
  final String baseUri = "https://zendrivers.azurewebsites.net";
  final String apiVersion = "api/v1";

  String produceUri(String endUri) => "$baseUri/$apiVersion/$endUri";
}