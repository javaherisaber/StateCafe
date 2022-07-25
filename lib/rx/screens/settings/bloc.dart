import 'package:live_event/live_event.dart';

class SettingsBloc {
  final _showLogoutAlert = LiveEvent();
  final _navigateToLoginPage = LiveEvent();

  Stream get showLogoutAlert => _showLogoutAlert.stream;
  Stream get navigateToLoginPage => _navigateToLoginPage.stream;

  void onLogoutClick() {
    _showLogoutAlert.fire();
  }

  void onLogoutAlertPositiveClick() {
    _navigateToLoginPage.fire();
  }

  void dispose() {
    _showLogoutAlert.close();
    _navigateToLoginPage.close();
  }
}