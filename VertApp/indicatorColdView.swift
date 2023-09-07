import SwiftUI

struct indicatorColdView: View {

    func calc(_ convert: String) -> String{
        var conversion: Double = 1.0
        let amount = Double(convert) ?? 0.0
        let selectedUnits = units
        
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
    func calF(_ convert: String) -> String{
        var conversion: Double = 1.0
        let amount = Double(convert) ?? 0.0
        let selectedUnits = units
        
        switch (selectedUnits){
        case "Celsius (C)" :
            conversion = (amount * 9/5) + 32
        case "Fahrenheit (F)" :
            conversion = amount
        case "Kelvin (K)" :
            conversion = (amount - 273.15) * 9/5 + 32

        default:
            print("Something went wrong")
        }
        return String(format: "%.2f", conversion)
    }
    
    func calK(_ convert: String) -> String{
        var conversion: Double = 1.0
        let amount = Double(convert) ?? 0.0
        let selectedUnits = units
        
        switch (selectedUnits){
        case "Celsius (C)" :
            conversion = amount + 273.15
        case "Fahrenheit (F)" :
            conversion = (amount - 32) * 5/9 + 273.15
        case "Kelvin (K)" :
            conversion = amount
        default:
            print("Something went wrong")
        }
        return String(format: "%.2f", conversion)
    }
    
    @Binding var inputText: String
    @Binding var units : String
    
    var body: some View {
            VStack{
                Spacer()
                
                Image("indicatorCold")
                    .resizable()
                    .scaledToFit()
                    .animation(Animation.easeInOut(duration: 1).repeatForever())
                Spacer()
                
                HStack{
                    Spacer()
                    Text(calc(inputText)).foregroundColor(.white)
                        .font(.custom("Helvetica Neue", size: 30)).bold()
                    Spacer()
                    Text(calF(inputText)).foregroundColor(.white)
                        .font(.custom("Helvetica Neue", size: 30)).bold()
                    Spacer()
                    Text(calK(inputText)).foregroundColor(.white)
                        .font(.custom("Helvetica Neue", size: 30)).bold()
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text("Celsius °C").foregroundColor(.white)
                        .font(.custom("Helvetica Neue", size: 20))
                    Spacer()
                    Text("Fahrenheit °F").foregroundColor(.white)
                        .font(.custom("Helvetica Neue", size: 20))
                    Spacer()
                    Text("Kelvin °K").foregroundColor(.white)
                        .font(.custom("Helvetica Neue", size: 20))
                    Spacer()
                }
            }
            .background(AsyncImage(url: URL(string: "https://pbs.twimg.com/media/FYHK6d7XgAEkWL4.jpg")))
            .edgesIgnoringSafeArea([.top])
        }
}

