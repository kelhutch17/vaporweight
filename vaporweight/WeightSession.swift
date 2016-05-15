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
    
    func setEnd(endT: NSDate) {
        self.endTime = endT
        self.duration = Int(self.endTime.timeIntervalSince1970 - self.startTime.timeIntervalSince1970)
}
