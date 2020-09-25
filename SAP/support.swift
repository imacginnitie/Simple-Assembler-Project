//
// Created by user on 4/9/18.
//

import Foundation
func splitStringIntoLines(_ expression:String)->[String]{
    
    return expression.split{$0 == "\n"}.map{String($0)}
    
}
func splitStringIntoWords(_ expression:String)->[String]{
    
    return expression.split{$0 == " "}.map{String($0)}
    
}

func readTextFile(_ path: String)->(message: String?, fileText: String?) {
    let text: String
    do {
        text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    } catch {
        return ("\(error)", nil)
    }
    return (nil, text)
}

enum CType: Int{
    case halt
    case clrr
    case clrx
    case clrm
    case clrb
    case movir
    case movrr
    case movrm
    case movmr
    case movxr
    case movar
    case movb
    case addir
    case addrr
    case addmr
    case addxr
    case subir
    case subrr
    case submr
    case subxr
    case mulir
    case mulrr
    case mulmr
    case mulxr
    case divir
    case divrr
    case divmr
    case divxr
    case jmp
    case sojz
    case sojnz
    case aojz
    case aojnz
    case cmpir
    case cmprr
    case cmpmr
    case jmpn
    case jmpz
    case jmpp
    case jsr
    case ret
    case push
    case pop
    case stackc
    case outci
    case outcr
    case outcx
    case outcb
    case readi
    case printi
    case readc
    case readln
    case brk
    case movrx
    case movxx
    case outs
    case nop
    case jmpne
    }

func charToAscii(c: Character)->Int{
    return Int(String(c).utf8.first!)
}

func AsciiToChar(n: Int) -> Character{
    return Character(Unicode.Scalar(n)!)
}

func minusFirst(_ str: String)->String.Index{
    return str.index(str.startIndex, offsetBy: 1)
}
func minusLast(_ str: String)->String.Index{
    return str.index(str.endIndex, offsetBy: -1)
}
func minusFirstN(_ str: String, _ n: Int)->String.Index{
    return str.index(str.startIndex, offsetBy: n)
}
func minusLastN(_ str: String, _ n: Int)->String.Index{
    return str.index(str.endIndex, offsetBy: -1*n)
}

 func writeTextFile(_ path: String, data: String)->String? {
 let url = NSURL.fileURL(withPath: path)
 do {
 try data.write(to: url, atomically: true, encoding: String.Encoding.utf8)
 } catch let error as NSError {
 return "Failed writing to URL: \(url), Error: " + error.localizedDescription
 }
 return nil
 }
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}



