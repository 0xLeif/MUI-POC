//
//  ContentView.swift
//  MUI
//
//  Created by Zach Eriksen on 12/7/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MetalView {
                BasicMetalView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
