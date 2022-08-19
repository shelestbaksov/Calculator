//
//  ContentView.swift
//  Calculator
//
//  Created by Leysan Latypova on 18.08.2022.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent, decimal
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .divide: return "/"
        case .ac: return "AC"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .decimal: return "."
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

enum Operation {
    case plus, minus, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack (spacing: 12) {
                HStack{
                    Spacer()
                    Text(value).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button {
                                self.didTap(button: button)
                            } label: {
                                Text(button.title)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                                    .foregroundColor(.white)
                                    .background(button.backgroundColor)
                                    .cornerRadius(self.buttonWidth(button: button))
                            }
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    
    
    
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    func didTap(button: CalculatorButton) {
        switch button {
        case .plus, .minus, .multiply, .divide, .equals :
            if button == .plus {
                self.currentOperation = .plus
                self.runningNumber += Int(self.value) ?? 0
            } else if button == .minus {
                self.currentOperation = .minus
                self.runningNumber += Int(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber += Int(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber += Int(self.value) ?? 0
            } else if button == .equals {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation{
                case .plus: self.value = "\(runningValue + currentValue)"
                case .minus: self.value = "\(runningValue - currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .none:  break
                    
                }
            }
            if button != .equals {
                self.value = "0"
            }
        case .ac:
            value = "0"
        case .plusMinus, .percent, .decimal:
            break
        default:
            let number = button.title
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
