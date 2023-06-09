//
//  KeysView.swift
//  Calculator
//
//  Created by Kaplan2 on 08/06/23.
//

import SwiftUI

struct KeysView: View {
    let buttons: [[Keys]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.seven,.subtract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal]
    ]
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    @State var changeColor = false
    
    var body: some View {
        VStack (spacing: 30) {
            Spacer()
            topView
            bottomKeys
        }.padding()
    }
    
    func getWidth(ele: Keys) -> CGFloat {
        if ele == .zero {
           return (UIScreen.main.bounds.width - (5*10))/2
        }
        return (UIScreen.main.bounds.width - (5*10))/4
    }
    
    func getHeight(ele: Keys) -> CGFloat {
      return  (UIScreen.main.bounds.width - (5*10))/5
    }
}

struct KeysView_Previews: PreviewProvider {
    static var previews: some View {
        KeysView()
    }
}

extension KeysView {
    var topView: some View {
        HStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(changeColor ? Color(ColorCode.n.rawValue).opacity(0.4) : Color.pink.opacity(0.2))
                .scaleEffect(changeColor ? 1.5 : 1.0)
                .frame(height: 180)
                .animation(.easeInOut.speed(0.18).repeatForever(), value: changeColor).onAppear(perform: {
                    self.changeColor.toggle()
                })
                .overlay {
                    Text(value)
                        .bold()
                        .font(.system(size: value.count > 4 ? 50:100))
                }
        }.padding()
    }
    
    var bottomKeys: some View {
        ForEach(buttons, id: \.self) { rows in
            HStack(spacing: 10) {
                ForEach(rows, id: \.self) { elem in
                    Button {
                        didtap(button: elem)
                    } label: {
                        Capsule().fill(elem.buttonColor)
                            .frame(width: self.getWidth(ele: elem),height: self.getHeight(ele: elem))
                            .overlay {
                                Text(elem.rawValue)
                            }.shadow(color: .purple.opacity(0.8), radius:30)
                            .foregroundColor(.black)
                            .font(.system(size: 30))
                    }
                }
            }.padding(.bottom,4)
        }
    }
        
}

extension KeysView {
    
    func didtap(button: Keys) {
        print(button.rawValue)
        switch button {
        case .add,.subtract,.multiply,.divide,.equal,.percent:
            if button == .equal  {
                let runningValue = Operation.preciseRound(self.runningNumber)
                let currentValue = Double(self.value) ?? 0
                self.value = "\(self.currentOperation.finalvalue(runValue: runningValue, currValue: currentValue, operation: self.currentOperation))"
            } else if button == .percent {
                let runningValue = Operation.preciseRound(Double(self.value) ?? 0)
                self.value = "\(Operation.preciseRound(runningValue/100,precision: .hundredths))"
            }
            else {
                self.currentOperation = self.currentOperation.operation(key: button)
                self.runningNumber = Double(self.value) ?? 0
                self.value = "0"
            }
     
        case .clear:
            self.value = "0"
        case .negative:
            self.value = "-\(Double(self.value) ?? 0)"

        case .decimal:
            if let n = Int(self.value) {
                self.value = "\(n)."
            }
        default:
            let number = button.rawValue
            if self.value == "0" {
                self.value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
            
        }
    }
}

