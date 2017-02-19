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

    enum TotalType: Int {
        case Split
        case Merge
    }

    // MARK: Calc Methods

    // - Parameters:
    //      - totalType: TotalType.Split or TotalType.Merge
    //      - billAmount: Bill for which tip is applied while calculating total amount
    //      - tipType: TipType.Generous (20%) or .Happy (15%) or .Decent (10%)
    func calculatTotal(totalType: TotalType, billAmount :Float, tipType: TipType) -> Float {

        return 0.0
    }

}
