//
//  MudraView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI

struct MudraView: View {
    
    
    @Binding var mudra : [Mudra]
    
    @Binding var count : Int
    
    
    var body: some View {
       
            VStack(){
             
                
                Image(mudra[count].images[count])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
               
                
                
            }
    }
}

/* #Preview {
    MudraView()
}
*/
