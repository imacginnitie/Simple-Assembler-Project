import Foundation

class vM {
    var register = Array(repeating: 0, count: 10)
    var final = String()
    var equal = Bool()//true = equal; false = unequal
    var flag = Bool()
    var mem = [Int]()
    var index = Int()
    var pos = Int()
    func run() {
        flag = true
        index = 1
        let input = "/Users/isabelmacginnitie/Desktop/SAP/turing.bin"
        let (_, b) = (readTextFile(input))
        mem  = splitStringIntoLines(b!).map{ Int($0)! }
        index = (mem[index]+2)
        while flag == true {
            let _ = instructions(index)
            index += 1
        }
        print(final)
    }
    func instructions(_ initial: Int) -> String? {
        let inst = CType(rawValue: mem[initial])!
        switch inst {
        case .movmr:
            mem[mem[initial + 2]] = register[mem[initial + 1]+2]
            index += 2
            return "8 movmr \(index)"
        case .outs:
            let a = (mem[initial+1]+3)
            let b = (mem[initial+1]+3) + (mem[mem[initial + 1]+2]-1)
            for i in a...b {
                final += String(Character(UnicodeScalar(mem[i])!))
            }
            index += 1
            return "55 outs"
        case .outcr:
            final += String(Character(UnicodeScalar(register[mem[initial + 1]])!))
            index += 1
            return "45 outcr"
        case .movrr:
            register[mem[initial + 2]] = register[mem[initial + 1]]
            index += 2
            return "6 movrr"
        case .addrr:
            register[mem[initial + 2]] += register[mem[initial + 1]]
            index += 2
            return "13 addrr"
        case .printi:
            final += String(register[mem[initial + 1]])
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
            index += 2
            return "34 cmprr    \(equal)     \(index)"
        case .addir:
            register[mem[initial + 2]] += mem[initial + 1]
            index += 2
            return "12 addir"
        case .jmpne:
            if pos>0 || pos<0{
                index = mem[index+1]+1
            }else if pos==0{
                index+=1
            }
            return "57 jmpne    index: \(index)"
        case .halt:
            flag = false
            return "0 halt"
        case .clrr:
            register[mem[index+1]] = 0
            index += 1
            return "1 clrr"
        case .clrx:
            mem[register[index+1]+2] = 0
            index += 1
            return "2 clrx"
        case .clrm:
            mem[mem[index+1]+2] = 0
            index += 1
            return "3 clrm"
        case .clrb:
            for i in (mem[index+1]+2)...(mem[index+1]+2+mem[index+2]){
                mem[i] = 0
            }
            index += 1
            return "4 clrb"
        case .movir:
            register[mem[index+2]] = mem[index+1]
            index += 2
            return "5 movir"
        case .movrm:
            mem[mem[index+2]+2] = register[mem[index+1]]
            index += 2
            return "7 movrm"
        case .movxr:
            register[mem[index+2]] = mem[register[mem[index+1]]+2]
            index += 2
            return "9 movxr"
        case .movar:
            var address = -1
            for m in 0..<mem.count{
                if m == mem[index+1]{
                    address=m
                }
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
            index += 2
            return "11 movb"
        case .addmr:
            register[mem[index+2]] += mem[mem[index+1]+2]
            index += 2
            return "14 addmr"
        case .addxr:
            register[mem[index+2]] += mem[register[mem[index+1]]+2]
            index += 2
            return "15 addxr"
        case .subir:
            register[mem[initial + 2]] -= mem[initial + 1]
            index += 2
            return "16 subir"
        case .subrr:
            register[mem[initial + 2]] -= register[mem[initial + 1]]
            index += 2
            return "17 subrr"
        case .submr:
            register[mem[index+2]] -= mem[mem[index+1]+2]
            index += 2
            return "18 submr"
        case .subxr:
            register[mem[index+2]] -= mem[register[mem[index+1]]+2]
            index += 2
            return "19 subxr"
        case .mulir:
            register[mem[initial + 2]] *= mem[initial + 1]
            index += 2
            return "20 mulir"
        case .mulrr:
            register[mem[initial + 2]] *= register[mem[initial + 1]]
            index += 2
            return "21 mulrr"
        case .mulmr:
            register[mem[index+2]] *= mem[mem[index+1]+2]
            index += 2
            return "22 mulmr"
        case .mulxr:
            register[mem[index+2]] *= mem[register[mem[index+1]]+2]
            index += 2
            return "23 mulxr"
        case .divir:
            register[mem[initial + 2]] /= mem[initial + 1]
            index += 2
            return "24 divir"
        case .divrr:
            register[mem[initial + 2]] /= register[mem[initial + 1]]
            index += 2
            return "25 divrr"
        case .divmr:
            register[mem[index+2]] /= mem[mem[index+1]+2]
            index += 2
            return "26 divmr"
        case .divxr:
            register[mem[index+2]] /= mem[register[mem[index+1]]+2]
            index += 2
            return "27 divxr"
        case .jmp:
            index = mem[index+1]+1
            return "28 jmp"
        case .sojz:
            register[mem[index+1]] -= 1
            if register[mem[index+1]] == 0{
                index = mem[index+2]+1
            }
            return "29 sojz"
        case .sojnz:
            register[mem[index+1]] -= 1
            if register[mem[index+1]] != 0{
                index = mem[index+2]+1
            }
            return "30 sojnz"
        case .aojz:
            register[mem[index+1]] += 1
            if register[mem[index+1]] == 0{
                index = mem[index+2]+1
            }
            return "31 aojz"
        case .aojnz:
            register[mem[index+1]] += 1
            if register[mem[index+1]] != 0{
                index = mem[index+2]+1
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
            index += 2
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
            return "35 cmpmr"
        case .jmpn:
            if pos < 0 {
                index = mem[index+1]+1
            }
            else{index += 1}
            return "36 jmpn \(pos)"
        case .jmpz:
            if pos == 0 {
                index = mem[index+1]+1
            }
            else{index += 1}
            return "37 jmpz"
        case .jmpp:
            if pos > 0 {
                index = mem[index+1]+1
            }
            else{index += 1}
            return "38 jmpp \(pos)"
        case .movxx:
            mem[register[mem[index+2]]+2] = mem[register[mem[index+1]]+2]
            index += 2
            return "9 movxx"
        case .movrx:
            mem[register[mem[index+2]]+2] = register[mem[index+1]]
            index += 2
            return "53 movrx"
        case .outci:
            final += String(Character(UnicodeScalar(mem[initial + 1])!))
            index += 1
            return "44 outci"
        case .outcx:
            final += String(Character(UnicodeScalar(mem[register[mem[initial + 1]]])!))
            index += 1
            return "46 outcx"
        case .outcb:
            for a in register[mem[initial + 1]]...(register[mem[initial+2]]*register[mem[initial + 1]]){
                final += String(Character(UnicodeScalar(mem[a+2])!))
                index += 1
            }
            index += 2
            return "44 outci"
            
        case .jsr:
            index = mem[index+1]+1
            return "39 jsr    index: \(index)"
            
        default:
            return "unknown command"
        }
    }
}

