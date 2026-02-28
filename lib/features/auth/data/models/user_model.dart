import 'package:personal_expense_tracker/features/auth/domain/entities/user.dart';

class UserModel extends User{
  UserModel({required super.id, required super.email});

  factory UserModel.fromEmail(String email){
    return UserModel(
      id: email.hashCode.toString(), 
      email: email
    );
  }
}