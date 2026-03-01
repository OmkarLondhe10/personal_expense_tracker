import 'package:personal_expense_tracker/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:personal_expense_tracker/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardSummary {
  final DashboardRepository repository;

  GetDashboardSummary(this.repository);

  Future<DashboardSummary> call() {
    return repository.getSummary();
  }

}