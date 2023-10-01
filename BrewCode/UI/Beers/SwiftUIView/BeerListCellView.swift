//
//  BeerListCellView.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 22/07/23.
//

import SwiftUI
import Kingfisher

struct BeerListCellView: View {
    var cellModel: BeerListCellModel
    var body: some View {
        cellView
    }
    
    var cellView: some View {
        VStack {
            VStack {
                HStack {
                    
                    Spacer()
                    // Title Image using Kingfisher
                    KFImage(URL(string: cellModel.imageUrlString ?? ""))
                        .resizable()
                        .placeholder { _ in
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 80)
                    
                    Spacer()
                    
                }
                Text(cellModel.name)
                    .foregroundColor(.black)
                Text(cellModel.tagline)
                    .foregroundColor(.black)
            }
            .padding(10)
            
        }
        .background(
            // Gradient background
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    RadialGradient(gradient: Gradient(colors: [.white.opacity(0.5), .gray.opacity(0.5), .black.opacity(0.5)]), center: .center, startRadius: 50, endRadius: 200)
                    )
        )
        .cornerRadius(12)
        .overlay(
            // Overay boder
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white, lineWidth: 2)
                
            
        )
    .padding(10)
    }
}
