//
//  ContentView.swift
//  MyTestAppForFor
//
//  Created by Джабраилов Мустафа on 20.07.2024.
//

import SwiftUI
import MyLibrary

struct ContentView: View {
    
    var body: some View {
        
        NavigationStack {
            NavigationLink {
                SecondView()
            } label: {
                Text("Show")
                Text("Getinger")
                Text("Print")
            }
            
        }
    }
}

struct SecondView: View {
    
    @State var isPresented = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
        }
        .overlay {
            if isPresented {
                CustonAlertView()
                    .frame(maxWidth: .infinity)
                    .transition(.move(edge: .leading))
                    .onTapGesture {
                        withAnimation(.default) {
                            isPresented = false
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
