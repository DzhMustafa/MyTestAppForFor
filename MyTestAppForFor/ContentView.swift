//
//  ContentView.swift
//  MyTestAppForFor
//
//  Created by Джабраилов Мустафа on 20.07.2024.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
        
    var body: some View {
        ZStack {
            Color.primary.opacity(0.1).ignoresSafeArea()
            
            Button {
                NotificationCenter.default.post(name: NSNotification.Name("newMessage"), object: "New")
            } label: {
                Text("Show message")
            }

        }
        .showMessage()
    }
}

extension View {
    func showMessage() -> some View {
        self
            .overlay(alignment: .top) {
                Has()
            }
    }
}

struct Has: View {
    
    @State var message: String? = nil
    
    private var publisher = NotificationCenter.default.publisher(for: Notification.Name("newMessage"))
    
    var body: some View {
        
            ZStack {
                if let message {
                ZStack {
                    Text(message)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(.blue, in: .rect(cornerRadius: 20))
                    
                .transition(.asymmetric(insertion: .move(edge: .leading),
                                        removal: .move(edge: .trailing)))
            } else {
                EmptyView()
            }
        }
            .onReceive(publisher, perform: { value in
                guard let newMessage = value.object as? String else { return }
                
                withAnimation(.default) {
                    self.message = newMessage
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.default) {
                        self.message = nil
                    }
                }
            })
        
        
    }
    
}
final class MessageViewModel: ObservableObject {
    @Published var message: String? = nil
        
    private var cancellable: AnyCancellable? = nil
        
    
     init() {
        self.cancellable = $message
            .debounce(for: 1.5, scheduler: DispatchQueue.main)
            .sink { _ in
                self.message = nil
            }
    }
    
    func newMessage(_ message: String) {
        DispatchQueue.main.async {
            self.message = message
        }
    }
}

#Preview {
    ContentView()
}

class CoreDataManager {
    
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "DataContainer")
        self.container.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
        
    }
}
