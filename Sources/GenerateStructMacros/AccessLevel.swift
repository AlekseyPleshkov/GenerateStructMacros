//
//  AccessLevel.swift
//  GenerateStruct
//
//  Created by Aleksey Pleshkov on 16.01.2025.
//

enum AccessLevel: String, RawRepresentable, CaseIterable {
    case `public`, `internal`, `private`, `fileprivate`
}
