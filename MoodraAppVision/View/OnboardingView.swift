//
//  OnboardingView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 05/03/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var pageIndex = 0
    private let pages : [Page] = Page.pages
    private let dotAppearance = UIPageControl.appearance()
    
    func goToZero() {
        
        pageIndex = 0
        
    }
    
    func incrementPage() {
        
        pageIndex += 1
    }
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack{
                    Spacer()
                    PageView(page: page)
                    Spacer()
                    
                    HStack {
                      
                        Button("Skip", action: goToZero )
                            .buttonStyle(.bordered)
                        
                        if (page == pages.last) {
                            Button("Start", action: goToZero )
                                .buttonStyle(.bordered)
                                .foregroundStyle(.black)
                                .tint(.white)
                                
                            
                        } else {
                            Button("Next", action: incrementPage )
                                .buttonStyle(.bordered)
                                .foregroundStyle(.black)
                                .tint(.white)
                            
                            
                            
                        }
                        
                        
                        
                       
                            
                        
                    }
                    
                    Spacer()
                    
                   
                } .tag(page.tag)
                    .padding()
            }
            
        }
        
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .black
            dotAppearance.pageIndicatorTintColor = .gray
        }
    }
}

#Preview {
    OnboardingView()
}
