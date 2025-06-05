import 'package:flutter/material.dart';
import '../features/auth/login_student/login_student_screen.dart';
import '../features/auth/login_admin/login_admin_screen.dart';
import '../features/auth/register/register_screen.dart';
import '../features/dashboard/student_dashboard_screen.dart';
import '../features/dashboard/admin_dashboard_screen.dart';
import '../features/candidate/candidate_profile_screen.dart';
import '../features/candidate/candidate_management_screen.dart';
import '../features/voting/voting_screen.dart';
import '../features/voting/live_results_screen.dart';
import '../features/voting/final_results_screen.dart';
import '../features/settings/user_settings_screen.dart';
import '../features/history/voter_history_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/schedule/election_schedule_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String register = '/register';
  static const String loginStudent = '/login-student';
  static const String loginAdmin = '/login-admin';
  static const String studentDashboard = '/student-dashboard';
  static const String adminDashboard = '/admin-dashboard';
  static const String candidateProfile = '/candidate-profile';
  static const String candidateManagement = '/candidate-management';
  static const String voting = '/voting';
  static const String liveResults = '/live-results';
  static const String finalResults = '/final-results';
  static const String userSettings = '/user-settings';
  static const String voterHistory = '/voter-history';
  static const String notifications = '/notifications';
  static const String electionSchedule = '/election-schedule';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes => {
        register: (context) => const RegisterScreen(),
        loginStudent: (context) => const LoginStudentScreen(),
        loginAdmin: (context) => const LoginAdminScreen(),
        studentDashboard: (context) => const StudentDashboardScreen(),
        adminDashboard: (context) => const AdminDashboardScreen(),
        candidateManagement: (context) => const CandidateManagementScreen(),
        voting: (context) => const VotingScreen(),
        liveResults: (context) => const LiveResultsScreen(),
        finalResults: (context) => const FinalResultsScreen(),
        userSettings: (context) => const UserSettingsScreen(),
        voterHistory: (context) => const VoterHistoryScreen(),
        notifications: (context) => const NotificationsScreen(),
        electionSchedule: (context) => const ElectionScheduleScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == candidateProfile) {
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => CandidateProfileScreen(
          candidateId: args['candidateId'] as String,
          candidateName: args['candidateName'] as String,
          candidateImage: args['candidateImage'] as String,
          candidatePosition: args['candidatePosition'] as String,
          candidateDescription: args['candidateDescription'] as String,
        ),
      );
    }
    return null;
  }
} 