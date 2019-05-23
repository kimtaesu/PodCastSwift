import Nimble
import Quick
import FeedKit
@testable import PodCastSwift

class EpisodeTest: QuickSpec {
    override func spec() {
        describe("A PodcastTest") {
            it("parse Podcast") {
                let data = ResourcesLoader.readData("sample_episode", type: "rss")
                let rss = FeedParser(data: data).parse()
                let firstRssFeed = rss.rssFeed?.items?[0]
                let actual = Episode(feedItem: firstRssFeed!)
                expect(actual.title.isNotEmpty) == true
            }
        }
    }
}

