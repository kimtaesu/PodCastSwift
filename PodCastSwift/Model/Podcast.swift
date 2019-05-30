//
//  Medium.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import Foundation
// MARK: - Result

struct Podcast: Decodable, Equatable {
//    let wrapperType: WrapperType
//    let kind: Kind
//    let artistID: Int?
//    let collectionID: Int
    let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
//  let  collectionName, trackName, collectionCensoredName: String
//    let trackCensoredName: String
//    let artistViewURL: String?
//    let collectionViewURL: String?
    let feedUrl: String?
//    let trackViewURL: String?
//    let artworkUrl30, artworkUrl60, artworkUrl100: String
//    let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Double?
//    let trackHDPrice, trackHDRentalPrice: Int?
    let releaseDate: String
//    let collectionExplicitness, trackExplicitness: Explicitness
    let trackCount: Int
//    let country: Country
//    let currency: Currency
    let primaryGenreName: String
    let artworkUrl60: String
    let artworkUrl600: String
//    let genreIds,
//    let genres: [String]

    enum CodingKeys: String, CodingKey {
//        case wrapperType, kind
//        case artistID
//        case collectionID
        case trackId
        case artistName
        case collectionName
        case trackName
//        case collectionName, trackName, collectionCensoredName, trackCensoredName
//        case artistViewURL
//        case collectionViewURL
        case feedUrl
        case trackCount
//        case trackViewURL
// collectionPrice, trackPrice, trackRentalPrice
//        case collectionHDPrice
//        case trackHDPrice
//        case trackHDRentalPrice
        case releaseDate
//        collectionExplicitness, trackExplicitness, trackCount, country, currency,
        case primaryGenreName
        case artworkUrl60
        case artworkUrl600
//        case genreIds
//        case genres
    }
}

//enum WrapperType: String, Decodable {
//    case track
//    case collection
//    case artistFor
//}
//
//enum Kind: String, Decodable {
//    case musicVideo = "music-video"
//    case pdfPodcast = "pdf podcast"
//    case podcastEpisode = "podcast-episode"
//    case podcast
//}
//
//enum Explicitness: String, Decodable {
//    case cleaned
//    case explicit
//    case notExplicit
//}
//
//enum Country: String, Decodable {
//    case usa = "USA"
//}
//
//enum Currency: String, Decodable {
//    case usd = "USD"
//}
