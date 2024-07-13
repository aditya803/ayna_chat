import '../models/user.dart';

class AuthRepository {
  User? authenticate(String username, String password) {
    // Replace with actual authentication logic
    if (username == 'test' && password == 'password') {
      return User(username: username, password: password);
    }
    return null;
  }
}
