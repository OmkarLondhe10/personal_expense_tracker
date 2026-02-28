import 'package:personal_expense_tracker/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:personal_expense_tracker/features/auth/data/models/user_model.dart';
import 'package:personal_expense_tracker/features/auth/domain/entities/user.dart';
import 'package:personal_expense_tracker/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl(this.localDatasource);

  @override
  Future<User?> getCurrentUser() async {
    final email = await localDatasource.getsavedUserEmail();
    if(email==null) return null;
    return UserModel.fromEmail(email);
  }

  @override
  Future<User> login(String email, String password) async {
    await localDatasource.saveUserEmail(email);
    return UserModel.fromEmail(email);
  }

  @override
  Future<User> signup(String email, String password) async {
    await localDatasource.saveUserEmail(email);
    return UserModel.fromEmail(email);
  }

  @override
  Future<void> logout() async {
    await localDatasource.clearUser();
  }
}