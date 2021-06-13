import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        if !message.isValid() { return "" }
        
        var countingArray: [String] = []
        var tempCountString = ""
        var repeatStringArray: [String] = []
        var resultMessage = ""
        
        for character in message {
            if character.isNumber {
                let number = tempCountString + String(character)
                if let tempNumber = Int(number) {
                    if !(1...300).contains(tempNumber) { return "" }
                }
                
                tempCountString = "\(tempCountString)\(character)"
            } else if character == "[" {
                tempCountString == "" ? countingArray.append("1") : countingArray.append(tempCountString)
                tempCountString = ""
                
                repeatStringArray.append(resultMessage)
                resultMessage = ""
            } else if character == "]" {
                var tempStr = ""

                if let counts = Int(countingArray.popLast() ?? "1") {
                    for _ in 0..<counts {
                        tempStr += resultMessage
                    }
                }
                guard let popLastOfRepeatString = repeatStringArray.popLast() else { return "" }

                resultMessage = popLastOfRepeatString + tempStr
            } else if character.isLetter {
                resultMessage += String(character)
            }
        }

        return resultMessage
    }
}

extension String {
    func isValid() -> Bool {
        var temp = false
        
        if self.count >= 1 || self.count <= 60 {
            return true
        }
        
        for char in self {
            temp = !("A"..."Z").contains(char)
        }
        
        return temp
    }
}
