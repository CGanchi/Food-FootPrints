//
//  File.swift
//  FoodEmissions
//
//  Created by Camron Ganchi  on 9/9/24.
//

import Foundation
import SwiftUI
import WebKit

struct Homeview: View {
    
    struct GIFView: UIViewRepresentable {
        let gifName: String

        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            if let path = Bundle.main.path(forResource: gifName, ofType: "gif") {
                let url = URL(fileURLWithPath: path)
                if let data = try? Data(contentsOf: url) {
                    webView.load(data, mimeType: "image/gif", characterEncodingName: "", baseURL: url.deletingLastPathComponent())
                }
            }
            return webView
        }

        func updateUIView(_ uiView: WKWebView, context: Context) {}
    }
    
    @State private var userEmissions = 0
    
    @State private var userLand = 0
    
    @State private var userWater = 0
    
    @State private var userEutroph = 0
    
    @State private var text: String = ""


    @State private var suggestions = [String]()



    @State private var chosen = false



    @State private var buttonPushes = -1



    @State private var text2: String = ""



    @State private var foodsList = []



    @State private var numFoods = 0



    @State private var totalEmission = 0.0



    @State private var totalWater = 0.0



    @State private var totalLand = 0.0



    @State private var totalEutroph = 0.0



    @State private var entireMealCounter = 0



    @State private var dataCounter = 0



    @State private var fAndCCounter = 0



    @State private var isCDCVisible = false



    @State private var isRSVisible = false



    @State private var isTMVisible = false



    @State private var isPRSVisible = false



    @State private var isRUVisible = false




    @State private var firstHL = true



    @State private var rand1 = Int.random(in: 1..<213)



    @State private var rand2 = Int.random(in: 1..<213)



    @State private var rand1Res = 0.0



    @State private var rand2Res = 0.0



    @State private var meals: [String] = UserDefaults.standard.array(forKey: "meals") as? [String] ?? []



    @State private var text3: String  = ""



    @State private var SMealCounter = 0



    @State private var MealTracker = 0
    

    @State private var UserEmissionsTotal: Double = UserDefaults.standard.double(forKey: "UserEmissionsTotal") as? Double ?? 0.0

    @State private var CalsVSNon = 0



    @State private var FileName = "food-footprints"

    

    @State private var itemButt = 0

    

    @State private var BTimes: [String] = UserDefaults.standard.array(forKey: "BTimes") as? [String] ?? []

    

    @State private var podium = 0
    
    
    @State private var quotes: [String] = ["If the environment is happy, people will laugh and your grief will go away.", "The Earth is what we all have in common.", "The earth is always changing...readjusting to our existence. Each era is full of unique challenges", "Land really is the best art.", "You don’t live on earth, you are passing through.", "We are on Earth to take care of life. We are on Earth to take care of each other.", "You can never see a plant grow, but they do.", "The greatest threat to our planet is the belief that someone else will save it.", "A vibrant, fair, and regenerative future is possible — not when thousands of people do climate justice activism perfectly but when millions of people do the best they can.", "We are the first generation to feel the impact of climate change and the last generation that can do something about it.", "An understanding of the natural world and what’s in it is a source of not only a great curiosity but great fulfillment.", "Look after the land and the land will look after you, destroy the land and it will destroy you.", "For in the true nature of things, if we rightly consider, every green tree is far more glorious than if it were made of gold and silver.", "There is no medicine you can take that has such a direct influence on your health as a walk in a beautiful forest.", "All we have to do is to wake up and change.", "We won’t have a society if we destroy the environment.", "What we are doing to the forests of the world is but a mirror reflection of what we are doing to ourselves and to one another.", "Our planet’s alarm is going off, and it is time to wake up and take action!"]
    
    
    func saveUserEmissionsTotal(){
        UserDefaults.standard.set(UserEmissionsTotal, forKey: "UserEmissionsTotal")
    }
    
    func foodName(jumble: String) -> String{



        var food = ""



        if let firstNum = jumble.firstIndex(where: { $0.isNumber }) {



            food = String(jumble[..<firstNum])



        }



        return String(food)



    }
    
    func findRow(combo: String) -> Int{



        let food = foodName(jumble: combo)



        



        if let array = readCSV(from: FileName) {



            for i in 0..<array.count{



                if(array[i][20] == food){



                    return i



                }



            }



        }



        return -1



    }

    func foodCals(messy: String) -> Double{



        var food = ""



        if let firstNum = messy.firstIndex(where: { $0.isNumber }) {



            food = String(messy[firstNum...])



        }



        return Double(food)!



    }
    
    func readCSV(from fileName: String) -> [[String]]? {



        // Find the file URL in the project bundle



        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") else {



            print("File not found")



            return nil



        }



        



        do {



            // Read the contents of the file



            let contents = try String(contentsOfFile: filePath)



            // Split the contents into rows



            let rows = contents.components(separatedBy: "\n")



            // Split each row into columns and create a 2D array



            let array = rows.map { $0.components(separatedBy: ",") }



            return array



        } catch {



            print("File read error: \(error)")



            return nil



        }



    }

    func getRealTime(oneTime: String) -> Int{

        var spaceIndex = -1

        for i in 0...(oneTime.count-1){

            if(oneTime[oneTime.index(oneTime.startIndex, offsetBy: i)] == " "){

                spaceIndex = i

                break

            }

            

        }

        let endIndex = oneTime.index(oneTime.startIndex, offsetBy: spaceIndex)

        let substringg = oneTime[oneTime.startIndex..<endIndex]

        return Int(substringg)!

    }



    

    func saveMeals() {

            UserDefaults.standard.set(meals, forKey: "meals")

        }

    

    func saveTimes(){

        UserDefaults.standard.set(BTimes, forKey: "BTimes")

    }

    

    func getCurrentDateTime() -> String {

            let currentDateTime = Date()

            let formatter = DateFormatter()

            formatter.dateStyle = .medium

            formatter.timeStyle = .medium

            return formatter.string(from: currentDateTime)

        }

    

    func updateAll(){



        if let array = readCSV(from: FileName) {



            for i in 0..<foodsList.count{



            let foodItem = foodsList[i] as? String ?? ""



            updateTotalLand(foodItem: foodItem, array: array)



            updateTotalEmissions(foodItem: foodItem, array: array)



            updateTotalWater(foodItem: foodItem, array: array)



            updateTotalEutroph(foodItem: foodItem, array: array)



        }



    



        }



    }



    



    func updateRandResesFirst(){



        rand1 = Int.random(in: 1..<213)



        rand2 = Int.random(in: 1..<213)



        if let array = readCSV(from: FileName) {



            rand1Res = Double(array[rand1][1])! * (1/1000000)



            rand2Res = Double(array[rand2][1])! * (1/1000000)



        }



    }







    func updateTotalLand(foodItem: String, array: [[String]]) {

        let cals = foodCals(messy: foodItem)

        let rowIndex = findRow(combo: foodItem)

        if let landUse = Double(array[rowIndex][5]), !landUse.isNaN {

            let resultLand = landUse * (1/1000000)

            totalLand += resultLand * Double(cals)

        }

    }



    func updateTotalEutroph(foodItem: String, array: [[String]]) {

        let cals = foodCals(messy: foodItem)

        let rowIndex = findRow(combo: foodItem)

        if let eutroph = Double(array[rowIndex][9]), !eutroph.isNaN {

            let resultEutroph = eutroph * (1/1000000)

            totalEutroph += resultEutroph * Double(cals)

        }

    }



    func updateTotalEmissions(foodItem: String, array: [[String]]) {

        let cals = foodCals(messy: foodItem)

        let rowIndex = findRow(combo: foodItem)

        if let emissions = Double(array[rowIndex][1]), !emissions.isNaN {

            let resultEmissions = emissions * (1/1000000)

            totalEmission += resultEmissions * Double(cals)

        }

    }



    func updateTotalWater(foodItem: String, array: [[String]]) {

        let cals = foodCals(messy: foodItem)

        let rowIndex = findRow(combo: foodItem)

        if let waterUse = Double(array[rowIndex][17]), !waterUse.isNaN {

            let resultWater = waterUse * (1/1000000)

            totalWater += resultWater * Double(cals)

        }

    }



    func customView1(i: Int) -> some View {



            VStack {



                HStack {



                    VStack {



                        Text("Emissions:")

                            .foregroundColor(.black)

                            .bold()

                            .font(.system(size: 15))



                        Text(String(meals[i + 5]) + " [kg CO₂e]")

                            .foregroundColor(.black)

                            .font(.system(size: 13))

                    }



                    .padding()



                    



                    VStack {



                        Text("Land Use:")

                            .foregroundColor(.black)

                            .bold()

                            .font(.system(size: 15))



                        Text(String(meals[i + 2]) + " [m²]")

                            .foregroundColor(.black)

                            .font(.system(size: 13))

                    }



                    .padding()



                }







                HStack {



                    VStack {



                        Text("Water Use:")

                            .foregroundColor(.black)

                            .bold()

                            .font(.system(size: 15))



                        Text(String(meals[i + 3]) + " [L]")

                            .foregroundColor(.black)

                            .font(.system(size: 13))

                    }



                    .padding()



                    



                    VStack {



                        Text("Eutrophication:")

                            .foregroundColor(.black)

                            .bold()

                            .font(.system(size: 15))



                        Text(String(meals[i + 4]) + " [gPO₄]")

                            .foregroundColor(.black)

                            .font(.system(size: 13))

                    }



                    .padding()



                }



                .padding()



            }



            .padding()



        }



    



    func DeleteMeal(index: Int){
        
 


        for i in stride(from: (findClosestIndex(of: "-", in: meals, from: index+1)!)-1, to: index-1, by: -1) {



            meals.remove(at: i)



        }

        saveMeals()

    }



    



    func findClosestIndex(of string: String, in list: [String], from index: Int) -> Int? {



        var closestIndex = meals.count







            for i in index..<list.count {



                if list[i] == string {



                    closestIndex = i



                    break



                }



            }



            return closestIndex



        



            



    }



    



    func DoesHaveNumInIt(string: String) -> Bool{



        for i in string{



            if(i.isNumber){



                return true



            }



        }



        return false



    }



    



    



    







    // Computed property to filter suggestions



    var filteredSuggestions: [String] {



        if text.isEmpty || chosen == true {



            return []



        } else {



            chosen = false



            var allSuggestions = [String]()



            if let array = readCSV(from: FileName) {



                for i in 0...(array.count-1){

                    if(i==212){

                        break

                    }

                    allSuggestions.append(array[i][20])

                    

                }



            }



            return allSuggestions.filter { $0.lowercased().contains(text.lowercased()) }



        }



    }
    
    var body: some View {
        NavigationView{
            ZStack{
                
                
                
                Color.gray.ignoresSafeArea()
                
                
                
                Image("baccy")
                
                    .resizable()
                
                    .scaledToFill()
                
                    .edgesIgnoringSafeArea(.all)
                
                
                
                VStack{
                    HStack(spacing: 30.0){
                       
                        let ran = Int.random(in: 0..<quotes.count)
                        Text("'"+quotes[ran]+"'")
                            .bold()
                            .frame(maxHeight: 150)
                            .frame(maxWidth: 300)
                            .cornerRadius(15)
                            .padding()
                            .border(Color.black)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            
                        
                        
                        
                    }
                    .padding(.bottom, 50.0)
                    HStack(spacing: 30.0){
                        VStack{
                            ZStack{
                                GIFView(gifName: "smoke3")
                                VStack{
                                    Text("Your Total Emissions\nVia Food")
                                        .multilineTextAlignment(.center)
                                        .padding(.bottom, 15)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(String(format: "%.7f", UserEmissionsTotal) + "\n [kg CO₂e]")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                        .frame(maxHeight: 350)
                        .frame(maxWidth: 150)
                        .background(.black)
                        .cornerRadius(15)
                        .shadow(radius: 20)
                        VStack{
                            NavigationLink(destination: BuildAMealView(meals: $meals, UserEmissionsTotal: $UserEmissionsTotal)){
                                
                                Text("Build A Meal")
                                
                                    .foregroundColor(.white)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .underline()
                            }
                            
                            Text("Saved Meals:")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 15))
                                    .padding(.top, 10.0)
                                    .padding(.bottom, 7.0)
                                    .foregroundColor(.white)
                                    .bold()
                                    
                                if(meals.count < 1){
                                
                                    Text("Add Meals!")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .bold()

                                        .frame(maxHeight: 150)
                                        .frame(minHeight: 150)
                                        .frame(maxWidth: 125)
                                        .frame(minWidth: 125)
                                        .padding(.horizontal, 5.0)
                                        .multilineTextAlignment(.center)
                                        .border(Color.black)
                                        

                                        

                                }else{
                                    
                                    ScrollView{
                                        
                                            
                                            ForEach(0..<meals.count, id: \.self) { i in
                                                
                                                
                                                
                                                if(meals[i] == "-"){
                                                    
                                                    
                                                    
                                                    HStack(spacing: 10.0){
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        Text(meals[i+1])
                                                            .font(.system(size: 10))
                                                        
                                                            .padding(6)
                                                            .foregroundColor(.white)
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                            .foregroundColor(Color.black)
                                                        
                                                        VStack{
                                                            
                                                            Button("-"){
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                UserEmissionsTotal -= Double(meals[i+5])!
                                                                saveUserEmissionsTotal()
                                                                
                                                                DeleteMeal(index: i)
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                            }
                                                            .font(.system(size: 23))
                                                            .padding(.top, 3)
                                                            
                                             
                                                            
                                                            .foregroundColor(.red)
                                                            
                                                            .bold()
                                                            
                                                            
                                                            
                                                            
                                                            NavigationLink(destination: Mealview(meals: $meals, MealTracker: $MealTracker)){
                                                                
                                                                Text("+")
                                                                    
                                                                    .font(.system(size: 20))
                                                                    .foregroundColor(.blue)
                                                                    .bold()
                                                                
                                                                
                                                                
                                                            }
                                                            .padding(.bottom, 4)
                                                            .simultaneousGesture(TapGesture().onEnded{
                                                                MealTracker = i
                                                            })
                                                            
                                                            
                                                            
                                                        }
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                    
                                  
                                                    
                                                    .frame(minWidth: 125.0)
                                                    
                                                    
                                                    
                                                    .frame(minHeight: 30.0)
                                                    
                                                    
                                                    
                                                    .frame(maxWidth: 125)
                                                    
                                                    
                                                    
                                                    .frame(maxHeight: 50.0)
                                                    
                                                    
                                                    
                                                    .background(Color.white.opacity(0.3))
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    .cornerRadius(5)
                                                    
                                                    
                                                    
                                                    .padding()
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                            
                                            
                                    
                                    }
                                    
                                        .frame(maxHeight: 150)
                                        .frame(minHeight: 150)
                                        .frame(maxWidth: 125)
                                        .frame(minWidth: 125)
                                        .padding(.horizontal, 5.0)
                                        .border(Color.white)
                                    
                                }
                                
                                
                                
                            }
                        .frame(maxHeight: 350)
                        .frame(maxWidth: 150)
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 20)
                    
                }
            }
        }
    }
}
}
