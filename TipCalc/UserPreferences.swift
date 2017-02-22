//
//  UserPreferences.swift
//  TipCalc
//
//  Created by Nana on 2/21/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

// Defaults user preference values
struct DefaultPreferences {

    let totalType: Int = 1
    let tipType: Int = 2
    let decentTip: Float = 10
    let happyTip: Float = 15
    let generousTip: Float = 20
}

class UserPreferences {

    // Singleton Object
    static let shared = UserPreferences()

    let defaults: UserDefaults

    // Restricting explicit object instantiation
    private init() {

        let defaultPreferences = DefaultPreferences()

        defaults = UserDefaults.standard

        if defaults.object(forKey: "totalType") == nil {
            defaults.set(defaultPreferences.totalType, forKey: "totalType")
        }
        if defaults.object(forKey: "tipType") == nil {
            defaults.set(defaultPreferences.tipType, forKey: "tipType")
        }
        if defaults.object(forKey: "decentTip") == nil {
            defaults.set(defaultPreferences.decentTip, forKey: "decentTip")
        }
        if defaults.object(forKey: "happyTip") == nil {
            defaults.set(defaultPreferences.happyTip, forKey: "happyTip")
        }
        if defaults.object(forKey: "generousTip") == nil {
            defaults.set(defaultPreferences.generousTip, forKey: "generousTip")
        }

        defaults.synchronize()
    }

    var preferredTotalType: Int {
        get {
            return defaults.integer(forKey: "totalType")
        }
        set {
            defaults.set(newValue, forKey: "totalType")
        }
    }

    var preferredTipType: Int {
        get {
            return defaults.integer(forKey: "tipType")
        }
        set {
            defaults.set(newValue, forKey: "tipType")
        }
    }

    var preferredDecentTip: Float {
        get {
            return defaults.float(forKey: "decentTip")
        }
        set {
            defaults.set(newValue, forKey: "decentTip")
        }
    }

    var preferredHappyTip: Float {
        get {
            return defaults.float(forKey: "happyTip")
        }
        set {
            defaults.set(newValue, forKey: "happyTip")
        }
    }

    var preferredGenerousTip: Float {
        get {
            return defaults.float(forKey: "generousTip")
        }
        set {
            defaults.set(newValue, forKey: "generousTip")
        }
    }

    func saveUserPreferences() -> Void {
        // Synchronize user edited values to UserDefaults
        defaults.synchronize()
    }
}
