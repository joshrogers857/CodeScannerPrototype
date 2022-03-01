//
//  ContentView.swift
//  CodeScannerPrototype
//
//  Created by Joshua Rogers on 01/03/2022.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Welcome").padding()
                        
                Button(action: present) {
                    Label("Scan Code", systemImage: "camera")
                }
                .buttonStyle(.borderedProminent)
                
                Text("Code: \(scannedCode ?? "None found")")
                .padding()
            }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.ean8, .ean13]) { response in
                    if case let .success(result) = response {
                        scannedCode = result.string
                        isPresentingScanner = false
                    }
                }
            }
        }
    }
    
    func present() {
        isPresentingScanner = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
