//
//  CharacterRow.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha de Sousa on 24/06/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct CharacterRow: View {
    var character: Character
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Rectangle()
                        .foregroundColor(.red)
                        .frame(width: 10, height: 43)
                        
                    Text(character.name ?? "")
                }
                
                Text(character.description ?? "")
                    .padding()
                    .lineLimit(2)
                
                Button("Ver Mais", action: {})
                    .frame(width: 130, height: 35, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.red).padding(.leading)
            }
         
            Spacer()
            KFImage(character.thumbnail?.getUrl())
                .resizable()
                .frame(width: 150, height: 150)
        }

    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacterRow(character: characters[0])
        }
        .previewLayout(.fixed(width: 400, height: 150))
    }
}


let characters = loadCharacters()

func loadCharacters() -> [Character] {
    let response: Response<Character>  = load("characters.json")
    
    return response.results
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
