//
//  WindowResizeHelper.swift
//  p03-organizacao
//
//  Created by Luciano Paranhos on 19/03/25.
//

import Foundation
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
