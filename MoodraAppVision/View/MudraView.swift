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
    @Binding var dismissView : Bool
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    func dismissWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            dismiss()
        }
    }
    
    var body: some View {
        
        VStack(){
            Image(mudra[count].images[0])
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .onChange(of: dismissView, {if dismissView {dismissWindow()}})
        
    }
}

/* #Preview {
    MudraView()
}
*/
