class ValidateURL {
  final String url;
  ValidateURL({this.url});
  String validateUrl() {
    String trimmedUrl = url.replaceAll(" ", "");
    if (trimmedUrl.contains("https://", 0)) {
      return trimmedUrl;
    }
    return ("https://" + trimmedUrl);
  }
}
