import UIKit
import Flutter
import Firebase // ← AJOUTÉ
import FirebaseMessaging // ← AJOUTÉ
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().delegate = self

    GMSServices.provideAPIKey("AIzaSyBMmWvPPlLQ4axlvp2kVMM3Xu1XQPlYpm4")
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


