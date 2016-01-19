//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Michael Bock on 1/18/16.
//  Copyright © 2016 Michael R. Bock. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!

    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
