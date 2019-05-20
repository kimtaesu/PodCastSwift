import Crashlytics
import Fabric
import Hero
import RxCocoa
import RxOptional
import SnapKit
import Swinject
import Then
import UIKit

struct AppDependency {
    let window: UIWindow
    let configureSDKs: () -> Void
}

final class CompositionRoot {
    
    static func resolve() -> AppDependency {
        let window = UIWindow()
        window.backgroundColor = .white
        window.rootViewController = SearchViewController()
        window.makeKeyAndVisible()
        
        return AppDependency(
            window: window,
            configureSDKs: configureSDKs
        )
    }
    
    static func configureSDKs() {
        Fabric.with([Crashlytics.self])
//        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
//        let options = FirebaseOptions(contentsOfFile: filePath!)
//        FirebaseApp.configure(options: options!)
    }
}
