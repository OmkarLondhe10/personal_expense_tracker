import 'package:personal_expense_tracker/features/auth/domain/entities/user.dart';
import 'package:personal_expense_tracker/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call(String email, String password){
    return repository.login(email, password);
  }
}