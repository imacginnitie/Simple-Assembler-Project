//
//  main.swift
//  SAP4real$
//
//  Created by Isabel MacGinnitie on 6/6/18.
//  Copyright © 2018 Isabel MacGinnitie. All rights reserved.
//
import Foundation



func test(){
    let (_,b) = (readTextFile("/Users/isabelmacginnitie/Desktop/Izzy SAP Stuff/turing.txt"))
    let tokenizer = Tokenizer(b!)
    let asm = Assembler(tokenizer, originalFile: b!)
    asm.run()
    print("Chunks:")
    for chunk in tokenizer.chunks{print(chunk)}
    print("\nTokens:")
    for token in tokenizer.allTokens{print(token)}
    print("\nAssembler Output Files:")
    print("\nturing.lst:")
    let (_,lst) = (readTextFile("/Users/isabelmacginnitie/Desktop/Izzy SAP Stuff/turingyay.lst"))
    print(lst!)
    print("\nturing.bin:")
    let (_,bin) = (readTextFile("/Users/isabelmacginnitie/Desktop/Izzy SAP Stuff/turingyay.bin"))
    print(bin!)
    print("\nTuring Machine Output:")
    let a = vM()
    a.run()
    let (_,c) = (readTextFile("/Users/isabelmacginnitie/Desktop/Izzy SAP Stuff/turingcopy.txt"))
    let tokenizer2 = Tokenizer(c!)
    let asm2 = Assembler(tokenizer2, originalFile: c!)
    asm2.run()
    let (_,bad) = (readTextFile("/Users/isabelmacginnitie/Desktop/Izzy SAP Stuff/turingcopy.txt"))
    print("\n\nERROR turing.lst:")
    print(bad!)
}
test()
let a = debuggerVM()
let c = vM()
c.run()
let d = debugger()
d.run()


