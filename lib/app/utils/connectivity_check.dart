import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCheck {
  // Private constructor
  ConnectivityCheck._singleton();

  // Singleton instance
  static final ConnectivityCheck _instance = ConnectivityCheck._singleton();

  // Factory constructor to return the singleton instance
  factory ConnectivityCheck() {
    return _instance;
  }

  // ConnectivityPlus instance
  final Connectivity _connectivity = Connectivity();

  // Method to check connectivity and throw error if no connection
  Future<void> ensureConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      throw Exception('No internet connection!');
    }
  }
}
