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
    let symptoms: [String]? = []
    let description: String?
    
    init(date: NSDate, location: String, symptoms: [String], description: String) {
        self.date = date
        self.location = location
        if symptoms.count > 0 {
            for symptom in symptoms {
                self.symptoms?.append(symptom)
            }
        }
        self.description = description
        
    }
    
}

enum Symptom: String {
    case Heart
    case Sweat
    case Shake
    case Breath
    case Choke
    case Chest
    case Stomach
    case Dizzy
    case Numb
    case Chill
    case Other
}