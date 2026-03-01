import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:personal_expense_tracker/features/dashboard/domain/usecase/get_dashboard_summary.dart';

class DashboardProvider extends ChangeNotifier{
  final GetDashboardSummary getDashboardSummary;

  DashboardProvider(this.getDashboardSummary);

  DashboardSummary? _summary;
  bool _isLoading = false;

  DashboardSummary? get summary => _summary;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    _summary = await getDashboardSummary();

    _isLoading = false;
    notifyListeners();
  }
}