import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppFirebaseService {
  AppFirebaseService._internal();
  static final AppFirebaseService instance = AppFirebaseService._internal();

  // 1. Firebase Analytics
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // 2. Firebase Storage
  final FirebaseStorage storage = FirebaseStorage.instance;

  // 3. Firebase Remote Config
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  // 4. Firebase Messaging
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Khởi tạo và thiết lập toàn bộ các dịch vụ phụ trợ
  Future<void> initServices() async {
    // --- Khởi tạo Crashlytics (chỉ hỗ trợ Mobile/Desktop, không hỗ trợ Web) ---
    if (!kIsWeb) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    // --- Khởi tạo Remote Config ---
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await remoteConfig.setDefaults({
        'welcome_message': 'Chào mừng bạn đến với UTH Todo!',
        'show_banner': true,
      });
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Lỗi khởi tạo Remote Config: $e');
    }

    // --- Khởi tạo Firebase Cloud Messaging (FCM) ---
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('FCM: Quyền thông báo đã được cấp');
      }
    } catch (e) {
      debugPrint('Lỗi khởi tạo FCM: $e');
    }
  }

  // --- Analytics Helpers ---
  Future<void> logTaskCreated(String category) async {
    await analytics.logEvent(
      name: 'create_task',
      parameters: {'category': category},
    );
  }

  Future<void> logTaskCompleted(String taskId) async {
    await analytics.logEvent(
      name: 'complete_task',
      parameters: {'task_id': taskId},
    );
  }

  Future<void> logLoginSuccess(String method) async {
    await analytics.logLogin(loginMethod: method);
  }

  // --- Remote Config Helpers ---
  String getWelcomeMessage() {
    return remoteConfig.getString('welcome_message');
  }

  bool isBannerEnabled() {
    return remoteConfig.getBool('show_banner');
  }

  // --- Storage Helper: Tải lên Avatar ---
  Future<String?> uploadAvatar({
    required String userId,
    required Uint8List imageBytes,
  }) async {
    try {
      final ref = storage.ref().child('avatars').child('$userId.jpg');
      final uploadTask = await ref.putData(
        imageBytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      debugPrint('Lỗi tải ảnh lên Storage: $e');
      return null;
    }
  }

  // --- Crashlytics Helper ---
  void recordNonFatalError(dynamic exception, StackTrace? stack) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(exception, stack, fatal: false);
    } else {
      debugPrint('NonFatalError: $exception');
    }
  }
}
