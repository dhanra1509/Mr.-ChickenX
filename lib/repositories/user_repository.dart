import 'package:mr_chicken_x/models/user.dart';

class UserRepository {
  UserModel? _userModel;

  UserModel? get userDataModel => _userModel;

  void saveUserData(UserModel userData) {
    _userModel = userData;
  }
}
