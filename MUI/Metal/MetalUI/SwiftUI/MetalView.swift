//
//  MetalView.swift
//  MUI
//
//  Created by Zach Eriksen on 12/7/20.
//

import SwiftUI
import MetalKit

public struct MetalView<Content>: UIViewRepresentable where Content: MetalPresenting {
    public var wrappedView: Content
    
    private var handleUpdateUIView: ((Content, Context) -> Void)?
    private var handleMakeUIView: ((Context) -> Content)?
    
    public init(closure: () -> Content) {
        wrappedView = closure()
    }
    
    public func makeUIView(context: Context) -> Content {
        guard let handler = handleMakeUIView else {
            return wrappedView
        }
        
        return handler(context)
    }
    
    public func updateUIView(_ uiView: Content, context: Context) {
        handleUpdateUIView?(uiView, context)
    }
}

public extension MetalView {
    mutating func setMakeUIView(handler: @escaping (Context) -> Content) -> Self {
        handleMakeUIView = handler
        
        return self
    }
    
    mutating func setUpdateUIView(handler: @escaping (Content, Context) -> Void) -> Self {
        handleUpdateUIView = handler
        
        return self
    }
}
