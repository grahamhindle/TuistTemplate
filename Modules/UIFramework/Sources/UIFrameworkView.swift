//
//  UIFrameworkView.swift
//  UIFramework
//
//  Created by Graham Hindle on 22/05/2025.
//  Copyright © 2025 Graham Hindle. All rights reserved.
//




import SwiftUI

public struct UIFrameworkView: View {
    public init() {}

    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Graham!")
        }
        .padding()

    }
}
