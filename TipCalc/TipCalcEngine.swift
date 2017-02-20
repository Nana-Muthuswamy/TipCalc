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

        let tipAmount: Float = 0.0
        let totalAmount: Float = 0.0

        return (tipAmount,totalAmount,totalAmount/2,totalAmount/3,totalAmount/4)
    }
}
