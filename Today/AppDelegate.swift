//
//  AppDelegate.swift
//  Today
//
//  Created by İsmail Can Akgün on 11.12.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /* AppDelegate.swift'i açın. application(_:didFinishLaunchingWithOptions:) işlevinde, gezinme çubuğunun varsayılan görünümünün renk tonunu değiştirin.

         UINavigationBar sınıfının görünümüne değişiklikler uygulayarak uygulamanızdaki tüm gezinme çubuklarının varsayılan görünümünü değiştirirsiniz.*/
        UINavigationBar.appearance().tintColor = .todayPrimaryTint
        // Gezinme çubuğunun varsayılan görünümünün arka plan rengini değiştirin.
        // Bugün'de kullanacağınız renklerin varlık kataloğunda tanımlandığını hatırlayın.
        UINavigationBar.appearance().backgroundColor = .todayNavigationBackground
        // Yeni bir UINavigationBarAppearance oluşturun ve bunu navBarAppearance adlı bir sabite atayın.
        let navBarAppearance = UINavigationBarAppearance()
        // Gezinme çubuğunu geçerli temaya uygun opak renklerle yapılandırmak için yapılandırma WithOpaqueBackground() örnek yöntemini çağırın.
        navBarAppearance.configureWithOpaqueBackground()
        /*
         Deney
         Opak arka planı yarı saydam bir gezinme çubuğu arka planıyla karşılaştırın,configureBackground().
         
         Yeni görünümü varsayılan kaydırma kenarı görünümü yapın.
         
         Liste görünümünün içeriğinden bazıları gezinme çubuğunun arkasında görünür. Kaydırılan içerik gezinme çubuğuna ulaşırsa, UIKit varsayılan görünüm ayarlarını uygular.
         */
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

