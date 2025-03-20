//
//  ContentView.swift
//  p03-organizacao
//
//  Created by Luciano Paranhos on 19/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            VisualEffectView(material: .underWindowBackground)
                .edgesIgnoringSafeArea(.all) // Garante que o fundo cubra toda a janela
            
            VStack {
                HStack {
                    Button("640x480") { animateWindowResize(to: NSSize(width: 640, height: 480)) }
                    Button("800x600") { animateWindowResize(to: NSSize(width: 800, height: 600)) }
                    Button("1024x768") { animateWindowResize(to: NSSize(width: 1024, height: 768)) }
                }
                .buttonStyle(.bordered)
            }
            .frame(minWidth: 400, minHeight: 300)
        }
        .onAppear {
            if let window = NSApp.windows.first {
                window.title = "Window Search"
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                EmptyView()
            }
        }.searchable(text: $searchText, placement: .toolbar, prompt: "Buscar...")
    }
}

// Extensão para suporte a fundo translúcido no macOS
#if os(macOS)
import AppKit

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
#endif

#Preview {
    ContentView()
}
