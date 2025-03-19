//
//  ContentView.swift
//  window-resize
//
//  Created by Luciano Paranhos on 18/03/25.
//

import SwiftUI

struct ContentView: View {
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { print("Configurações") }) {
                    Label("Configurações", systemImage: "gearshape")
                }
            }
        }
    }
}

// Extensão para suporte a fundo translúcido no macOS
#if os(macOS)
import AppKit

func animateWindowResize(to newSize: NSSize) {
    if let window = NSApp.mainWindow {
        let currentFrame = window.frame
        let newOrigin = NSPoint(
            x: currentFrame.origin.x + (currentFrame.size.width - newSize.width) / 2,
            y: currentFrame.origin.y + (currentFrame.size.height - newSize.height) / 2
        )
        
        let newFrame = NSRect(origin: newOrigin, size: newSize)
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3 // Tempo da animação em segundos
            context.allowsImplicitAnimation = true
            window.setFrame(newFrame, display: true, animate: true)
        }, completionHandler: nil)
    }
}

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
