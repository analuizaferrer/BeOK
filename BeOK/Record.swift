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
    let symptoms: [Symptom]? = []
    let description: String?
    
    init(date: NSDate, location: String, symptoms: [Symptom], description: String) {
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

enum Symptom {
    case Heart(Bool)
    case Sweat(Bool)
    case Shake(Bool)
    case Breath(Bool)
    case Choke(Bool)
    case Chest(Bool)
    case Stomach(Bool)
    case Dizzy(Bool)
    case Numb(Bool)
    case Chill(Bool)
    case Other(String)
}