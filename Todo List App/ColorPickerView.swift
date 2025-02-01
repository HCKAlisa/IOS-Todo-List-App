//
//  ColorPickerView.swift
//  Todo List App
//
//  Created by Chung Ki Ho on 15/4/2024.
//

import SwiftUI

struct ColorPickerView: View {
    enum Option: Int, CaseIterable {
            case none,
            red,
            orange,
            yellow,
            mint,
            teal,
            blue,
            indigo
            
            func color() -> Color {
                
                switch self {
                case .none:
                    return Color.pink
                case .red:
                    return Color.red
                case .orange:
                    return Color.orange
                case .yellow:
                    return Color.yellow
                case .mint:
                    return Color(.systemMint)
                case .blue:
                    return Color.blue
                case .indigo:
                    return Color(.systemIndigo)
                case .teal:
                    return Color(.systemTeal)
                }
            }
            
        }
        
    @Binding var selection: Option
    
    var background: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(.lightGray))
    }
    
    func backgroundForOption(_ option: Option) -> Color {
            
            if option == selection {
                return Color(.systemBackground)
            } else {
                return .clear
            }
        }
    
    func sizeForOption(_ option: Option) -> CGFloat {
            if option == selection {
                return 22.0
            } else {
                return 18.0
            }
        }

        let selectionRingWidth: CGFloat = 40.0
        let containerHeight: CGFloat = 50.0

        func imageNameForOption(_ option: Option) -> String {
            if option != selection {
                return "circle.fill"
            } else {
                return "smallcircle.fill.circle.fill"
            }
        }
        
        func imageForOption(_ option: Option) -> some View {
            Image(systemName: self.imageNameForOption(option))
                .onTapGesture {
                    self.selection = option
            }
            .font(.system(size: self.sizeForOption(option)))
            .foregroundColor(option.color())
            .frame(width: self.selectionRingWidth, height: self.selectionRingWidth, alignment: .center)
            .cornerRadius(containerHeight / 2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    
    var body: some View{
        ZStack(alignment: .ZAlignment)  {
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: self.selectionRingWidth, height: self.selectionRingWidth, alignment: .center)
                        .alignmentGuide(HorizontalAlignment(Alignment.CustomAlignment.self), computeValue: { d in d[HorizontalAlignment.center] })
                        .animation(.spring(), value: 45)
                    HStack {
                        ForEach(Option.allCases, id: \.self) { option in
                            Group {
                                if option == self.selection {
                                    self.imageForOption(option)
                                    .alignmentGuide(HorizontalAlignment(Alignment.CustomAlignment.self), computeValue: { d in d[HorizontalAlignment.center] })
                                } else {
                                    self.imageForOption(option)
                                }
                            }
                        }
                    }
                }
                .padding(4)
                .frame(maxWidth: .infinity, minHeight: self.containerHeight, maxHeight: self.containerHeight, alignment: .center)
                .background(background)
            }
    }
    
extension Alignment {
    //adapted from: https://swiftui-lab.com/alignment-guides/
    enum CustomAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }
    static let ZAlignment = Alignment(horizontal: HorizontalAlignment(CustomAlignment.self), vertical: .center)
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        
        @State(initialValue: .none) var option: ColorPickerView.Option
        
        var body: some View {
            ColorPickerView(selection: $option)
        }
    }
}
