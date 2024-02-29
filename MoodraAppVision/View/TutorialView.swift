//
//  TutorialView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI

struct TutorialView: View {
    
    @Binding var selectedMudra : [Mudra]
    @State private var i = 0
    @State private var counter = 0
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    func dismissWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            dismiss()
        }
    }
    
    var body: some View {
        HStack{
            
            VStack{
                
                Button("Exit tutorial"){
                    openWindow(id: "main")
                    dismissWindow()
                }
                
                Text("Immersive Space")
            }
            .padding()
            
            Spacer()
            
            VStack{
                
                Text("\(selectedMudra[i].name)")
                    .padding()
                
                Spacer()
                
                Text("\(selectedMudra[i].instructions[counter])")
                    .padding()
                    .onTapGesture {
                        counter = ((counter + 1) % (selectedMudra[i].instructions.count))
                    }
                
                Spacer()
                
                Text("\(counter+1)/\(selectedMudra[i].instructions.count)")
                    .padding()
            }
            .padding()
            
            Spacer()
            
            VStack{
                
                ZStack{
                    Image(systemName: "circle")
                        .foregroundStyle(.red)
                        .font(.system(size: 60))
                    
                    Text("5")
                        .bold()
                        .font(.system(size: 30))
                }
                
                Text("Incorrect Position")
            }
                .padding()
            
        }.frame(width: 1300, height: 360)
    }
}


/*#Preview {
    TutorialView()
}*/
