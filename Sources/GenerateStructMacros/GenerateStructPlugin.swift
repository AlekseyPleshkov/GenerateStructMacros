//
//  GenerateStructPlugin.swift
//  GenerateStruct
//
//  Created by Aleksey Pleshkov on 16.01.2025.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct GenerateStructPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        GenerateStructMacro.self
    ]
}
