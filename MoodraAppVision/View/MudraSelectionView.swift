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
                        ForEach(0..<mudra.mudras.count, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.ultraThinMaterial)
                                VStack(){
                                    Image(mudra.mudras[index].images[0])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(15)
                                        .frame(width: 250)
                                        .shadow(radius: 10, y: 10)
                                        .scrollTransition(topLeading: .interactive,bottomTrailing: .interactive,axis: .horizontal) { effect, phase in effect
                                                .scaleEffect(1 - abs(phase.value))
                                                .opacity(1 - abs(phase.value))
                                                .rotation3DEffect(Angle(degrees: (phase.value * 90)), axis: (x: 0, y: 1 , z: 0))
                                            
                                                .scaleEffect(x: phase.isIdentity ? 1 : 0.8 , y: phase.isIdentity ? 1 : 0.8)
                                        }
                                    
                                    Text(mudra.mudras[index].name)
                                }
                                    
                                
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedMudra = mudra.mudras[index]
                                        }
                                    }
                                
                                
                            } .frame(depth: 50)
                                .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                            
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
