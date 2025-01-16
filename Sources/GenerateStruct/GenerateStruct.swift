//
//  GenerateStruct.swift
//  GenerateStruct
//
//  Created by Aleksey Pleshkov on 16.01.2025.
//

@attached(member, names: arbitrary)
public macro GenerateStruct() = #externalMacro(module: "GenerateStructMacros", type: "GenerateStructMacro")
