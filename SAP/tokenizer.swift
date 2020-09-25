//
//  tokenizer.swift
//  SAP
//
//  Created by Isabel MacGinnitie on 6/6/18.
//  Copyright © 2018 Isabel MacGinnitie. All rights reserved.
//

import Foundation
class Tokenizer{
    var file = String()
    let chunks: [[String]]
    
    var allTokens: [[Token]]
    init(_ file: String){
        self.file = file
        allTokens = []
        chunks = splitStringIntoLines(file).map({splitStringIntoWords($0)})
    }
    func bigToke(){
        for chunk in chunks{
            run(chunk)
        }
    }
        func run(_ line:[String]){
        var tokens:[Token] = []
        var count = 0
        var word = line[count]
        while (count < line.count){
            word = line[count]
            switch word[word.startIndex]{
            case ".": tokens.append(Token(.Directive, word.lowercased()))
            case "#":
                let a = String(word[minusFirst(word)...])
                let b = (a as NSString).integerValue
                tokens.append(Token(.ImmediateInterger, b))
            case "\"": var temp = String(word[minusFirst(word)...])
                var tempCount = count+1
                while tempCount < line.count {
                    temp += " \(line[tempCount])"
                    tempCount += 1
                }
                tokens.append(Token(.ImmediateString,  String(temp[..<minusLast(temp)])))
                count = line.count
            case ";": var temp = String(word[minusFirst(word)...]); var tempCount = count+1
                while tempCount < line.count {
                    temp += " \(line[tempCount])"
                    tempCount += 1
                }
                tokens.append(Token(.Comment, temp))
                count = line.count
            case "r": if word.count == 2 && charToAscii(c: word.last!) <= 57{
                tokens.append(Token(.Register, Int(String(word.last!))!))
                }
                else{tokens.append(isALabel(word.lowercased()))}
            case "\\": tokens.append(Token(.ImmediateTuple, Tuple(cs: Int(word[minusFirst(word)...])!, ic: Character(line[count+1]), ns: Int(line[count+2])!, oc: Character(line[count+3]), di: Character(String(line[count+4].first!)))))
                count = line.count
            case " ": var temp = String(word[minusFirst(word)...]); var tempCount = count+1
            while tempCount < line.count {
                temp += " \(line[tempCount])"
                tempCount += 1
            }
            tokens.append(Token(.Comment, temp))
            count = line.count
            default: tokens.append(isALabel(word.lowercased()))
            }
            count += 1
        }
        allTokens.append(tokens)
    }
}
