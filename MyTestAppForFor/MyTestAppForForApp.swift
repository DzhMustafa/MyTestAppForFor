//
//  MyTestAppForForApp.swift
//  MyTestAppForFor
//
//  Created by Джабраилов Мустафа on 20.07.2024.
//

import SwiftUI

@main
struct MyTestAppForForApp: App {
    
    let coreDataManger = CoreDataManager()
    
    @Environment(\.new) var count
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManger.container.viewContext)
                .onAppear {
                    
                }
        }
    }
}

struct CustomKey: EnvironmentKey {
    static var defaultValue: Int = 10
}

extension EnvironmentValues {
    var new: Int {
        get { self[CustomKey.self] }
        set { self[CustomKey.self] = newValue }
    }
}
