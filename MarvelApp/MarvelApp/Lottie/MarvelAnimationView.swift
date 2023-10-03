//
//  MarvelAnimationView.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 3/10/23.
//

import Lottie
import SwiftUI

struct MarvelAnimationView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView: LottieAnimationView = LottieAnimationView(name: "marvelAnimation")
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}
