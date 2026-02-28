import 'package:personal_expense_tracker/features/auth/domain/entities/user.dart';
import 'package:personal_expense_tracker/features/auth/domain/repositories/auth_repository.dart';

class SignupUser {
  final AuthRepository repository;

  SignupUser(this.repository);

  Future<User> call(String email, String password){
    return repository.signup(email, password);
  }
}