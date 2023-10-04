//
//  SplashScreen.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 3/10/23.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                NavigationLink(isActive: $navigateToHome) {
                    HomeView()
                } label: {}

                MarvelAnimationView(loopMode: .loop)
                    .scaleEffect(0.5)
                VStack(alignment: .center,
                       spacing: 10.0) {
                    Spacer()
                    Spacer()
                    Text("Marvel App")
                        .foregroundColor(.white)
                        .font(.system(size: 50.0, weight: .bold, design: .rounded))
                    Spacer()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.navigateToHome = true
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
