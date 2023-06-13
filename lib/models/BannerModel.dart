class BannerModel {
  final String photoUrl;

  BannerModel({ required this.photoUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      photoUrl: json['photo'] as String,
    );
  }
}