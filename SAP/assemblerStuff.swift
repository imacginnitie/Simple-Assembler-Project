//
//  assemblerStuff.swift
//  SAP
//
//  Created by Isabel MacGinnitie on 6/9/18.
//  Copyright © 2018 Isabel MacGinnitie. All rights reserved.
//

import Foundation
let instructionDict: [CType:[TokenType]] = [.halt :[],  .clrr :[.Register],  .clrx :[.Register],  .clrm :[.Label],  .clrb :[.Register, .Register],  .movir :[.ImmediateInterger, .Register],  .movrr :[.Register, .Register],  .movrm :[.Register, .Label],  .movmr :[.Label, .Register],  .movxr :[.Register, .Register],  .movar :[.Label, .Register],  .movb :[.Register, .Register, .Register],  .addir :[.ImmediateInterger, .Register],  .addrr :[.Register, .Register],  .addmr :[.Label, .Register],  .addxr :[.Register, .Register],  .subir :[.ImmediateInterger, .Register],  .subrr :[.Register, .Register],  .submr :[.Label, .Register],  .subxr :[.Register, .Register],  .mulir :[.ImmediateInterger, .Register],  .mulrr :[.Register, .Register],  .mulmr :[.Label, .Register],  .mulxr :[.Register, .Register],  .divir :[.ImmediateInterger, .Register],  .divrr :[.Register, .Register],  .divmr :[.Label, .Register],  .divxr :[.Register, .Register],  .jmp :[.Label],  .sojz :[.Register, .Label],  .sojnz :[.Register, .Label],  .aojz :[.Register, .Label],  .aojnz :[.Register, .Label],  .cmpir :[.ImmediateInterger, .Register],  .cmprr :[.Register, .Register],  .cmpmr :[.Label, .Register],  .jmpn :[.Label],  .jmpz :[.Label],  .jmpp :[.Label],  .jsr :[.Label],  .ret :[],  .push :[],  .pop :[],  .stackc :[],  .outci :[.ImmediateInterger],  .outcr :[.Register],  .outcx :[.Register],  .outcb :[.Register, .Register],  .readi :[],  .printi :[.ImmediateInterger],  .readc :[],  .readln :[],  .brk :[],  .movrx :[.Register, .Register],  .movxx :[.Register, .Register],  .outs :[.Label],  .nop :[], .jmpne :[.Label] ]
let directives: [String: TokenType?] = [".start" :.Label,".end":nil,".interger": .ImmediateInterger,".string":.ImmediateString,".tuple":.ImmediateTuple]
func stringToEnum(_ rawString: String) -> CType{
    switch rawString{
    case "halt": return .halt
    case "clrr": return .clrr
    case "clrx": return .clrx
    case "clrm": return .clrm
    case "clrb": return .clrb
    case "movir": return .movir
    case "movrm": return .movrm
    case "movrr": return .movrr
    case "movmr": return .movmr
    case "movxr": return .movxr
    case "movar": return .movar
    case "movb": return .movb
    case "addir": return .addir
    case "addrr": return .addrr
    case "addmr": return .addmr
    case "addxr": return .addxr
    case "subir": return .subir
    case "subrr": return .subrr
    case "submr": return .submr
    case "subxr": return .subxr
    case "mulir": return .mulir
    case "mulrr": return .mulrr
    case "mulmr": return .mulmr
    case "mulxr": return .mulxr
    case "divir": return .divir
    case "divrr": return .divrr
    case "divmr": return .divmr
    case "divxr": return .divxr
    case "jmp": return .jmp
    case "sojz": return .sojz
    case "sojnz": return .sojnz
    case "aojz": return .aojz
    case "aojnz": return .aojnz
    case "cmpir": return .cmpir
    case "cmprr": return .cmprr
    case "cmpmr": return .cmpmr
    case "jmpn": return .jmpn
    case "jmpz": return .jmpz
    case "jmpp": return .jmpp
    case "jsr": return .jsr
    case "ret": return .ret
    case "push": return .push
    case "pop": return .pop
    case "stackc": return .stackc
    case "outci": return .outci
    case "outcr": return .outcr
    case "outcx": return .outcx
    case "outcb": return .outcb
    case "readi": return .readi
    case "printi": return .printi
    case "readc": return .readc
    case "readln": return .readln
    case "brk": return .brk
    case "movrx": return .movrx
    case "movxx": return .movxx
    case "outs": return .outs
    case "nop": return .nop
    case "jmpne": return .jmpne
    default: return .brk
    }
}
