//
//  ContentView.swift
//  Drawing
//
//  Created by Scott Obara on 27/1/21.
//

import SwiftUI

struct Triangle: InsettableShape {
    var insetAmount : CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(
                        x: rect.midX,
                        y: rect.minY + (insetAmount > rect.midY ? rect.midY : insetAmount))
        )
        path.addLine(to: CGPoint(
                        x: rect.minX + (insetAmount > rect.midX ? rect.midX : insetAmount),
                        y: rect.maxY - (insetAmount > rect.midY ? rect.midY : insetAmount))
        )
        path.addLine(to: CGPoint(
                        x: rect.maxX - (insetAmount > rect.midX ? rect.midX : insetAmount),
                        y: rect.maxY - (insetAmount > rect.midY ? rect.midY : insetAmount))
        )
        path.addLine(to: CGPoint(
                        x: rect.midX,
                        y: rect.minY + (insetAmount > rect.midY ? rect.midY : insetAmount))
        )

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var triangle = self
        triangle.insetAmount += amount
        return triangle
    }
}

struct ColorCyclingArrow: View {
    var amount = 0.0
    var steps = 100
    var thickness: CGFloat = 1.0


    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                VStack(spacing: 0.0) {
                    Triangle()
                        .inset(by: CGFloat(value))
                        .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                        .frame(width: 200 * thickness, height: 200 * thickness)     ///Change width back to 200 unless inset is fixxed
                    Rectangle()
                        .inset(by: CGFloat(value))
                        .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                        .frame(width: 100 * thickness, height: 300 * thickness)
                }
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    
    @State var thickness: CGFloat = 1.0
    @State var colorCycle: CGFloat = 1.0
    @State var amount = 0.5
    
    
    var body: some View {
        VStack {
            VStack(spacing: 0.0) {
//                Triangle()
//                    .fill(Color.blue)
//                    .frame(width: 200 * thickness, height: 200 * thickness)
                ColorCyclingArrow(amount: amount, thickness: thickness)
                    //.fill(Color.blue)
                    .frame(width: 100 * thickness, height: 300 * thickness)
            }
            .frame(width: .infinity, height: 500)
            
            VStack {
                Text("Size")
                Slider(value: $thickness, in: 0.0...2.0)
                Text("Colour")
                Slider(value: $amount)
                                
            }
            .padding(.horizontal)
            .padding()
            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)))
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
