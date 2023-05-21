//
//  LottieView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 22/05/23.
//

import SwiftUI
import Lottie

enum AppAnimations: String {
    case loading = "loading.json"
}
 
struct LottieView: UIViewRepresentable {
    let lottieFile: AppAnimations
 
    let animationView = LottieAnimationView()
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = LottieAnimation.named(lottieFile.rawValue)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}
