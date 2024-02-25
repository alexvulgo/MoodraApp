//
//  MudraSelectionView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 23/02/24.
//

import SwiftUI

struct MudraSelectionView: View {
    
    var mudra = MudraViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack() {
                HStack{
                ForEach(mudra.mudras) { mudras in
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 250, height: 250)
                            .frame(depth: 100)
                    }
                }
            }
        }
    }
}




#Preview {
    MudraSelectionView(mudra: MudraViewModel())
}
