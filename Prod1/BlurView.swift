//
//  BlurView.swift
//  Prod1
//
//  Created by Kelvin Mahaja on 16/02/2024.
//

import SwiftUI

struct BlurView: View {
    var body: some View {
        ZStack {
            BlurEffect(style: .systemMaterialDark)
            HabitTracker()
                .foregroundColor(Color.white)
        }
    }
}

struct BlurEffect: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(
            effect: UIBlurEffect(style: style)
        )
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    }
}

#Preview {
    BlurView()
        .ignoresSafeArea()
}
