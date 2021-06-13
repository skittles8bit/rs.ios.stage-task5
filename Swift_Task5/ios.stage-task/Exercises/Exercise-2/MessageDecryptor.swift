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
        let stringArray = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        
        for item in stringArray {
            if let number = Int(item) {
                if !(1...300).contains(number) { return false }
            }
        }
        
        if self.contains(" ") {
            return false
        }
        
        if self.count <= 1 || self.count >= 60{
            return false
        }
        
        for char in self {
            if ("A"..."Z").contains(char) { return false }
        }
        
        return true
    }
}
