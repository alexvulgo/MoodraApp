//
//  MudraView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI

struct MudraView: View {
    
    
    var mudra = MudraViewModel()
    
    
    var body: some View {
       
            VStack(){
             
                
                Image(mudra.mudras[0].images[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
               
                
                
            }
    }
}

#Preview {
    MudraView()
}
