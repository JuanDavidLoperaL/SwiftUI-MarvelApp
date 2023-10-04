//
//  HomeView.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 3/10/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false)
        {
            HStack(spacing: 0.0) {
                ForEach(0..<5) { number in
                    GeometryReader { geometry in
                        let scale: CGFloat = getScale(geometryProxy: geometry)
                        buildCard(number: number,
                                  geometryProxy: geometry,
                                  scale: scale)
                    }
                    .frame(width: 200.0, height: 400.0)
                    .padding([.horizontal, .vertical], 32.0)
                }
            }
        }
    }
    
    private func buildCard(number: Int, geometryProxy: GeometryProxy, scale: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 10.0) {
            Text("Character \(number + 1)")
                .font(.system(size: 25.0, weight: .bold, design: .rounded))
            Image("placeHolderImage")
                .scaledToFill()
                .frame(width: geometryProxy.size.width * 0.70, height: geometryProxy.size.height * 0.60)
                .clipped()
                .cornerRadius(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(white: 0.4))
                )
                .shadow(radius: 7)
                .padding()
            Text("Brief Description Here")
            Button("See more") {
                print("button tapped")
            }
        }
        .scaleEffect(CGSize(width: scale, height: scale))
        .animation(.easeIn(duration: 1))
    }
    
    private func getScale(geometryProxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 120.0
        let viewFrame = geometryProxy.frame(in: .global)
        var scale: CGFloat = 1.0
        let detalXAnimationThreshold: CGFloat = 120.0
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - detalXAnimationThreshold / 2)
        if diffFromCenter < detalXAnimationThreshold {
            scale = 1 + (detalXAnimationThreshold - diffFromCenter) / 500
        }
        return scale
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
