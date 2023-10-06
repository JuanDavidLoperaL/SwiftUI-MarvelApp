//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 4/10/23.
//

import UIKit
import Combine

final class HomeViewModel: ObservableObject {
    
    // MARK: - Private Properties
    private let api: HomeAPIProtocol
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Internal Published Properties
    @Published var characters: [Characters] = [Characters]()
    
    // MARK: - Internal Init
    init(api: HomeAPIProtocol = HomeAPI()) {
        self.api = api
    }
    
    func fetchCharacters() {
        print("loading")
        api.fetchCharacters()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                print("not loading")
                switch error {
                case .finished:
                    let ghostCard: Characters = Characters(id: 1,
                                                           name: "",
                                                           description: "",
                                                           thumbnail: CharacterThumbnail(imagePath: "",
                                                                                         imageExtension: ""),
                                                           comics: CharactersComics(available: 0),
                                                           series: CharactersSeries(available: 0))
                    self?.characters.append(ghostCard)
                case .failure(let marvelError):
                    print(marvelError.localizedDescription)
                }
            } receiveValue: { [weak self] marvelObject in
                self?.characters = marvelObject.data.results
            }
            .store(in: &cancellables)
    }
}
