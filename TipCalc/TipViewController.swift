//
//  TipViewController.swift
//  TipCalc
//
//  Created by Nana on 2/16/17.
//  Copyright © 2017 Nana. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipType: UISegmentedControl!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var totalType: UISegmentedControl!

    @IBOutlet weak var totalFor2: UILabel!
    @IBOutlet weak var totalFor3: UILabel!
    @IBOutlet weak var totalFor4: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func billAmountChanged(_ sender: UITextField) {
        print("Bill: \(sender.text!)")
    }

}

