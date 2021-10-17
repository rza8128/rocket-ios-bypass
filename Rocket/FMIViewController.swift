//
//  FMIViewController.swift
//  Rocket
//
//  Created by Abraham Rubio on 12/08/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class FMIViewController: NSViewController {
    
    private let sf = ShellFull()
    private var timer = Timer()
    private let cryp = Cryptic()
    
    public var SerialNumber = String()
    public var UDID = String()
    public var AppleIMD: String = ""
    public var AppleIMDM: String = ""
    public var AppleITZ: String = ""
    public var DevLocData: String = ""
    public var DevDSID: String = ""
    public var DevLocToken: String = ""
    public var offMessage = String()
    private let masterKey = "UKdob21Nds8UMs4s5Q1FADVLWbGL7f"
    private var deviceClass = String()
    private var deviceName = String()
    private var prodType = String()
    private var alreadyPaid = Bool()
    
    @IBOutlet weak var fmiBtnOutlet: NSButton!
    
    @IBOutlet weak var serialNumberLbl: NSTextField!
    @IBOutlet weak var udidLbl: NSTextFieldCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.udidLbl.isSelectable = true
        // Do any additional setup after loading the view.
        //fmiOFF()
        runUSBListener()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "offTextSegue" {
            if let nextViewController = segue.destinationController as? OFFViewController {
                nextViewController.textFieldText.append(try! cryp.encryptMessage(self.DevLocToken + "@" + self.AppleIMD + "@" + self.AppleIMDM, Constants.HTTP_BEARER))
            }
        }
    }
    
    @IBAction func homeButton(_ sender: NSButton) {
        self.dismiss(self)
    }
    
    @IBAction func fmiButton(_ sender: NSButton) {
        verUDID()
        
    }
    
    func fmiOFFCheck(){
        let sf = ShellFull()
        sf.shellFull("killall -9 iproxy")
        sf.shellFull("rm ~/.ssh/known_hosts")
        sf.shellFull("/usr/local/bin/iproxy 2222 44 &>/dev/null &")
        
        let (prodVer, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k ProductVersion")
        if(prodVer.contains("13")){
            /* Download and Chmod files */
            let partyPath = Bundle.main.url(forResource: "party", withExtension: "tar.gz")
            let partyB: String = partyPath!.path
            sf.shellFull(constParser(Constants.SHELL_CP) + partyB + " root@localhost:/tmp/")
            let (suc, err) = sf.shellFull(constParser(Constants.SHELL_SSH) + "tar zxvf /tmp/party.tar.gz --directory /usr/libexec")
            sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /tmp/party.tar.gz")
            //print("*suc[\(suc)]")
            //print("*err[\(err)]")
            
            /* Get Device INFO */
            (self.deviceClass, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k DeviceClass")
            (self.deviceName, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k DeviceName")
            (self.prodType, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k ProductType")
            
            
            /* Get Device Data*/
            let (udid, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k UniqueDeviceID")
            let (dData, dJson) = sf.shellFull(constParser(Constants.SHELL_SSH) + "/usr/libexec/serial " + udid) //serial
            GetSerialNumber(dData)
            GetXA(dJson)
            
            let (dDevLoc, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + "/usr/libexec/assistant -f \"\(constParser(Constants.DEV_LOC_TOK))\"") //asistant
            GetDevLocData(dDevLoc)
            
            let (dDevDSID, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.FMI_ACC))
            GetDSID(dDevDSID)
            
            if(GetDevLocToken()){
                let dateFormatter : DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let date = Date()
                let dateString = dateFormatter.string(from: date)
                let tok = try! cryp.encryptMessage(self.DevLocToken + "@" + self.AppleIMD + "@" + self.AppleIMDM + "@" + dateString, Constants.HTTP_BEARER)
                //print(tok)
                doCheck("check", tok)
                //dialogOKCancel(question: "Your Device is Compatible", text: "You can now pay for this device in order to FMI OFF", style: .informational)
                //performSegue(withIdentifier: "offTextSegue", sender: nil)
            }
            else{
                dialogOKCancel(question: "NO COMPATIBLE / NO DATA", text: "PLEASE DO NOT PAY FOR THIS DEVICE", style: .critical)
            }
            
            //print("*GlobalSerialNumber[\(self.SerialNumber)]")
            //print("*GlobalAppleIMD[\(self.AppleIMD)]")
            //print("*GlobalAppleIMDM[\(self.AppleIMDM)]")
            //print("*GlobalAppleITZ[\(self.AppleITZ)]")
            //print("*GlobalDeviceLocatorData[\(self.DevLocData)]")
            //print("*GlobalDeviceDSID[\(self.DevDSID)]")
            //print("*GlobalDevLocToken[\(self.DevLocToken)]")
            
            //GET ADN FIX DATE
            
            /* CLEANUP*/
            sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /usr/libexec/serial")
            sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /usr/libexec/assistant")
            sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /usr/libexec/udid")
            sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /usr/libexec/db")
            
            
        }
        else if(prodVer.contains("ERROR: No device found")){
            dialogOKCancel(question: "Connection Failed", text: "ERROR: No device found", style: .critical)
        }
        else{
            dialogOKCancel(question: "Wrong iOS Version", text: "Only iOS 13 Support", style: .critical)
        }
                
        
        sf.shellFull("killall -9 iproxy")
    }
    
    func doCheck(_ action: String, _ token: String){
        //print("*serialNumber[\(serialNumber.count)]")
        //print("PARAMS[" + self.masterKey + "][" + self.UDID + "]")
        let parameters = ["action": action, "token": token]
        AF.request(constParser(Constants.SRV_FMI_OFF_SVC), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            //print("response: \(response)")
            switch response.result {
            case .success(let value):
                if value.contains("200"){
                    if(self.alreadyPaid){
                        let dateFormatter : DateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                        let date = Date()
                        let dateString = dateFormatter.string(from: date)
                        let tok = try! self.cryp.encryptMessage(self.DevLocToken + "@" + self.AppleIMD + "@" + self.AppleIMDM + "@" + dateString, Constants.HTTP_BEARER)
                        self.doRemove("remove", tok)
                    }else{
                        print("*compatibility[SUCCESS]")
                        self.dialogOKCancel(question: "Your Device is Compatible", text: "You can now pay for this device in order to FMI OFF", style: .informational)
                    }
                }
                else if value.contains("434"){
                    self.dialogOKCancel(question: "HUMAN INTERACTION NEEDED", text: "Your device is compatible but need to be done manually, send token to: https://twitter.com/Sw0rdF", style: .critical)
                    self.performSegue(withIdentifier: "offTextSegue", sender: nil)
                }
                else {
                    print("*compatibility[FAILED]")
                    self.dialogOKCancel(question: "NO COMPATIBLE / NO DATA", text: "PLEASE DO NOT PAY FOR THIS DEVICE", style: .critical)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func doRemove(_ action: String, _ token: String){
        //print("*serialNumber[\(serialNumber.count)]")
        //print("PARAMS[" + self.masterKey + "][" + self.UDID + "]")
        let parameters = ["action": action, "token": token, "DeviceClass": self.deviceClass, "DeviceName": self.deviceName, "ProductType": self.prodType]
        AF.request(constParser(Constants.SRV_FMI_OFF_SVC), method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            //print("response: \(response)")
            switch response.result {
            case .success(let value):
                if value.contains("200"){
                    print("*compatibility[SUCCESS]")
                    self.dialogOKCancel(question: "iCloud Removal Completed", text: "You can now check for FMI OFF in https://iunlocker.com/check_icloud.php", style: .informational)
                }
                else if value.contains("434"){
                    self.dialogOKCancel(question: "HUMAN INTERACTION NEEDED", text: "Your device is compatible but need to be done manually, send token to: https://twitter.com/Sw0rdF", style: .critical)
                    self.performSegue(withIdentifier: "offTextSegue", sender: nil)
                }
                else if value.contains("201"){
                    self.dialogOKCancel(question: "NO FOUND OR ALREADY REMOVED", text: "Please check for FMI OFF STATUS in https://iunlocker.com/check_icloud.php", style: .critical)
                }
                else {
                    print("*compatibility[FAILED]")
                    self.dialogOKCancel(question: "UNKNOWN STATUS", text: "Please contact support, send token to: https://twitter.com/Sw0rdF", style: .critical)
                    self.performSegue(withIdentifier: "offTextSegue", sender: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func verUDID(){
        //print("*serialNumber[\(serialNumber.count)]")
        //print("PARAMS[" + self.masterKey + "][" + self.UDID + "]")
        let parameters = ["masterkey": self.masterKey, "masterudid": self.UDID]
        AF.request(constParser(Constants.SRV_VR_FMI), parameters: parameters).responseString { response in
            //print("response: \(response)")
            switch response.result {
            case .success(let value):
                if value.contains("SUCCX999"){
                    print("*prepare[SUCCESS]")
                    self.alreadyPaid = true
                    self.fmiOFFCheck()
                    //self.performSegue(withIdentifier: "offTextSegue", sender: nil)
                }else {
                    print("*prepare[CHECK]")
                    self.alreadyPaid = false
                    self.fmiOFFCheck()
                    //self.dialogOKCancel(question: "UDID NOT REGISTERED", text: "Please register in https://sw0rdf1sh.mx/", style: .critical)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func GetSerialNumber(_ serialNumber: String){
        let dataArr = serialNumber.components(separatedBy: "\n")
        for line in dataArr {
            if(line.contains("Serial: ")){
                self.SerialNumber = line.replacingOccurrences(of: "Serial: ", with: "")
            }
        }
    }
    
    func GetXA(_ inData: String){
        let inDArr = inData.components(separatedBy: "\n")
        for line in inDArr {
            if(line.contains("    \"X-Apple-I-MD\" = \"")){
                self.AppleIMD = line.replacingOccurrences(of: "    \"X-Apple-I-MD\" = \"", with: "").replacingOccurrences(of: "\";", with: "")
            }
            else if(line.contains("    \"X-Apple-I-MD-M\" = \"")){
                self.AppleIMDM = line.replacingOccurrences(of: "    \"X-Apple-I-MD-M\" = \"", with: "").replacingOccurrences(of: "\";", with: "")
            }
            else if(line.contains("    \"X-Apple-I-TimeZone\" = ")){
                self.AppleITZ = line.replacingOccurrences(of: "    \"X-Apple-I-TimeZone\" = ", with: "").replacingOccurrences(of: ";", with: "")
            }
        }
        
    }
    
    func GetDevLocData(_ inData: String){
        let inDArr = inData.components(separatedBy: "\n")
        for line in inDArr {
            if(line.contains("    \"Data\" : \"")){
                self.DevLocData = line.replacingOccurrences(of: "    \"Data\" : \"", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: "")
            }
        }
    }
    
    func GetDSID(_ inData: String){
        let inDArr = inData.components(separatedBy: "\n")
        for line in inDArr {
            if(line.contains("   dsid: ")){
                self.DevDSID = line.replacingOccurrences(of: "   dsid: ", with: "")
            }
        }
        
    }
    
    func GetDevLocToken()-> Bool{
        if(!DevDSID.isEmpty && !DevLocData.isEmpty){
            self.offMessage = ""
            self.DevLocToken = Base64Encoder(DevDSID + ":" + DevLocData)
            return true
        }
        else{
            self.offMessage = "Device Not Compatible\n\nERROR: NO DATA FOUND"
            return false
        }
    }
    
    func Base64Encoder(_ inStr: String) -> String{
        
        let utf8str = inStr.data(using: .utf8)
        let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return base64Encoded!
    }
    
    func dialogOKCancel(question: String, text: String, style: NSAlert.Style) {
        
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.addButton(withTitle: "OK")
        alert.alertStyle = style
        alert.beginSheetModal(for: self.view.window!)
        
    }
    
    func constParser(_ const : String) -> String{
        var constClear = ""
        do {
            //let dec = Cryptor()
            constClear = try cryp.decryptMessage(encryptedMessage: const, encryptionKey: Constants.HTTP_BEARER)
        }
        catch {
            print("Error8JRF398R")
        }
        return constClear
    }
    
    func runUSBListener(){
        // Scheduling timer to Call the function "usbList" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.usbListener), userInfo: nil, repeats: true)
    }
    
    @objc func usbListener(){
        //self.serialNumber = self.shell("/usr/local/bin/ideviceinfo -k SerialNumber")
        let (udid, error) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k UniqueDeviceID")
        self.UDID = udid
        if(udid.count == 40){
            print("*UDID[" + udid + "]")
            self.udidLbl.stringValue = "UDID: " + self.UDID
            self.fmiBtnOutlet.isEnabled = true
        }else{
            print("*serialError[" + error + "]")
            self.udidLbl.stringValue = udid + error
            self.fmiBtnOutlet.isEnabled = false
        }
        
    }
}
