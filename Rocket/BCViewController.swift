//
//  BCViewController.swift
//  Rocket
//
//  Created by Abraham Rubio on 12/08/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Cocoa
import Alamofire

class BCViewController: NSViewController {
    
    private let sf = ShellFull()
    private var timer = Timer()
    public var UDID = String()
    private var allowedUDID = Bool()
    private var serialNumber = String()
    private var tempDir = "/tmp"//String()
    private var dataArk = String()
    private var actRec = String()
    private var library = String()
    
    @IBOutlet weak var udidLabel: NSTextField!
    @IBOutlet var GetActOutlet: NSButton!
    @IBOutlet var RestoreOutlet: NSButton!
    @IBOutlet var ActivateOutlet: NSButton!
    
    
    
    private let masterKey = "HAAlsh43tZkpXK7cLWhhO34FDfCLHd"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.udidLabel.isSelectable = true
        // Do any additional setup after loading the view.
        //RestoreOutlet.isEnabled = false
        //ActivateOutlet.isEnabled = false
        runUSBListener()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func homeButton(_ sender: NSButton) {
        self.dismiss(self)
    }
    
    @IBAction func GetActFiles(_ sender: NSButton) {
        verUDID()
    }
    
    @IBAction func RestoreDevice(_ sender: NSButton) {
        RestoreDevice()
    }
    
    @IBAction func ActivateDevice(_ sender: NSButton) {
        ActivateDevice()
    }
    
    func Bypasscode(){
        
    }
    
    func GetActivationFiles(){
        sf.shellFull("killall -9 iproxy")
        sf.shellFull("rm ~/.ssh/known_hosts")
        sf.shellFull("/usr/local/bin/iproxy 2222 44 &>/dev/null &")
        
        /* Verificamos si tenemos jailbreak*/
        let (jailbroken, error) = sf.shellFull(constParser(Constants.SHELL_SSH) + "uname")
        print("*error[" + error + "]")
        if(error.contains("ssh_exchange_identification") || error.contains("Connection reset by peer")){
            dialogOKCancel(question: "Jailbreak Not Detected", text: "Please make sure it's a Jailbroken device", style: .critical)
        }
        else if(jailbroken.contains("Darwin")){
            print("*jailbroken[TRUE]")
            let (prodVer, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k ProductVersion")
            if(prodVer.contains("13") || prodVer.contains("12")){
                /* Download and Chmod files */
                let bootbPath = Bundle.main.url(forResource: "bootb", withExtension: "tar.gz")
                let bootB: String = bootbPath!.path
                let cleanPath = Bundle.main.url(forResource: "clean", withExtension: "tar.gz")
                let cleanB: String = cleanPath!.path
                
                sf.shellFull(constParser(Constants.SHELL_CP) + bootB + " root@localhost:/tmp/")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "tar zxvf /tmp/bootb.tar.gz --directory /usr/bin")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /tmp/bootb.tar.gz")
                
                sf.shellFull(constParser(Constants.SHELL_CP) + cleanB + " root@localhost:/tmp/")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "tar zxvf /tmp/clean.tar.gz --directory /usr/bin")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /tmp/clean.tar.gz")
                
                /*  Getting Serial */
                let (serial, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + "ioreg -l | grep IOPlatformSerialNumber | cut -b 50-61")
                self.serialNumber = serial
                
                /* TMP FOR RECIEVE */
                //let (tmpDir, _) = sf.shellFull("mktemp -d")
                sf.shellFull("mkdir /tmp/\(self.UDID)")
                let tmpDir = "/tmp/\(self.UDID)"
                self.tempDir = tmpDir
                
                /* FINDING ARK/ACT PATH*/
                let (ark, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.FND_ARK))
                self.dataArk = ark
                let (act, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.FND_ACT_REC))
                self.actRec = act
                let guid = ark.slice(from: "System/", to: "/Library")
                let library = "/private/var/containers/Data/System/" + guid! + "/Library"
                self.library = library
                
                /* GETTING ACT FILES */
                if (!GetSCPFiles(from: ark, to: tmpDir)){
                    dialogOKCancel(question: "1.ERROR GETING ONE FILE", text: "You should not continue", style: .critical)
                }
                if (!GetSCPFiles(from: act, to: tmpDir)){
                    dialogOKCancel(question: "2.ERROR GETING ONE FILE", text: "You should not continue", style: .critical)
                }
                if (!GetSCPFiles(from: constParser(Constants.NO_BCK_PL), to: tmpDir)){
                    dialogOKCancel(question: "3.ERROR GETING ONE FILE", text: "You should not continue", style: .critical)
                }
                if (!GetSCPFiles(from: constParser(Constants.IT_IC_INF_PTH), to: tmpDir)){
                    sf.shellFull(constParser(Constants.SHELL_SSH) + "rm " + constParser(Constants.IT_IC_INF_PTH))
                    dialogOKCancel(question: "4.ERROR GETING ONE FILE", text: "Please reboot & jailbreak your device in order to try again.", style: .critical)
                }
                
