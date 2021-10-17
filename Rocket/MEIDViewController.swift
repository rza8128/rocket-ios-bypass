//
//  MEIDViewController.swift
//  Rocket
//
//  Created by Abraham Rubio on 20/09/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Cocoa
import Alamofire

class MEIDViewController: NSViewController {
    @IBOutlet var serialNumberLabel: NSTextField!
    @IBOutlet var actStateLabel: NSTextField!
    @IBOutlet var bypassBtnOutlet: NSButton!
    
    private var serialNumber = String()
    private var pressCount = Int()
    private var timer = Timer()
    private let sf = ShellFull()
    
    private let masterKey = "23kQYStGZMB7hRuCgpPTyNKc4eB6nU"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        runUSBListener()
    }
    @IBAction func homeButton(_ sender: NSButton) {
        dismiss(self)
    }
    @IBAction func bypassButton(_ sender: NSButton) {
        checkSN()
    }
    
    func meidBypass(){
        sf.shellFull(constParser(Constants.KLL_PR))
        sf.shellFull(constParser(Constants.KLL_MW))
        sf.shellFull(constParser(Constants.KLL_MP))
        sf.shellFull(constParser(Constants.KLL_BRP))
        sf.shellFull("rm ~/.ssh/known_hosts")
        sf.shellFull("/usr/local/bin/iproxy 2222 44 &>/dev/null &")
        
        self.regSN()
        
        let fileURLBi = Bundle.main.url(forResource: "bootb", withExtension: "tar.gz")
        let bootb: String = fileURLBi!.path
        
        let fileURLDy = Bundle.main.url(forResource: "bootd", withExtension: "tar.gz")
        let bootd: String = fileURLDy!.path
        
        
        /* Verificamos si tenemos jailbreak*/
        let (jailbroken, error) = sf.shellFull(constParser(Constants.SHELL_SSH) + "uname")
        print("*error[" + error + "]")
        if(error.contains("ssh_exchange_identification") || error.contains("Connection reset by peer")){
            dialogOKCancel(question: "Jailbreak Not Detected", text: "Please make sure it's a Jailbroken device", style: .critical)
        }
        else if(jailbroken.contains("Darwin")){
            print("*jailbroken[TRUE]")

            if(checkSIMTray()){
                sf.shellFull("/usr/local/bin/idevicepair pair")
                sf.shellFull("/usr/local/bin/ideviceactivation deactivate")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "mount -o rw,union,update /" + " &>/dev/null &")
                
                /* SNAPPY RENAME*/
                let (snapName, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + "snappy -f / -l | sed -n 2p")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "snappy -f / -r \(snapName) --to orig-fs &>/dev/null &")
                //print("*snapName[\(snapName)]")

                /* USE RAPTOR*/
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.CP_PEM))

                let (scpConn, errorConn) = sf.shellFull(constParser(Constants.SHELL_CP) + bootb + " root@localhost:/var/root/bootb.tar.gz")
                if(scpConn.contains("Permission denied") || errorConn.contains("Permission denied")){
                    dialogOKCancel(question: "Communication Error", text: "Permission denied, please disconnect/connect and try again", style: .critical)
                }else{
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /boot.tar")
                    /* DYLIBS & BINARIES*/
                    print("*fairPlaySignature[VALID]")
                    sf.shellFull(constParser(Constants.SHELL_CP) + bootb + " root@localhost:/var/root/bootb.tar.gz")
                    sf.shellFull(constParser(Constants.SHELL_CP) + bootd + " root@localhost:/var/root/bootd.tar.gz")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "tar zxvf /var/root/bootb.tar.gz --directory /usr/bin")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "tar zxvf /var/root/bootd.tar.gz --directory /usr/lib")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /var/root/bootb.tar.gz /var/root/bootd.tar.gz")

                
                    /* ACTIVATION FOR SERVICES */
                    print("*drmHandshake[SUCCESS]")
                    sf.shellFull("/usr/local/bin/ideviceactivation activate -s " + constParser(Constants.SRV_ACT_MEID_SVC))// + " &>/dev/null")
                    
                    /* ACTIVATION*/
                    print("*drmHandshake[SUCCESS]")
                    sf.shellFull("/usr/local/bin/ideviceactivation activate -s " + constParser(Constants.SRV_ACT_MEID))// + " &>/dev/null")
                    
                    /* FINDING ARK PATH*/
                    let (ark, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.FND_ARK))
                    let guid = ark.slice(from: "System/", to: "/Library")
                    let library = "/private/var/containers/Data/System/" + guid! + "/Library"
                    //print("*arkPath[\(ark)]")
                    //print("*guidPath[\(guid)]")
                    //print("*libraryPath[\(library)]")
                
                    /* GET ACT FILES*/
                    print("cp: /private/var/root/Library/Preferences/com.apple.MobileBackup.plist")
                    let (telCap, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k TelephonyCapability")
                    
                    if(telCap.contains("true")){
                        let (devClass, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k DeviceClass")
                        
                        if(devClass.contains("iPhone")){
                            sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_INE_MEID) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                            sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_INE_MEID) + serialNumber + "/generic.xml -O /tmp/generic.xml")
                        }
                        else if(devClass.contains("iPad")){
                            sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_IAD_MEID) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                            sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_INE_MEID) + serialNumber + "/generic.xml -O /tmp/generic.xml")
                        }
                        
                    }
                    else if (telCap.contains("false")){
                        let (devClass, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k DeviceClass")
                        
                        switch devClass {
                        case "iPad":
                            sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_IAD_MEID) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                        case "iPod":
                            sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_IOD_MEID) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                        default:
                            dialogOKCancel(question: "DEVICE NOT COMPATIBLE", text: "YOUR DEVICE IS NOT COMPATIBLE", style: .critical)
                        }
                    }
                    
                    /* CONVERT XML TO PLSIT*/
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "plistutil -i /tmp/generic.xml -o /tmp/generic.plist -f bin")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /tmp/generic.xml")
                    
                    /* MOD DATA_ARK*/
                    print("*mobileactivationd[HOOKED]")
                    let (tmpDir, _) = sf.shellFull("mktemp -d")
                    sf.shellFull(constParser(Constants.SHELL_CP) + "root@localhost:\(ark) \(tmpDir)")
                    sf.shellFull("chmod 777 \(tmpDir)/data_ark.plist")
                    sf.shellFull("plutil -replace -ActivationState -string Activated \(tmpDir)/data_ark.plist")
                    sf.shellFull("plutil -replace -BrickState -bool NO \(ark)/data_ark.")
                    sf.shellFull(constParser(Constants.SHELL_CP) + "\(tmpDir)/data_ark.plist root@localhost:/tmp/data_ark.plist")
                    
                
                    /* PROC ACT RECORDS*/
                    print("chflags: /private/var/preferences/SystemConfiguration/com.apple.networkidentification.plist")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "mkdir " + library + constParser(Constants.ACT_REC_FOL) + " &>/dev/null &")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 644 /tmp/activation_record.plist")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags nouchg " + library + constParser(Constants.ACT_PLS))
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "mv -f /tmp/activation_record.plist " + library + constParser(Constants.ACT_PLS))
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 755 " + library + constParser(Constants.ACT_PLS))
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags uchg " + library + constParser(Constants.ACT_PLS))
                    
                    /* PROC DATA_ARK*/
                    print("*mobilegestalt[RUNNING]")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 644 /tmp/data_ark.plist")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags nouchg \(ark)")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "mv -f /tmp/data_ark.plist \(ark)")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 755 \(ark)")
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags uchg \(ark)")
                    
                    

                    /* RESPRING */
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "killall -9 SpringBoard CommCenter")
                    
                    
                    /* RELOAD MAD*/
                    sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.UNLOAD_MAD))
                    sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.LOAD_MAD))
                    
                    /* UNLOAD COMMCENTER */
                    sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.UNLOAD_COMM))
                    
                     
                    /* LDRESTART */
                    //shell(shellSSH + "ldrestart")
                    //shell(shellSSH + "reboot")
                        
                    /* RELOAD ALL*/
                    //sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_RLAD_SH))
                    //sf.shellFull(constParser(Constants.SHELL_SSH) + "bash /tmp/reload.sh")
                
                    /*CLEANUP*/
                    sf.shellFull("rm -rf \(tmpDir)")
                    //shell(shellSSH + "rm /boot.tar")
                    //shell(shellSSH + "rm /Library/MobileSubstrate/DynamicLibraries/rocket.*")
                
                
                    /* KILL IPROXY*/
                    sf.shellFull(constParser(Constants.KLL_PR))
                    sf.shellFull("/usr/local/bin/idevicepair pair")
                
                    dialogOKCancel(question: "MEID/WIFI Untethered Bypass DONE", text: "WARKING: YOU MUST SET A PIN IN YOUR SIMCARD\n\nPlease Share & Retweet your results\n\nhttps://twitter.com/Sw0rdF\n\n Enjoy", style: .informational)
                }
            }
        }
        else{
            dialogOKCancel(question: "Connection Error", text: "There has been a communication error: Error9N38SG59", style: .critical)
        }
    }
    
    func checkSN(){
        //print("*serialNumber[\(serialNumber.count)]")
        //print("PARAMS[" + masterKey + "][" + serialNumber + "]")
        let parameters = ["masterkey": masterKey, "masterserial": serialNumber]
        AF.request(constParser(Constants.SRV_VRF_MEID), parameters: parameters).responseString { response in
            //print("response: \(response)")
            switch response.result {
            case .success(let value):
                if value.contains("SUCCX999"){
                    print("*prepare[SUCCESS]")
                    self.meidBypass()
                }else {
                    print("*prepare[FAILED]")
                    self.dialogOKCancel(question: "SERIAL NOT REGISTERED", text: "Please register in https://sw0rdf1sh.mx/", style: .critical)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func regSN(){
        //print("*serialNumber[\(serialNumber.count)]")
        //print("PARAMS[" + masterKey + "][" + serialNumber + "]")
        let headers: HTTPHeaders = ["Authorization" : "Basic bWFkOm1hZDEwMTA="]
        let parameters = ["os0": self.serialNumber]
        AF.request(constParser(Constants.SRV_REG_MEID), method: .post, parameters: parameters, headers: headers).responseString { response in
            //print("response: \(response)")
            switch response.result {
            case .success(let value):
                if value.contains("401"){
                    print("*regSN[Unauthorized]")
                }
                else if value.contains("ADDED"){
                    print("*regSN[SUCCESS]")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func runUSBListener(){
        // Scheduling timer to Call the function "usbList" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.usbListener), userInfo: nil, repeats: true)
    }
    
    @objc func usbListener(){
        //self.serialNumber = self.shell("/usr/local/bin/ideviceinfo -k SerialNumber")
        
        let (serialNum, error) = sf.shellFull("/usr/local/bin/ideviceinfo -k SerialNumber")
        let (actState, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k ActivationState")
        self.serialNumber = serialNum
        if(serialNum.count == 12){
            print("*serialNumber[" + self.serialNumber + "]")
            self.serialNumberLabel.stringValue = "SerialNumber: " + serialNum
            self.actStateLabel.stringValue = "ActivationState: " + actState
            self.bypassBtnOutlet.isEnabled = true
        }else{
            print("*serialError[" + error + "]")
            self.serialNumberLabel.stringValue = "Error Conecting to iDevice"
            self.actStateLabel.stringValue = error
            self.bypassBtnOutlet.isEnabled = false
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
    
    func constParser(_ const : String) -> String{
        var constClear = ""
        do {
            let dec = Cryptic()
            constClear = try dec.decryptMessage(encryptedMessage: const, encryptionKey: Constants.HTTP_BEARER)
        }
        catch {
            print("Error8JRF398R")
        }
        return constClear
    }
    
    func checkSIMTray() -> Bool{
        let (checkSIM, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k SIMTrayStatus")
        if(checkSIM.contains("kCTSIMSupportSIMTrayAbsent")){
            return true
        }
        else if(checkSIM.contains("kCTSIMSupportSIMTrayInsertedWithSIM")){
            dialogOKCancel(question: "REMOVE SIM CARD", text: "Please remove SIM CARD before continue", style: .critical)
            return false
        }
        else{
            return true
        }
    }
}
