class AzkarMusicModel {
  String? name;
  String? url;
  String? id;

  AzkarMusicModel({
    this.name,
    this.url,
    this.id,
  });

  AzkarMusicModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'id': id,
    };
  }
}
