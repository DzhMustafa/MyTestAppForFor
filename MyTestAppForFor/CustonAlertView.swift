//
//  SecondView.swift
//  MyTestAppForFor
//
//  Created by Джабраилов Мустафа on 20.07.2024.
//

import SwiftUI

struct CustonAlertView: View {
    
    var body: some View {
        ScrollView() {
            ForEach(0..<20) { _ in
                Rectangle()
                    .frame(width: 150, height: 150)
            }
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    CustonAlertView()
}
