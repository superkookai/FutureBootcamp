//
//  ContentView.swift
//  FutureBootcamp
//
//  Created by Weerawut Chaiyasomboon on 15/03/2568.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = FutureViewModel()
    
    var body: some View {
        VStack {
            Text(vm.title)
        }
    }
}

#Preview {
    ContentView()
}
