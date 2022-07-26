//
//  MagnificationGesture.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/10/22.
//

import SwiftUI

struct Zoom
{
    @State private var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 5.0
    
    var zoom: some Gesture
    {
        MagnificationGesture()
            .onChanged { state in  adjustScale(from: state) }
            .onEnded { state in withAnimation{ validateScaleLimits() }; lastScale = 1.0 }
    }
    
    func adjustScale(from state: MagnificationGesture.Value)
    {
        let delta = state / lastScale
        scale *= delta
        lastScale = state
    }
    
    func getMinimumScaleAllowed() -> CGFloat
    {
        return max(scale, minScale)
    }
    
    func getMaximumScaleAllowed() -> CGFloat
    {
        return min(scale, maxScale)
    }
    
    func validateScaleLimits()
    {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
    
}
