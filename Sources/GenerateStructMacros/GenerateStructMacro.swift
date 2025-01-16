//
//  GenerateStructMacro.swift
//  GenerateStruct
//
//  Created by Aleksey Pleshkov on 16.01.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct GenerateStructMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let object = declaration.as(ClassDeclSyntax.self) else {
            throw CustomError.notClass
        }

        let structName = "Struct\(object.name.text)"
        let structAccessLevel = object.modifiers
            .compactMap { AccessLevel(rawValue: $0.name.text) }
            .first ?? .internal
                
        var properties: [(name: String, type: String, accessLevel: AccessLevel)] = []
        
        for member in object.memberBlock.members {
            guard let variable = member.decl.as(VariableDeclSyntax.self) else {
                continue
            }
            
            let variableAccessLevel = variable.modifiers
                .compactMap { AccessLevel(rawValue: $0.name.text) }
                .first ?? .internal
                        
            for binding in variable.bindings {
                guard
                    let patternBinding = binding.pattern.as(IdentifierPatternSyntax.self),
                    let typeAnnotation = binding.typeAnnotation?.type
                else {
                    continue
                }
                
                let propertyName = patternBinding.identifier.text
                let propertyType = typeAnnotation.description.trimmingCharacters(in: .whitespaces)
                
                properties.append((propertyName, propertyType, variableAccessLevel))
            }
        }
        
        let toStructParameters = properties.map { "\($0.name): self.\($0.name)" }.joined(separator: ", ")
        let initParameters = properties.map { "\($0.name): \($0.type)" }.joined(separator: ", ")
        let initAssignments = properties.map { "self.\($0.name) = \($0.name)" }.joined(separator: "\n        ")

        let stringLiteral = """
        \(structAccessLevel) func toStruct() -> \(structName) {
            \(structName)(\(toStructParameters))
        }
        
        \(structAccessLevel) struct \(structName) {
            \(properties.map { "\($0.accessLevel) let \($0.name): \($0.type)" }.joined(separator: "\n    "))
        
            \(structAccessLevel) init(\(initParameters)) {
                \(initAssignments)
            }
        }
        """
        
        return [DeclSyntax(stringLiteral: stringLiteral)]
    }
}
