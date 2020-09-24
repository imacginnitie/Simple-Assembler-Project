//
//  tokenStuff.swift
//  SAP4real$
//
//  Created by Isabel MacGinnitie on 6/6/18.
//  Copyright © 2018 Isabel MacGinnitie. All rights reserved.
//

import Foundation
enum TokenType{
    case Register
    case LabelDefinition
    case Label
    case ImmediateString
    case ImmediateInterger
    case ImmediateTuple
    case Instruction
    case Directive
    case Comment
    case BadToken
}
struct Token: CustomStringConvertible{
    let type: TokenType
    let intValue: Int?
    let stringValue: String?
    let tupleValue: Tuple?
    let final: String
    init(_ type: TokenType, _ intValue: Int){
        self.type = type
        self.intValue = intValue
        stringValue = nil
        tupleValue = nil
        final = "\(intValue)"
    }
    init(_ type: TokenType, _ stringValue: String){
        self.type = type
        self.stringValue = stringValue
        intValue = nil
        tupleValue = nil
        final = "\(stringValue)"
    }
    init(_ type: TokenType, _ tupleValue: Tuple){
        self.type = type
        self.tupleValue = tupleValue
        stringValue = nil
        intValue = nil
        final = "\(tupleValue)"
    }
    init(_ type: TokenType){
        self.type = type
        intValue = nil
        stringValue = nil
        tupleValue = nil
        final = "??"
    }
    var description:String{
        return "(type: \(type), value: \(final))"
        //return "\(type)"
    }
}
struct Tuple:CustomStringConvertible{
    let cs: Int
    let ic: Character
    let ns: Int
    let oc: Character
    let di: Character
    var description: String{
        return "\\ \(cs) \(ic) \(ns) \(oc) \(di) \\"
    }
}
let instructionSet: Set<String> = ["halt", "clrr", "clrx", "clrm", "clrb", "movir", "movrr", "movrm", "movmr", "movxr", "movar", "movb", "addir", "addrr", "addmr", "addxr", "subir", "subrr", "submr", "subxr", "mulir", "mulrr", "mulmr", "mulxr", "divir", "divrr", "divmr", "divxr", "jmp", "sojz", "sojnz", "aojz", "aojnz", "cmpir", "cmprr", "cmpmr", "jmpn", "jmpz", "jmpp", "jsr", "ret", "push", "pop", "stackc", "outci", "outcr", "outcx", "outcb", "readi", "printi", "readc", "readln", "brk", "movrx", "movxx", "outs", "nop","jmpne"]

func isALabel(_ word: String)->Token{
    if word.last == ":"{
        return Token(.LabelDefinition, String(word[..<minusLast(word)]))
    }
    else if instructionSet.contains(word){ //is actually an instruction
        return Token(.Instruction, word)
    }
    else{
        return  Token(.Label,  word)
    }
}
