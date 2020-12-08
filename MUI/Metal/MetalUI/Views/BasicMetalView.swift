//
//  BasicMetalView.swift
//  MUI
//
//  Created by Zach Eriksen on 12/7/20.
//

import MetalKit

class BasicMetalView: MTKView {
    var renderer: BasicMetalRenderer!
    
    init() {
        super.init(frame: .zero, device: MTLCreateSystemDefaultDevice())
        // Make sure we are on a device that can run metal!
        guard let defaultDevice = device else {
            fatalError("Device loading error")
        }
        colorPixelFormat = .bgra8Unorm
        // Our clear color, can be set to any color
        clearColor = MTLClearColor(red: 0.1, green: 0.57, blue: 0.25, alpha: 1)
        createRenderer(device: defaultDevice)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createRenderer(device: MTLDevice){
        renderer = BasicMetalRenderer(vertices: [
            MetalRenderingVertex(position: SIMD3(0,1,0), color: SIMD4(1,0,0,1)),
            MetalRenderingVertex(position: SIMD3(-1,-1,0), color: SIMD4(0,1,0,1)),
            MetalRenderingVertex(position: SIMD3(1,-1,0), color: SIMD4(0,0,1,1))
        ], device: device)
        delegate = renderer
    }
    
}
