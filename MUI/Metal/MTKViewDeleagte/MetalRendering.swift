//
//  MetalRendering.swift
//  MUI
//
//  Created by Zach Eriksen on 12/7/20.
//

import MetalKit

protocol MetalRendering: NSObject, MTKViewDelegate {
    var commandQueue: MTLCommandQueue? { get set }
    var renderPipelineState: MTLRenderPipelineState? { get set }
    var vertexBuffer: MTLBuffer? { get set }
    
    var vertices: [MetalRenderingVertex] { get set }
    
    init()
    init(
        vertices: [MetalRenderingVertex],
        device: MTLDevice
    )
    
    func createCommandQueue(device: MTLDevice)
    func createPipelineState(
        withLibrary library: MTLLibrary?,
        forDevice device: MTLDevice
    )
    func createBuffers(device: MTLDevice)
    
    // MARK: MTKViewDelegate
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize)
    func draw(in view: MTKView)
}

extension MetalRendering {
    init(vertices: [MetalRenderingVertex], device: MTLDevice) {
        self.init()
        createCommandQueue(device: device)
        createPipelineState(withLibrary: device.makeDefaultLibrary(), forDevice: device)
        createBuffers(device: device)
    }
}

// MARK: Metal Stuff
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
