//
//  FormRowLinkView.swift
//  ToDoSwiftUI
//
//  Created by Khavishini on 13/07/2024.
//

import SwiftUI

struct FormRowLinkView: View {
    
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            Text(text)
                .foregroundColor(.gray)
           Spacer()
            
            Button(action: {
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            })
            .tint(Color(.systemGray2))
        }//: HStack
    }
}

#Preview {
    FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://github.com/Khavi18")
}
