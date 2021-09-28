import UIKit
import Flutter
import NaverThirdPartyLogin
//네이버 로그인 모듈에서 에러 시 해당 pod에서 컨맨드+b로 빌드 후 사용 해보세요.
//yaml파일에서 해당 모듈을 다운 받고 다시 위 문장을 실행해주세요. 또는 import NaverThirdPartyLogin을 직접 입력해주세요.

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *){
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
    }else {
        let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
    }
    
    override func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
