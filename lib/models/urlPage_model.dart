class UrlPageModel {
  String? urlPage;

  UrlPageModel({
    this.urlPage,
  });
  UrlPageModel.fromJson(Map<String, dynamic> json) {
    urlPage = json['urlPage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'urlPage': urlPage,
    };
  }
}
