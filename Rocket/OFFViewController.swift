//
//  OFFViewController.swift
//  Rocket
//
//  Created by Abraham Rubio on 12/08/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Cocoa

class OFFViewController: NSViewController {

    @IBOutlet weak var offDataTextF: NSTextField!
    public var textFieldText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offDataTextF.stringValue = textFieldText
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func goBackButton(_ sender: NSButton) {
        self.dismiss(self)
    }
    
}
