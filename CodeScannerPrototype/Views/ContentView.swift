//
//  ContentView.swift
//  CodeScannerPrototype
//
//  Created by Joshua Rogers on 01/03/2022.
//

import SwiftUI
import CoreData

import CodeScanner

struct ContentView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var productName: String?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            
            VStack(spacing: 10) {
                Button(action: present) {
                    Label("Scan Code", systemImage: "camera")
                }
                .buttonStyle(.borderedProminent)
                
                Text("Code: \(scannedCode ?? "None found")")
                .padding()
                
                Text("Product: \(productName ?? "Unknown")")
                .padding()
            }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(
                    codeTypes: [.ean8, .ean13],
                    showViewfinder: true
                ) { response in
                    if case let .success(result) = response {
                        scannedCode = result.string
                        
                        findProduct(ean: result.string)
                        
                        isPresentingScanner = false
                    }
                }
            }
        }
    }
    
    func present() {
        isPresentingScanner = true
    }
    
    func findProduct(ean: String) {
        let request = Product.fetchRequest()
        
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Product.name, ascending: true)
        ]
        
        request.predicate = NSPredicate(format: "ean == %@", ean)
        
        viewContext.perform {
            let results = try! request.execute()
            
            if !results.isEmpty {
                productName = results[0].name
            } else {
                productName = nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
