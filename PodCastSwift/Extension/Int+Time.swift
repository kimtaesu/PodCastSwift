//
//  Float+Time.swift
//  PodCastSwift
//
//  Created by tskim on 25/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

extension Int {
    var formatTime: String {
        let hour = self / 3_600
        // swiftlint:disable number_separator
        let minute = self % 3600 / 60
        let second = self % 60

        var timeFormat: String = ""

        timeFormat += String(format: "%02d:%02d", minute, second)

        if hour > 0 {
            // adding hour
            timeFormat = String(format: "%02d:", hour) + timeFormat
        }
        return timeFormat
    }
}
