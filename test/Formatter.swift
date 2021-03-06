//
//  Formatter.swift
//  Lumberjack
//
//  Created by C.W. Betts on 10/3/14.
//
//

import Foundation
import CocoaLumberjack.DDDispatchQueueLogFormatter

class Formatter: DDDispatchQueueLogFormatter {
    let df: NSDateFormatter
    
    override init() {
        df = NSDateFormatter()
        df.formatterBehavior = .Behavior10_4
        df.dateFormat = "HH:mm:ss.SSS"
        
        super.init()
    }
    
    override func formatLogMessage(logMessage: DDLogMessage!) -> String {
        let dateAndTime = df.stringFromDate(logMessage.timestamp)
        
        var logLevel: String
        var useLog = true
        var formattedLog = ""
        let logFlag:DDLogFlag  = logMessage.flag
        if logFlag.contains(.Verbose) {
            logLevel = "VERBOSE:"
        } else if logFlag.contains(.Debug) {
            logLevel = "DEBUG:"
        } else if logFlag.contains(.Info) {
           logLevel = "INFO:"
        } else if logFlag.contains(.Warning) {
             logLevel = "WARNING:"
        } else if logFlag.contains(.Error) {
           logLevel = "ERROR:"
        } else {
            logLevel = "OFF:"
            useLog = false;
        }
        if(useLog){
                formattedLog = "\(dateAndTime) |\(logLevel)| [\(logMessage.fileName) \(logMessage.function)] #\(logMessage.line): \(logMessage.message)"
        }
        
        return formattedLog;
    }
}
