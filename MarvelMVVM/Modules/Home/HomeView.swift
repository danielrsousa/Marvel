//
//  HomeView.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha de Sousa on 24/06/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characteres, id: \.self) {  character in
                    CharacterRow(character: character).onAppear {
                        self.viewModel.isLastCharacter(character)
                    }
                }
            }
            .navigationBarTitle(Text("Marvel"))
        }.onAppear {
            self.viewModel.fetch()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let stub = Stub(fileName: "characters", status: .success)
        let apimock = ApiMock(stub: stub)
        let service = CharactersApi(api: apimock)
        let viewModel = HomeViewModel(service: service)
        return HomeView(viewModel: viewModel)
    }
}
