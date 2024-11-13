//
//  Galeria1View.swift
//  lab02
//
//  Created by Lucely Mendoza on 12/11/24.
//
//
//  Galeria1View.swift
//  lab02
//
//  Created by Lucely Mendoza on 12/11/24.
//

import SwiftUI

struct Galeria1View: View {
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
                
            ZStack {
                Color(red: 1.0, green: 0.9, blue: 0.9)
                    .edgesIgnoringSafeArea(.all)
                
                Canvas { context, size in
                    // Dibujar contorno rectangular grande de la galería
                    let mainRect = CGRect(x: screenWidth * 0.2, y: screenHeight * 0.1, width: screenWidth * 0.6, height: screenHeight * 0.8)
                    
                    // Dibuja el contorno de la galería con borde punteado
                    var path = Path()
                    path.addRect(mainRect)
                    context.stroke(path, with: .color(.brown), style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
                    
                    // Añadir título de la galería
                    let titleTextStyle = Font.system(size: 20).bold()
                    context.draw(Text("GALERÍA I").font(titleTextStyle).foregroundColor(Color(red: 222 / 255, green: 166 / 255, blue: 23 / 255)), at: CGPoint(x: mainRect.midX, y: mainRect.midY))
                    
                    // Dibujar puerta semicircular en la izquierda
                    var doorPath = Path()
                    let doorStart = CGPoint(x: mainRect.minX, y: mainRect.midY - screenHeight * 0.05)
                    doorPath.addArc(center: doorStart, radius: screenHeight * 0.05, startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: true)
                    context.stroke(doorPath, with: .color(.black), style: StrokeStyle(lineWidth: 2, dash: [5, 3]))

                    
                    // Añadir texto descriptivo
                    let headerTextStyle = Font.system(size: 18).bold()
                    context.draw(Text("Croquis interior Galería I").font(headerTextStyle).foregroundColor(.red), at: CGPoint(x: screenWidth * 0.5, y: screenHeight * 0.05))
                    
                    let subTextStyle = Font.system(size: 14)
                    context.draw(Text("Tema: Homenaje a \"Chalo Guillén\"").font(subTextStyle).foregroundColor(.black), at: CGPoint(x: screenWidth * 0.5, y: screenHeight * 0.08))
                    context.draw(Text("Exposición colectiva de caricaturas").font(subTextStyle).foregroundColor(.gray), at: CGPoint(x: screenWidth * 0.5, y: screenHeight * 0.1))
                }
            }
            .frame(width: screenWidth, height: screenHeight)
        }
    }
}
