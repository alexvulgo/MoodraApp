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
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(mudra.mudras) { mudras in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                Image(mudras.images[0])
                                    .resizable()
                                    .cornerRadius(15)
                                    .frame(width: 250, height: 300)
                                    .shadow(radius: 10, y: 10)
                                    .scrollTransition(topLeading: .interactive,bottomTrailing: .interactive,axis: .horizontal) { effect, phase in effect
                                            .scaleEffect(1 - abs(phase.value))
                                            .opacity(1 - abs(phase.value))
                                            .rotation3DEffect(Angle(degrees: (phase.value * 90)), axis: (x: 0, y: 1 , z: 0))
                                        
                                            .scaleEffect(x: phase.isIdentity ? 1 : 0.8 , y: phase.isIdentity ? 1 : 0.8)
                                    }
                                
                                
                                    
                                
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedMudra = mudras
                                        }
                                    }
                                
                                
                            } .frame(depth: 50)
                            
                        } .scrollTargetLayout()
                    }
                    
                    .frame(height: 300)
                    .safeAreaPadding(.horizontal,32)
                    .scrollClipDisabled()
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $selectedMudra)
                    .onAppear() {
                        selectedMudra = mudra.mudras[2]
                    }
                    
                    
                }
            }
            
        }
    }
}




#Preview {
    MudraSelectionView(mudra: MudraViewModel())
}
