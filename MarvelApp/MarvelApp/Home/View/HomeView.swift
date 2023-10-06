//
//  HomeView.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 3/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false)
        {
            HStack(spacing: 0.0) {
                ForEach(viewModel.characters) { marvelCharacter in
                    GeometryReader { geometry in
                        let isGhost: Bool = marvelCharacter.isGhost ?? false
                        let opacity: Double = isGhost ? 0.0 : 1.0
                        let scale: CGFloat = isGhost ? 0.0 : getScale(geometryProxy: geometry)
                        let imageURL: URL? = URL(string: "\(marvelCharacter.thumbnail.imagePath).\(marvelCharacter.thumbnail.imageExtension)")
                        buildCard(character: marvelCharacter,
                                  geometryProxy: geometry,
                                  scale: scale,
                                  imageURL: imageURL)
                        .opacity(opacity)
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.7)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding([.horizontal, .vertical], 50.0)
                }
            }
        }
        .background(Color.black.opacity(1))
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
    
    private func buildCard(character: Characters,
                           geometryProxy: GeometryProxy,
                           scale: CGFloat,
                           imageURL: URL?) -> some View {
        VStack(alignment: .center, spacing: 10.0) {
            Text("Character \(character.name)")
                .font(.system(size: 17.0, weight: .bold, design: .rounded))
                .foregroundColor(Color.white)
            AsyncImage(url: imageURL!)
                .scaledToFill()
                .frame(width: geometryProxy.size.width * 0.70, height: geometryProxy.size.height * 0.60)
                .clipped()
                .cornerRadius(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(white: 0.4))
                )
                .shadow(radius: 7)
            Text(character.description)
                .foregroundColor(Color.white)
            Button("See more") {
                print("button tapped")
            }
        }
        .scaleEffect(CGSize(width: scale, height: scale))
        .animation(.easeIn(duration: 1))
    }
    
    private func getScale(geometryProxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 100.0
        let viewFrame = geometryProxy.frame(in: .global)
        var scale: CGFloat = 1.0
        let detalXAnimationThreshold: CGFloat = 80.0
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - detalXAnimationThreshold / 2)
        if diffFromCenter < detalXAnimationThreshold {
            scale = 1 + (detalXAnimationThreshold - diffFromCenter) / 450
        }
        return scale
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
