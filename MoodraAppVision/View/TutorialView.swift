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
        
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    //Back Button and Immersive Space Button
                    
                    Button {
                        openWindow(id: "main")
                        dismissWindow()
                        dismissWindow()
                    
                    } label: {
                        Label("Back", systemImage: "chevron.backward")
                            .labelStyle(.iconOnly)
                    }
                    .offset(y: -8)
                    
                    Button {
                        //Immersive Space
                    } label: {
                        Label("Immersive Space", systemImage: "mountain.2.fill")
                            .labelStyle(.iconOnly)
                    }
                    .offset(y: -8)
                    
                }.padding()
                
                
                HStack{
                    
                    Spacer()
                    
                    Text("\(selectedMudra[i].name)")
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                }
                
                HStack{
                    
                    Spacer()
                    
                    Text("Put your hands as shown")
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                }
                
                HStack(){
                    
                    
                    Spacer()
                    
                    ZStack{
                        Image(systemName: "circle")
                            .foregroundStyle(.red)
                            .font(.system(size: 60))
                        
                        Text("5")
                            .bold()
                            .font(.system(size: 30))
                    }
                    
                    Spacer()
                    
                }
                
                HStack{
                    
                    Spacer()
                    
                    Text("Incorrect Position")
                    
                    Spacer()
                    
                }.padding()
                
                
            }
            
        }//.frame(width: 1300, height: 360)
    }
}



/*#Preview {
 TutorialView()
 }*/
