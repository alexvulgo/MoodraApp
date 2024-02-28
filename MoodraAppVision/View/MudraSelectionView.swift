//
//  MudraSelectionView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 23/02/24.
//

import SwiftUI

struct MudraSelectionView: View {
    
    var mudra = MudraViewModel()
    
    @State var selectedMudra : Mudra?
    
    @State private var currentIndex = 0
    
    @GestureState private var dragOffset : CGFloat = 0
    
    var body: some View {
        
        NavigationStack {
            
            VStack() {
                
                
                ZStack {
                    //Mudra Card Scrolling
                    ForEach(0..<mudra.mudras.count, id: \.self) { index in
                        ZStack(){
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.ultraThinMaterial)
                                
                            VStack(){
                                Image(mudra.mudras[index].images[0])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Text(mudra.mudras[index].name)
                            }
                        } //END OF CARD ZSTACK
                        .frame(width: 280, height: 400)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.2 : 1.0)
                        .offset(x: CGFloat(index - currentIndex)*300 + dragOffset, y:0)
                       
                    }
                }.padding(.vertical,10)
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex-1)
                                    
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(mudra.mudras.count, currentIndex+1)
                                }
                            }
                        
                        })
                    
                    )
                
                
                
                
            } .navigationTitle("Choose mudras")
            
        }
    }
}




#Preview {
    MudraSelectionView(mudra: MudraViewModel())
}
