class AyatModel {
  String? name;

  AyatModel({
    this.name,
  });
  AyatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
