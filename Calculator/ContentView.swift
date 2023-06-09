//
//  ContentView.swift
//  Calculator
//
//  Created by Kaplan2 on 08/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(ColorCode.n.rawValue),Color(ColorCode.v.rawValue),Color(ColorCode.h.rawValue)], startPoint: .top, endPoint: .bottom)
            KeysView()
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
