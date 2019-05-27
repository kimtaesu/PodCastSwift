import Crashlytics
import Fabric
import Hero
import Kingfisher
import Moya
import RxCocoa
import RxOptional
import SnapKit
import Swinject
import Then
import UIKit
import FeedKit
struct AppDependency {
    let window: UIWindow
    let configureSDKs: () -> Void
}

final class CompositionRoot {

    static func resolve() -> AppDependency {
        let window = UIWindow()
        window.backgroundColor = .white
        window.makeKeyAndVisible()

        let iTuneService = rootContainer.resolve(iTuneServiceType.self)!
        let searchReactor = SearchReactor(iTuneService)
        window.rootViewController = UINavigationController(rootViewController: SearchViewController(reactor: searchReactor))

//        let episode = Episode(episode: 1, title: "title", pubDate: Date(), description: "iTunesSubtitle", author: "autor", imageUrl: "http://i1.sndcdn.com/artworks-000197032282-sh4431-original.jpg", streamUrl: "http://www.podtrac.com/pts/redirect.mp3/feeds.soundcloud.com/stream/296412630-cloud-tnt-concern-for-tomorrow-marisa-lopez.mp3", duration: 100, size: 80188636)
//        let streamReactor = StreamReactor(episode)
//        window.rootViewController = StreamViewController(reactor: streamReactor)
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
