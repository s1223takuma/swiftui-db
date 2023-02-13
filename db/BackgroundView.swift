//
//  BackgroundView.swift
//  db
//
//  Created by 関琢磨 on 2023/02/13.
//

import SwiftUI

struct fstBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        fstBackgroundView()
        BackgroundView()
        scndBackgroundView()
    }
}

struct fstBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}



struct BackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct scndBackgroundView: View {
    var body: some View {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 0, endRadius: 500)
                    .edgesIgnoringSafeArea(.all)
            }
    }
}