                CompressFiles(folder: tmpDir)
                
                
                dialogOKCancel(question: "GETTING FILES FINISHED", text: "CONTINUE TO STEP 2 IF THERE WERE NO ERRORS", style: .informational)
                
                    
                    
                }
                else if(prodVer.contains("ERROR: No device found")){
                    dialogOKCancel(question: "Connection Failed", text: "ERROR: No device found", style: .critical)
                }
                else{
                    dialogOKCancel(question: "Wrong iOS Version", text: "Only iOS 13 Support", style: .critical)
                }
                        
                
                sf.shellFull("killall -9 iproxy")
        }
    }
    
    func RestoreDevice(){
        
        sf.shellFull("killall -9 iproxy")
        sf.shellFull("rm ~/.ssh/known_hosts")
        sf.shellFull("/usr/local/bin/iproxy 2222 44 &>/dev/null &")
        
        /* Verificamos si tenemos jailbreak*/
        let (jailbroken, error) = sf.shellFull(constParser(Constants.SHELL_SSH) + "uname")
        print("*error[" + error + "]")
        if(error.contains("ssh_exchange_identification") || error.contains("Connection reset by peer")){
            dialogOKCancel(question: "Jailbreak Not Detected", text: "Please make sure it's a Jailbroken device", style: .critical)
        }
        else if(jailbroken.contains("Darwin")){
            print("*jailbroken[TRUE]")
            let (prodVer, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k ProductVersion")
            if(prodVer.contains("13")){
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.MOUNT) + " &>/dev/null &")
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.CLEAN_BIN))
                //self.RestoreOutlet.isEnabled = true
                dialogOKCancel(question: "RESTORE IN PROGRESS", text: "Device restoration in progress, please wait", style: .informational)
                
                sf.shellFull("killall -9 iproxy")
            }
            else if(prodVer.contains("12")){
                dialogOKCancel(question: "Plase Restore Your Device", text: "Restore your device and then continue to Step 3", style: .informational)
            }
        }
                
    }
    
    func ActivateDevice(){
        sf.shellFull("killall -9 iproxy")
        sf.shellFull("rm ~/.ssh/known_hosts")
        sf.shellFull("/usr/local/bin/iproxy 2222 44 &>/dev/null &")
        /*  PATHS FOR BIN & DYLIBS */
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
            let (prodVer, _) = sf.shellFull("/usr/local/bin/ideviceinfo -s -k ProductVersion")
            if(prodVer.contains("13") || prodVer.contains("12")){
                /* DYLIBS & BINARIES*/
                print("*fairPlaySignature[VALID]")
                sf.shellFull(constParser(Constants.SHELL_CP) + bootb + " root@localhost:/var/root/bootb.tar.gz")
                sf.shellFull(constParser(Constants.SHELL_CP) + bootd + " root@localhost:/var/root/bootd.tar.gz")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "tar zxvf /var/root/bootb.tar.gz --directory /usr/bin")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "tar zxvf /var/root/bootd.tar.gz --directory /usr/lib")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "rm /var/root/bootb.tar.gz /var/root/bootd.tar.gz")
                
                /* FINDING ARK/ACT PATH*/
                let (ark, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.FND_ARK))
                self.dataArk = ark
                let (act, _) = sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.FND_ACT_REC))
                self.actRec = act
                let guid = ark.slice(from: "System/", to: "/Library")
                let library = "/private/var/containers/Data/System/" + guid! + "/Library"
                self.library = library
                
                /* GET ROCKET DYLIB */
                //sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_RCK_DLB))
                //sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_RCK_PLST))

                /* CHMOD 777 & +X ROCKET DYLIB */
                //sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.CHM_777_RCK))
                //sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.CHM_MSX_RCK))
                
                /* 2 EXEC SUBSTRATE */
                //sf.shellFull(constParser(Constants.SHELL_SSH) + "/usr/libexec/substrate")
                //sf.shellFull(constParser(Constants.SHELL_SSH) + "/usr/libexec/substrated")
                
                /*  MKDIR FAIRPLAY ITUNES */
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.MKD_ITNS))
                
                /* RESTORE FILES TO DEVICE */
                SendSCPFiles(file: constParser(Constants.COMM_CEN_PL))
                SendSCPFiles(file: constParser(Constants.DAT_ARK_PL))
                SendSCPFiles(file: constParser(Constants.ACT_REC_PL))
                SendSCPFiles(file: constParser(Constants.IT_IC_INF))
                
                /* CHMOD ITUNES*/
                let itunes = constParser(Constants.IT_IC_INF)
                let itunesPath = constParser(Constants.IT_IC_INF_PTH)
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 644 /tmp/\(itunes)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags nouchg \(itunesPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "mv -f /tmp/\(itunes) \(itunesPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 755 \(itunesPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags uchg \(itunesPath)")
                
                /* CHMOD COMMCENTER*/
                let commCenter = constParser(Constants.COMM_CEN_PL)
                let commCenterPath = constParser(Constants.NO_BCK_PL)
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 644 /tmp/\(commCenter)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags nouchg \(commCenterPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "mv -f /tmp/\(commCenter) \(commCenterPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 755 \(commCenterPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags uchg \(commCenterPath)")
                
                
                /* CHMOD ACT_REC*/
                let actRecord = constParser(Constants.ACT_REC_PL)
                let actRecPath = self.library + constParser(Constants.ACT_PLS)
                sf.shellFull(constParser(Constants.SHELL_SSH) + "mkdir \(self.library)/activation_records")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 644 /tmp/\(actRecord)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags nouchg \(actRecPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "mv -f /tmp/\(actRecord) \(actRecPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 755 \(actRecPath)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags uchg \(actRecPath)")
                
                /* CHMOD DATA_ARK*/
                let dataArkPL = constParser(Constants.DAT_ARK_PL)
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 644 /tmp/\(dataArkPL)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags nouchg \(self.dataArk)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "mv -f /tmp/\(dataArkPL) \(self.dataArk)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chmod 755 \(self.dataArk)")
                sf.shellFull(constParser(Constants.SHELL_SSH) + "chflags uchg \(self.dataArk)")
                
                /* 2 EXEC SUBSTRATE */
                //sf.shellFull(constParser(Constants.SHELL_SSH) + "/usr/libexec/substrate")
                //sf.shellFull(constParser(Constants.SHELL_SSH) + "/usr/libexec/substrated")
                
                /* RELOAD COMMD & MAD*/
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.UNLOAD_COMM))
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.LOAD_COMM))
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.UNLOAD_MAD))
                sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.LOAD_MAD))
                
                /* LDRESTART */
                sf.shellFull(constParser(Constants.SHELL_SSH) + "ldrestart")
                
                /* RELOAD ALL*/
                //sf.shellFull(constParser(Constants.SHELL_SSH) + constParser(Constants.WGT_RLAD_SH))
                //sf.shellFull(constParser(Constants.SHELL_SSH) + "bash /tmp/reload.sh")
                
                dialogOKCancel(question: "DEVICE ACTIVATED", text: "The device has been activated successfully", style: .informational)
            }
        }
        sf.shellFull("killall -9 iproxy")
    }
    
    func verUDID(){
        //print("*serialNumber[\(serialNumber.count)]")
        //print("PARAMS[" + self.masterKey + "][" + self.UDID + "]")
        let parameters = ["masterkey": self.masterKey, "masterudid": self.UDID]
        AF.request(constParser(Constants.SRV_VR_BYPC), parameters: parameters).responseString { response in
            //print("response: \(response)")
            switch response.result {
            case .success(let value):
                if value.contains("SUCCX999"){
                    print("*prepare[SUCCESS]")
                    self.allowedUDID = true
                    self.GetActivationFiles()
                    self.performSegue(withIdentifier: "offTextSegue", sender: nil)
                }else {
                    print("*prepare[FAILED]")
                    self.allowedUDID = false
                    self.dialogOKCancel(question: "UDID NOT REGISTERED", text: "Please register in https://sw0rdf1sh.mx/", style: .critical)
                }
            case .failure(let error):
                print(error)
            }
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
            self.udidLabel.stringValue = "UDID: " + self.UDID
            self.GetActOutlet.isEnabled = true
            self.RestoreOutlet.isEnabled = true
            self.ActivateOutlet.isEnabled = true
        }else{
            print("*serialError[" + error + "]")
            self.udidLabel.stringValue = udid + error
            self.GetActOutlet.isEnabled = false
            self.RestoreOutlet.isEnabled = false
            self.ActivateOutlet.isEnabled = false
        }
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
    
    func GetSCPFiles(from: String, to: String) -> Bool{
        let (_, err) = sf.shellFull(constParser(Constants.SHELL_CP) + "root@localhost:" + from + " " + to)
        sf.shellFull("chmod 777 \(to)/*")
        if(!err.isEmpty){
            return false
        }else{
            return true
        }
    }
    
    func SendSCPFiles(file: String){
        sf.shellFull(constParser(Constants.SHELL_CP) + "/tmp/\(self.UDID)/\(file) root@localhost:/tmp/\(file)")
    }
    
    func CompressFiles(folder: String){
        let pass = "ROCKET" + self.UDID
        sf.shellFull("zip -j -P \(pass) ~/Desktop/\(self.UDID).zip /tmp/\(self.UDID)/*")
    }
}

