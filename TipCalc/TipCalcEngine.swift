//
//  TipCalcEngine.swift
//  TipCalc
//
//  Created by Nana on 2/18/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import Foundation

class TipCalcEngine {

    enum TipType: Int {
        case Generous
        case Happy
        case Decent
    }

    // MARK: Calc Methods

    func calculatTipAndTotals(billAmount :Float, tipType: TipType) -> (tipAmount: Float, totalFor1: Float, totalFor2: Float, totalFor3: Float, totalFor4: Float) {

        var tipPercentage: Float = 0.0

        switch tipType {
        case .Decent:
            tipPercentage = Float(UserPreferences.shared.preferredDecentTip)/100.0
        case .Happy:
            tipPercentage = Float(UserPreferences.shared.preferredHappyTip)/100.0
        case .Generous:
            tipPercentage = Float(UserPreferences.shared.preferredGenerousTip)/100.0
        }

        let tipAmount = billAmount * tipPercentage
        let totalAmount = billAmount + tipAmount


        return (tipAmount,totalAmount,totalAmount/2,totalAmount/3,totalAmount/4)
    }
}
