//
//  ShellFull.swift
//  Rocket
//
//  Created by Abraham Rubio on 12/08/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Foundation

class ShellFull{
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
        if(Constants.LGN_LVL.contains("DEBUG")){
            print("suc[\(outputData.shellOutput())]")
            print("err[\(errorData.shellOutput())]")
        }

        return (outputData.shellOutput(), errorData.shellOutput())
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
