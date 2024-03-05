//
//  OnboardingView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 05/03/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    @State var pageIndex = 0
    private let pages : [Page] = Page.pages
    private let dotAppearance = UIPageControl.appearance()

    
    func incrementPage() {
        
        pageIndex += 1
    }
    
    
    func dismissWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            dismiss()
        }
    }
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack{
                    Spacer()
                    PageView(page: page)
                    Spacer()
                    
                    HStack {
                        
                        Button("Skip") {
                            openWindow(id : "main")
                            dismissWindow()
                        }
                            .buttonStyle(.bordered)
                        
                        if (page == pages.last) {
                            Button("Start"){
                                openWindow(id : "main")
                                dismissWindow()
                            }
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
