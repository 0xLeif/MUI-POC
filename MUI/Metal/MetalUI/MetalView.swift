//
//  MetalView.swift
//  MUI
//
//  Created by Zach Eriksen on 12/7/20.
//

import SwiftUI
import MetalKit

public struct MetalView: UIViewRepresentable {
    public var wrappedView: MTKView
    
    private var handleUpdateUIView: ((MTKView, Context) -> Void)?
    private var handleMakeUIView: ((Context) -> MTKView)?
    
    public init(closure: () -> MTKView) {
        wrappedView = closure()
    }
    
    public func makeUIView(context: Context) -> MTKView {
        guard let handler = handleMakeUIView else {
            return wrappedView
        }
        
        return handler(context)
    }
    
    public func updateUIView(_ uiView: MTKView, context: Context) {
        handleUpdateUIView?(uiView, context)
    }
}

public extension MetalView {
    mutating func setMakeUIView(handler: @escaping (Context) -> MTKView) -> Self {
        handleMakeUIView = handler
        
        return self
    }
    
    mutating func setUpdateUIView(handler: @escaping (MTKView, Context) -> Void) -> Self {
        handleUpdateUIView = handler
        
        return self
    }
}
