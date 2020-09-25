//
//  debugger.swift
//  SAP
//
//  Created by Isabel MacGinnitie on 6/11/18.
//  Copyright © 2018 Isabel MacGinnitie. All rights reserved.
//
/*
import Foundation
import Foundation

class debuggerVM {
    var register = Array(repeating: 0, count: 10)
    var final = String()
    var equal = Bool()//true = equal; false = unequal
    var flag = Bool()
    var mem = [Int]()
    var index = Int()
    var pos = Int()
    var runflag = Bool()
    var progcontinue = true
    
    func run() {
        
        flag = true
        index = 1
        //print("type your directory")
        let input = "//Users/isabelmacginnitie/Desktop/SAPturing.bin"//readLine()
        let (_, b) = (readTextFile(input))//!))
        let b2 = splitStringIntoLines(b!).map{ Int($0)! }
        var inter = 0
        for _ in b2{
            //print("\(inter): \(a)")
            inter+=1
        }
        mem  = b2
        index = (mem[index]+2)
        // print(instructions(mem[index]+2))
        //index += 1
        while flag == true && progcontinue{
            //print((mem[mem[index]+2]))
            
            print(index-2, terminator: "    ")
            print(instructions(index, runflag) ?? -1)
            //print(register)
            //print("initial: \(mem[initial])")
            
            index += 1
        }
        print(final)
        // print(register)
    }
    
    func debugrun(_ startindex: Int){
        
        flag = true
        runflag = true
        
        if startindex >= 1 {index=startindex} else {index=1}//if startindex == 0 {index = 1}
        //index=1
        //index=startindex
        
        //print("running")
        let input = "//Users/isabelmacginnitie/Desktop/SAPturing.bin"//readLine()
        let (_, b) = (readTextFile(input))//!))
        let b2 = splitStringIntoLines(b!).map{ Int($0)! }
        var inter = 0
        for _ in b2{
            //print("\(inter): \(a)")
            inter+=1
        }
        mem  = b2
        if index == 1 {index = (mem[index]+2)}
        
        while runflag && flag {
            
            /*if d.breakpoints.count != 0 && d.breakpoints[0] < index && d.enabled==true{
             //print("breakpoint at \(d.breakpoints[0])")
             break
             }else{*/
            print(index-2, terminator: "    ")
            print(instructions(index, runflag) ?? -1)
            index+=1
            //}
            
            if d.breakpoints.count != 0 && d.breakpoints[0] < index && d.enabled==true{
                runflag=false
                break
            }
            
            index+=1
        }
        print(final)
    }
    
    func instructions(_ initial: Int, _ continuerunning: Bool) -> String? {
        //if d.breakpoints.count != 0 && d.breakpoints[0] == index && flag==true && index <= mem.count{return "breakpoint"}
        if continuerunning == false {
            progcontinue = false
            return "breakpoint"
        } else {
            //helper = index
            let inst = CType(rawValue: mem[initial])!
            //let inst = command(rawValue: mem[index])!
            //print("r6:\(register[6])")
            switch inst {
            case .movmr:
                mem[mem[initial + 2]] = register[mem[initial + 1]+2]
                //if flag==true {index += 2}
                index+=2
                //print(register)
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "8 movmr \(index)"
            case .outs:
                let a = (mem[initial+1]+3)
                //let ab = "\(mem[initial + 1]+2)"
                let b = (mem[initial+1]+3) + (mem[mem[initial + 1]+2]-1)
                //  print("\(a) \(b) \(ab)")
                //for i in (mem[initial+1]+3)...((mem[initial+1]+2) + (mem[initial + 1]+3)) {
                for i in a...b {
                    final += String(Character(UnicodeScalar(mem[i])!))
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                //print(final)
                return "55 outs"
            case .outcr:
                final += String(Character(UnicodeScalar(register[mem[initial + 1]])!))
                //  print(final)
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                return "45 outcr"
            case .movrr:
                register[mem[initial + 2]] = register[mem[initial + 1]]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "6 movrr"
            case .addrr:
                register[mem[initial + 2]] += register[mem[initial + 1]]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "13 addrr"
            case .printi:
                final += String(register[mem[initial + 1]])
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                return "49 printi"
            case .cmprr:
                if register[mem[initial + 2]] == register[mem[initial + 1]] {
                    equal = true
                    pos = 0
                } else {
                    equal = false
                    if register[mem[initial + 2]] > register[mem[initial + 1]]{
                        
                        pos = -1
                    }
                    else{
                        equal=false
                        pos = 1
                    }
                }
                print("\(register[mem[initial + 1]]) hi \(register[mem[initial + 2]])")
                //pos = -1*(register[mem[initial + 2]] - register[mem[initial + 1]])
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                print(equal)
                return "34 cmprr    \(equal)     \(index)"
            case .addir:
                register[mem[initial + 2]] += mem[initial + 1]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "12 addir"
            case .jmpne:
                /*if !equal{
                 index = mem[index+1]+1
                 //return instructions(mem[index + 1])
                 }
                 else{index += 1}*/
                if pos>0 || pos<0{
                    index = mem[index+1]+1
                }else if pos==0{
                    index+=1
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "57 jmpne    index: \(index)"
            case .halt:
                flag = false
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "0 halt"
            case .clrr:
                register[mem[index+1]] = 0
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                return "1 clrr"
            case .clrx:
                mem[register[index+1]+2] = 0
                index += 1
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "2 clrx"
            case .clrm:
                mem[mem[index+1]+2] = 0
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                return "3 clrm"
            case .clrb:
                for i in (mem[index+1]+2)...(mem[index+1]+2+mem[index+2]){
                    mem[i] = 0
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                return "4 clrb"
            case .movir:
                register[mem[index+2]] = mem[index+1]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "5 movir"
            case .movrm:
                mem[mem[index+2]+2] = register[mem[index+1]]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "7 movrm"
            case .movxr:
                register[mem[index+2]] = mem[register[mem[index+1]]+2]
                //print("\(mem[register[mem[index+1]]])")
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "9 movxr"
            case .movar:
                var address = -1
                for m in 0..<mem.count{
                    if m == mem[index+1]{
                        address=m
                    }
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index-2 && d.enabled==true{
                    runflag=false
                    //return "breakpoint"
                }
                register[mem[index+2]] = address
                index += 2
                return "10 movar"
            case .movb:
                var count = 0
                for i in (register[mem[index+1]]+2)...(register[mem[index+1]]+2+register[mem[index+3]]){ //value stored in register1 (memory ocation) to (that) + (count)
                    mem[register[mem[index+2]]+2+count] = mem[i]//memory destination (mem[r2] = mem[count])
                    count += 1
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "11 movb"
            case .addmr:
                register[mem[index+2]] += mem[mem[index+1]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "14 addmr"
            case .addxr:
                register[mem[index+2]] += mem[register[mem[index+1]]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "15 addxr"
            case .subir:
                register[mem[initial + 2]] -= mem[initial + 1]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "16 subir"
            case .subrr:
                register[mem[initial + 2]] -= register[mem[initial + 1]]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "17 subrr"
            case .submr:
                register[mem[index+2]] -= mem[mem[index+1]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "18 submr"
            case .subxr:
                register[mem[index+2]] -= mem[register[mem[index+1]]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "19 subxr"
            case .mulir:
                register[mem[initial + 2]] *= mem[initial + 1]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "20 mulir"
            case .mulrr:
                register[mem[initial + 2]] *= register[mem[initial + 1]]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "21 mulrr"
            case .mulmr:
                register[mem[index+2]] *= mem[mem[index+1]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "22 mulmr"
            case .mulxr:
                register[mem[index+2]] *= mem[register[mem[index+1]]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "23 mulxr"
            case .divir:
                register[mem[initial + 2]] /= mem[initial + 1]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "24 divir"
            case .divrr:
                register[mem[initial + 2]] /= register[mem[initial + 1]]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "25 divrr"
            case .divmr:
                register[mem[index+2]] /= mem[mem[index+1]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "26 divmr"
            case .divxr:
                register[mem[index+2]] /= mem[register[mem[index+1]]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "27 divxr"
            case .jmp:
                //print ("index:\(index)")
                index = mem[index+1]+1
                //print ("index:\(index)")
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "28 jmp"
            case .sojz:
                register[mem[index+1]] -= 1
                if register[mem[index+1]] == 0{
                    index = mem[index+2]+1
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "29 sojz"
            case .sojnz:
                register[mem[index+1]] -= 1
                if register[mem[index+1]] != 0{
                    index = mem[index+2]+1
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "30 sojnz"
            case .aojz:
                register[mem[index+1]] += 1
                if register[mem[index+1]] == 0{
                    index = mem[index+2]+1
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "31 aojz"
            case .aojnz:
                register[mem[index+1]] += 1
                if register[mem[index+1]] != 0{
                    index = mem[index+2]+1
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "32 aojnz"
            case .cmpir:
                if register[mem[initial + 2]] == mem[initial + 1] {
                    equal = true
                    pos = 0
                } else {
                    equal = false
                    if register[mem[initial + 2]] > mem[initial + 1]{
                        pos = -1
                    }
                    else{
                        pos = 1
                    }
                }
                //pos = -1*(register[mem[initial + 2]] - mem[initial + 1])
                index += 2
                print(pos)
                print(equal)
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "33 cmpir"
            case .cmpmr:
                if register[mem[initial + 2]] == mem[mem[initial + 1]] {
                    equal = true
                    pos = 0
                } else {
                    equal = false
                    if register[mem[initial + 2]] > mem[mem[initial + 1]]{
                        pos = -1
                    }
                    else{
                        pos = 1
                    }
                }
                
                index += 2
                print(equal)
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "35 cmpmr"
            case .jmpn:
                if pos < 0 {
                    //return instructions(mem[index + 1])
                    index = mem[index+1]+1
                }
                else{index += 1}
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                return "36 jmpn \(pos)"
            case .jmpz:
                if pos == 0 {
                    //return instructions(mem[index + 1])
                    index = mem[index+1]+1
                }
                else{index += 1}
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                //   print(index)
                return "37 jmpz"
            case .jmpp:
                if pos > 0 {
                    index = mem[index+1]+1
                    //delete above line MICHELLE
                    //return instructions(mem[index + 1])
                    //return instructions(index)
                }
                else{index += 1}
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                //   print(index)
                return "38 jmpp \(pos)"
            case .movxx:
                mem[register[mem[index+2]]+2] = mem[register[mem[index+1]]+2]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "9 movxx"
            case .movrx:
                mem[register[mem[index+2]]+2] = register[mem[index+1]]
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 2
                return "53 movrx"
            case .outci:
                final += String(Character(UnicodeScalar(mem[initial + 1])!))
                //  print(final)
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                return "44 outci"
            case .outcx:
                final += String(Character(UnicodeScalar(mem[register[mem[initial + 1]]])!))
                //  print(final)
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index += 1
                return "46 outcx"
            case .outcb:
                for a in register[mem[initial + 1]]...(register[mem[initial+2]]*register[mem[initial + 1]]){
                    final += String(Character(UnicodeScalar(mem[a+2])!))
                    index += 1
                }
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                //  print(final)
                index += 2
                return "44 outci"
                
            case .jsr:
                if d.breakpoints.count != 0 && d.breakpoints[0] <= index && d.enabled==true{
                    runflag=false
                }
                index = mem[index+1]+1
                return "39 jsr    index: \(index)"
                
                /*
                 case aojz:
                 case aojnz:
                 case cmpir:
                 case cmpmr
                 case jmpn:
                 case jmpz:
                 case jumpp:
                 case jsr:
                 case ret:
                 case push:
                 case pop:
                 case stackc:
                 case outci:
                 case outcx:
                 case outcb:
                 case readi:
                 case readc:
                 case readln:
                 case brk:
                 case movrx:
                 case movxx:
                 case nop:
                 */
            default:
                return "unknown command"
            }
        }
    }
}




class debugger{
    
    var result = String()
    var breakpoints = [Int]()
    var enabled = true
    var shouldcontinue = true
    
    func run(){
        print("type your debugger command")
        let input = readLine()
        let bb = splitStringIntoWords(input!)
        print(debug(bb))
        if shouldcontinue {
            run()
        }
    }
    
    func debug(_ initial: [String])->String{
        switch initial[0]{
        case "setbk":
            breakpoints.append(Int(initial[1])!)
            return "breakpoint added at \(Int(initial[1])!)"
        case "rmbk":
            for b in 0..<breakpoints.count-1{
                if breakpoints[b] == Int(initial[1])!{
                    breakpoints.remove(at: b)
                }
            }
            return "breakpoint at \(initial[1]) removed"
        case "clrbk":
            breakpoints.removeAll()
            return "breakpoints cleared"
        case "disbk":
            enabled=false
            return "breakpoints disabled"
        case "enbk":
            enabled=true
            return "breakpoints enabled"
        case "pbk":
            var breakpointtable = "enabled: \(enabled)\nbreakpoints:\n"
            for b in breakpoints{
                breakpointtable+="\(b) \n"
            }
            return "\(breakpointtable)"
        case "preg":
            var registersprinted = "registers: \n"
            for r in a.register{
                registersprinted+="\(r)\n"
            }
            return "\(registersprinted)"
        case "wreg":
            a.register[Int(initial[1])!]=Int(initial[2])!
            return "register \(initial[1]) is now \(initial[2])"
        case "wpc":
            a.index = Int(initial[1])!
            return "PC: \(a.index)"
        case "pmem":
            return "\(a.mem)"
        case "deas":
            return "sorry, our deassembler doesn't work"
        case "wmem":
            if a.mem.count >= Int(initial[2])! {
                a.mem[Int(initial[1])!]=Int(initial[2])!
                return "memory location \(initial[1]) changed to \(initial[2])"
            }else{return "memory location \(initial[1]) does not exist"}
            /*case "pst":
             return "\(_.sym)"*/
        case "g":
            print("running from \(a.index)")
            //c.run()
            a.runflag=true
            a.run()
            //a.debugrun(a.index)
            //a.flag=true
            //a.runflag=true
            //a.debugrun()
            return ""
        case "s":
            print("running from \(a.index)")
            a.runflag=true
            let tempbreakpoint = a.index-2
            breakpoints.append(tempbreakpoint)
            a.debugrun(a.index)
            for b in 0..<breakpoints.count{
                if breakpoints[b]==(tempbreakpoint){
                    breakpoints.remove(at: b)
                }
            }
            return "current index: \(a.index-2)"
        case "exit":
            a.flag=false
            shouldcontinue=false
            return "virtual machine terminated"
        case "help":
            return "setbk<address> sets breakpoint at <address> \n rmbk<address> removes breakpoint at <address> \n clrbk clears all breakpoints \n disbk temporaily disables all breakpoints \n enbk enables breakpoints \n pbk prints breakpoint table \n preg prints the registers \n wreg<number><value> writes value of register <number> to <value> \n wpc<value> changes value of PC to <value> \n pmem <start address><end address> deassembles memory locations \n wmem<address><value> changes value of memory at <address> to <value> \n pst prints symbol table \n g continues program execution \n s singleStep \n exit terminates virtual machine \n help prints this help table"
            
        default:
            return "invalid command"
        }
    }
}
*/
