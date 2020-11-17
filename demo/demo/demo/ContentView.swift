//
//  ContentView.swift
//  demo
//
//  Created by Muhammed Gurhan Yerlikaya on 10.08.2020.
//  Copyright © 2020 https://github.com/gurhub. All rights reserved.
//

import SwiftUI
import fat

struct ContentView: View {
    var body: some View {
        GreetingsManager.shared().name = "Universal Framework"
        
        let message = Text(GreetingsManager.greetings())
            .font(.title)
                    
        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
