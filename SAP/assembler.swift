//
// Created by user on 6/1/18.
//

import Foundation
class Assembler{
    let chunks: [[String]]
    let tokens: [[Token]]
    var binary: [String]
    var labels: [String:Int]
    var errors: [Int:String]
    var counter: Int
    var binary2: [[String]]
    var binary3:[String]
    var subroute:[String:String]
    var list = String()
    var legitbin = String()
    let file: String
    init(_ tokenizer: Tokenizer, originalFile:String){
        tokenizer.bigToke()
        chunks = tokenizer.chunks
        tokens = tokenizer.allTokens
        binary = []
        binary2 = []
        errors = [:]
        labels = [:]
        counter = 0
        binary3 = []
        file = originalFile
        subroute = [:]
    }
    func run(){
        pass1()
        list = pass2()
        let _ = (writeTextFile("//Users/isabelmacginnitie/Desktop/SAP/turingyay.lst", data: list))
        legitbin = "\(binary3.count-1)\n"
        for arr in binary2{
            for bin in arr{
                legitbin += bin
                legitbin += "\n"
            }
        }
        let _ = (writeTextFile("//Users/isabelmacginnitie/Desktop/SAP/turingyay.bin", data: legitbin))
    }
    func pass1(){
        for number in 0..<tokens.count{
            binary = []
            checkRow(number)
            for bin in binary{
                binary3.append(String(bin))
            }
            binary2.append(binary)
        }
    }
    func checkRow(_ count:Int){
        let tokenRow: [Token] = tokens[count]
        switch tokenRow[0].type{
        case .Instruction: if let params = instructionDict[stringToEnum(tokenRow[0].stringValue!)]{
            binary.append(String(stringToEnum(tokenRow[0].stringValue!).rawValue))
            counter += 1
            for number in 1..<tokenRow.count{
                if tokenRow[number].type == .Comment {return}
                else if (number-1) >= params.count{
                    errors[count] = "too many parameters for \(tokenRow[0].stringValue!)";counter += 1; return}
                else if tokenRow[number].type != params[number-1]{
                    errors[(count)] = "wrong parameters for \(tokenRow[0].stringValue!)"
                    counter += 1
                    return
                    }
                binary.append(makeTokenBinary(tokenRow[number]))
                counter += 1
                }
            }
        else{
            errors[(count)] = "not a valid instruction"
            counter += 1
            }
        case .Directive:
            switch tokenRow[0].stringValue!{
            case ".start":
                binary.insert((makeTokenBinary(tokenRow[1])), at: 0)
                subroute[tokenRow[1].stringValue!] = tokenRow[1].stringValue!
                return
            case "end": break
            default: errors[(count)] = "not a valid directive"; counter += 1; return
            }
        case .LabelDefinition:
            if tokenRow[1].type == .Directive{
                makeALabel(tokenRow[0],tokenRow[1],tokenRow[2])
            }
            else if tokenRow[1].type == .Label{
                subroute[tokenRow[0].stringValue!] = tokenRow[1].stringValue!
                binary.append(tokenRow[1].stringValue!)
            }
            else if tokenRow[1].type == .Instruction{
                labels[tokenRow[0].stringValue!] = binary3.count+binary.count-1
                if let params = instructionDict[stringToEnum(tokenRow[1].stringValue!)]{
                    binary.append(String(stringToEnum(tokenRow[1].stringValue!).rawValue))
                    //print(binary)
                    counter += 1
                    for number in 2..<tokenRow.count{
                        if tokenRow[number].type == .Comment {return}
                        if (number-2) < params.count{}
                        else{
                            errors[count] = "too many parameters for \(tokenRow[1].stringValue!)";counter += 1; return}
                        if tokenRow[number].type != params[number-2]{
                            errors[(count)] = "wrong parameters for \(tokenRow[1].stringValue!)"
                            counter += 1
                            return
                        }
                        binary.append(makeTokenBinary(tokenRow[number]))
                        counter += 1
                    }
                }
            }
        case .Comment: let _ = 0
        default: errors[(count)] = "not a valid instruction, directive, or label definition"; counter += 1
        }
    }
    func pass2() -> String{
        var lst = ""
        var add = ""
        var badlabels = 0
        for (key, _) in subroute{
            if let label = labels[key]{
                labels[key] = label
            }
        }
        for arr in 0..<binary2.count{
            for num in 0..<binary2[arr].count{
                if !(binary2[arr][num].isInt){
                    if let label = labels[binary2[arr][num]]{
                        binary2[arr][num] = String(label)
                    }
                    else{
                        add += "............. no definition for symbol \(binary3[num])\n"
                        badlabels += 1
                    }
            }
        }
        }
        if errors != [:] || add != "" {
            lst+=("""
                
                Assembly found \(errors.count+badlabels) errors
                No binary file written
                See .lst file for errors\n
                
                """)
            var ind = 0
            let badCode = splitStringIntoLines(file)
            for line in badCode{
                lst+=(line)
                lst+="\n"
                if let error = errors[ind]{
                    lst+=("..............")
                    lst+=(error)
                    lst+="\n"
                }
                ind += 1
            }
            lst += add
            return lst
        }
        var c = 0
        lst += "\(c): \n"
        var temp = ""
        for row in 0..<binary2.count{
            lst += "\(c): "
            
            for col in 0..<binary2[row].count{
            if temp.count < 10
            {
                if col < 5
                {temp += binary2[row][col]
                temp += " "
                c += 1}
            }
                
            }
            while temp.count < 10 {
                temp += " "
            }
            lst += temp
            temp = ""
            lst += "\t\t"
            lst += splitStringIntoLines(file)[row]
            lst += "\n"
        }
        lst += "\nSymbol Table:\n"
        for (key, value) in labels{
            lst += "\(key) \(value)\n"
        }
            return lst
}
    func makeALabel(_ label: Token, _ directive: Token, _ value: Token){
        labels[(label.stringValue!)] = counter
        counter += 1
        switch value.type{
        case .ImmediateInterger: binary.append(String(value.intValue!))
        case .ImmediateTuple:
            binary.append(String(value.tupleValue!.cs))
            binary.append(String(charToAscii(c: value.tupleValue!.ic)))
            binary.append(String(value.tupleValue!.ns))
            binary.append(String(charToAscii(c: value.tupleValue!.oc)))
            if value.tupleValue!.di == "r"{
                binary.append("1")
            }
            else{
                binary.append("-1")
            }
            counter += 4
        case .ImmediateString:
            binary.append(String(value.stringValue!.count))
            for char in value.stringValue!{
                binary.append(String(charToAscii(c: char)))
                counter += 1
            }
        default: print(":(")
        }
    }
    func makeTokenBinary(_ token:Token)-> String{
        switch token.type {
        case .Register, .ImmediateInterger:
            return String(token.intValue!)
        case .Label:
            return token.stringValue!
        default:
            return String()
        }
    }
    }


