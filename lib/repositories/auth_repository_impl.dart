import 'package:mr_chicken_x/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> login() async {
    print("User Login Successfully");
    return true;
  }
}
