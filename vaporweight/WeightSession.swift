//
//  WeightSession.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/14/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import Foundation


class WeightSession {
    var startTime : NSDate
    var endTime : NSDate?
    var duration : Int?
    
    init(startTime: NSDate) {
        self.startTime = startTime
    }
}