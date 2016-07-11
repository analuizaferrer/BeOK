//
//  Record.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/11/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import Foundation

struct Item
{
    let date: NSDate?
    let location: String?
    let triggers: String?
    let symptoms: [Bool]?
    let description: String?
    
    init(date: NSDate, location: String, triggers: String, symptoms: [Bool], description: String) {
        self.date = date
        self.location = location
        self.triggers = triggers
        self.symptoms = symptoms
        self.description = description
        
    }
    
}