//
//  main.swift
//  GenerateStruct
//
//  Created by Aleksey Pleshkov on 16.01.2025.
//

import GenerateStruct

@GenerateStruct
public class Test {
    private let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

func test() {
    let one = Test(name: "one", age: 1)
    let two = Test.StructTest(name: "", age: 10)
    let three = one.toStruct()
    
    print(one, two, three)
}
