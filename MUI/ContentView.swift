//
//  ContentView.swift
//  MUI
//
//  Created by Zach Eriksen on 12/7/20.
//

import MetalUI
import SwiftUI

struct ContentView: View {
    var body: some View {
        MetalView {
            BasicMetalView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
