import SwiftUI

struct ContentView: View {
    
    @State public var inputText: String = ""
    @State public var itemSelected = 0
    @State public var units = ["Celsius (C)", "Fahrenheit (F)", "Kelvin (K)"]
    
    @State private var buttonText: String = "Copy to clipboard"
    private let pasteboard = UIPasteboard.general
    private let negative: String = "-"
    
    func calc(_ convert: String) -> String{
        var conversion: Double = 1.0
        let amount = Double(convert) ?? 0.0
        let selectedUnits = units[itemSelected]
        
        switch (selectedUnits){
        case "Celsius (C)" :
            conversion = amount
        case "Fahrenheit (F)" :
            conversion = (amount - 32) * 5/9
        case "Kelvin (K)" :
            conversion = amount - 273.15
        default:
            print("Something went wrong")
        }
        return String(format: "%.2f", conversion)
    }

    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                HStack{
                    Text("Temperature Unit :")
                
                    Picker(selection: $itemSelected, label: Text("From")){
                        ForEach(0 ..< units.count, id: \.self) {index in Text(self.units[index]).tag(index)
                        }
                    }.tint(.gray)
                }

                
                TextField("insert value",text: $inputText)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .keyboardType(.decimalPad)
                HStack {
                    Button {
                        neg()
                    } label: {
                        Text("Negative Value")
                    }
                    .tint(.red)
                    
                    Spacer()
                    Button {
                        copyToClipboard()
                    } label: {
                        Text("Copy")
                    }
                    .tint(.blue)
                    
                    Button {
                        paste()
                    } label: {
                        Text("Paste")
                    }
                    .tint(.orange)
                }
                .padding()
                Spacer()
                
                if let inputText = Float(calc(inputText)){
                    if (inputText > 39){
                        NavigationLink(destination: indicatorHotView(inputText: $inputText, units: $units[itemSelected]), label: {
                            Text("Convert")
                                .padding()
                                .frame(width: 200)
                                .background(Color.red.opacity(0.8).cornerRadius(10))
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                    }
                    else if (inputText < 0){
                        NavigationLink(destination: indicatorColdView(inputText: $inputText, units: $units[itemSelected]), label: {
                            Text("Convert")
                                .padding()
                                .frame(width: 200)
                                .background(Color.red.opacity(0.8).cornerRadius(10))
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                    }
                    else if (inputText > -1 ) && (inputText < 40 ){
                        NavigationLink(destination: indicatorNormView(inputText: $inputText, units: $units[itemSelected]), label: {
                            Text("Convert")
                                .padding()
                                .frame(width: 200)
                                .background(Color.red.opacity(0.8).cornerRadius(10))
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                    }
                }
                Spacer()
            }.padding()
        }
        .accentColor(.white)
    }
    
    func paste(){
        if let string = pasteboard.string {
            inputText = string
        }
    }
    
    func neg(){
            self.inputText = "-"
    }


    func copyToClipboard(){
        pasteboard.string = self.inputText
        self.inputText = ""
        self.buttonText = "Copied!"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.buttonText = "Copy to Clipboard"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
