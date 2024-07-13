//
//  EmptyListView.swift
//  ToDoSwiftUI
//
//  Created by Khavishini on 13/07/2024.
//

import SwiftUI

struct EmptyListView: View {
    
    @State private var isAnimated: Bool = false
    
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    let images = ["illustration-no1", "illustration-no2", "illustration-no3"]
    let tips = ["Use your time wisely.",
                "Slow and steady wins the race.",
                "Keep it short and sweet.",
                "Put hard tasks first.",
                "Reward yourself after work.",
                "Collect tasks ahead of time.",
                "Each night schedule for tomorrow."]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("\(images.randomElement() ?? self.images[0])")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                    .foregroundStyle(themes[self.theme.themeSettings].themeColor)
                
                Text("\(tips.randomElement() ?? self.tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(themes[self.theme.themeSettings].themeColor)
            }//:VStack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5), value: isAnimated)
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }//:ZStack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .ignoresSafeArea(.all, edges: .all)
    }
}

#Preview {
    EmptyListView()
}
