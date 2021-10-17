//
//  MainViewController.swift
//  Rocket
//
//  Created by Abraham Rubio on 12/08/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController, NSComboBoxDelegate {

    @IBOutlet var comboBox: NSComboBox!
    @IBOutlet var NSVisualOutlet: NSVisualEffectView!
    
    private let sf = ShellFull()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comboBox.delegate = self
        
        comboBox.addItem(withObjectValue: "Free Untethered Bypass")
        comboBox.addItem(withObjectValue: "GSM Untethered Bypass")
        comboBox.addItem(withObjectValue: "MEID/WIFI Untethered Bypass")
        comboBox.addItem(withObjectValue: "FMI OFF iOS 13+")
        comboBox.addItem(withObjectValue: "Bypass For Disabled/Passcode")
        comboBox.addItem(withObjectValue: "Bypass iPad 2 Untethered")
        sf.shellFull("/usr/local/bin/idevicepair unpair")
        sf.shellFull("/usr/local/bin/idevicepair pair")
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        //Adds transparency to the app
        NSVisualOutlet.window?.isOpaque = false
        NSVisualOutlet.window?.alphaValue = 0.98
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let itemSelec : String = comboBox.itemObjectValue(at: comboBox.indexOfSelectedItem) as! String
        switch itemSelec {
        case "Free Untethered Bypass": /* Free Untethered Bypass */
            performSegue(withIdentifier: "freeSG", sender: nil)
        case "GSM Untethered Bypass": /* GSM Untethered Bypass */
            performSegue(withIdentifier: "gsmSG", sender: nil)
        case "MEID/WIFI Untethered Bypass": /* MEID Untethered Bypass */
            performSegue(withIdentifier: "meidSG", sender: nil)
        case "FMI OFF iOS 13+": /* FMI OFF iOS 13+ */
            performSegue(withIdentifier: "fmiSG", sender: nil)
        case "Bypass For Disabled/Passcode": /* Bypass For Disabled/Passcode */
            performSegue(withIdentifier: "passcodeSG", sender: nil)
        default:
            dialogOKCancel(question: "No Selection", text: "Please select an option", style: .critical)
        }
    }
    
    func dialogOKCancel(question: String, text: String, style: NSAlert.Style) {
        
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.addButton(withTitle: "OK")
        alert.alertStyle = style
        alert.beginSheetModal(for: self.view.window!)
        
    }
}
