import 'package:faltu/constants/constants.dart';

class Profile {
  String name;
  String gender;
  String image;
  String phone;

  Profile({
    this.name,
    this.gender,
    this.image,
    this.phone,
  });

  static Profile fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json[Constants.PROFILE_NAME],
      gender: json[Constants.PROFILE_GENDER],
      image: json[Constants.PROFILE_IMAGE],
      phone: json[Constants.PROFILE_PHONE],
    );
  }

  Map<String, dynamic> toJson() => {
        Constants.PROFILE_NAME: name,
        Constants.PROFILE_GENDER: gender,
        Constants.PROFILE_IMAGE: image,
        Constants.PROFILE_PHONE: phone,
      };
}
