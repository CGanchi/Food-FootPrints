//
//  Build a Meal View.swift
//  FoodEmissions
//
//  Created by Camron Ganchi  on 9/9/24.
//

import Foundation
import SwiftUI

struct BuildAMealView: View {
    @State private var userEmissions = 0
    
    @State private var userLand = 0
    
    @State private var userWater = 0
    
    @State private var userEutroph = 0
    
    @State private var text: String = ""


    @State private var suggestions = [String]()



    @State private var chosen = false



    @State private var buttonPushes = 0



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



    @Binding var meals: [String]

    @Binding var UserEmissionsTotal: Double

    @State private var text3: String  = ""



    @State private var SMealCounter = 0



    @State private var MealTracker = -100



    @State private var CalsVSNon = 0



    @State private var FileName = "food-footprints"

    

    @State private var itemButt = 0

    

    @State private var BTimes: [String] = UserDefaults.standard.array(forKey: "BTimes") as? [String] ?? []

    

    @State private var podium = 0
    
    @State private var quotes: [String] = ["The environment is mad important type."]
    
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



    



    func foodName(jumble: String) -> String{



        var food = ""



        if let firstNum = jumble.firstIndex(where: { $0.isNumber }) {



            food = String(jumble[..<firstNum])



        }



        return String(food)



    }



    



    func foodCals(messy: String) -> Double{



        var food = ""



        if let firstNum = messy.firstIndex(where: { $0.isNumber }) {



            food = String(messy[firstNum...])



        }



        return Double(food)!



    }



    



    func caloriesForFood(messyWord: String) -> Int{



        var food = ""



        if let firstNum = messyWord.firstIndex(where: { $0.isNumber }) {



            food = String(messyWord[firstNum...])



        }



        if let calories = Int(food){



            return calories



        }else{



            return 0



        }



    }

    

   



    



    func updateSuggestions(text: String) {

        DispatchQueue.main.async {

            if text.isEmpty {

                chosen = false

                suggestions = []

            } else {

                chosen = false

                if let array = readCSV(from: FileName) {

                    suggestions = array.dropLast().map { $0[20] }.filter { $0.lowercased().contains(text.lowercased()) }                }

            }

        }

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


    func saveUserEmissionsTotal(){
        UserDefaults.standard.set(UserEmissionsTotal, forKey: "UserEmissionsTotal")
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
        ZStack{
            
            
            
            Color.gray.ignoresSafeArea()
            
            
            
            Image("baccy")
            
                .resizable()
            
                .scaledToFill()
            
                .edgesIgnoringSafeArea(.all)
            
            
            
            VStack{
                if(buttonPushes>=0){



                    VStack{



                    if(buttonPushes<2 && buttonPushes>=0){



                        



                    Text("Build Your Meal")



                        .font(.largeTitle)

                        .foregroundColor(.black)

                        .padding(.top, 50)





                    }



                    VStack {



                        if(buttonPushes == 0){

                            ZStack {

                                if text.isEmpty {

                                    Text("What did you eat today?")

                                        .foregroundColor(.black) // Set the placeholder text color

                                        .padding(10) // Ensure the padding matches the TextField padding

                                        .frame(width: 275, height: 40, alignment: .leading) // Align it properly within the TextField

                                        .cornerRadius(19)

                                }



                                TextField("", text: $text)

                                    .padding(10)

                                    .frame(width: 275, height: 40)

                                    .background(Color.white.opacity(0.85))

                                    .foregroundColor(.black)

                                    .cornerRadius(19)

                                    .onChange(of: text) { newValue in

                                            updateSuggestions(text: newValue)

                                        }

                            }



                        



                            if !filteredSuggestions.isEmpty {

                                ZStack {

                                    Color.white.opacity(0.78) // Apply the background color with opacity

                                        .cornerRadius(10)

                                        .frame(maxWidth: 350, maxHeight: 200)



                                    List(filteredSuggestions, id: \.self) { suggestion in

                                        Text(suggestion)

                                            .onTapGesture {

                                                self.text = suggestion

                                                self.suggestions = []

                                                chosen = true

                                            }

                                    }

                                    .scrollContentBackground(.hidden) // Hide the default background of the List

                                    .frame(maxWidth: 350)

                                    .frame(minWidth: 350)

                                    .frame(maxHeight: 200)

                                    .frame(minHeight: 200)

                                    .background(Color.clear) // Ensure the List background is clear

                                    .cornerRadius(10)

                                    .colorScheme(.light)

                                }

                            }



                        }



                    }

                        



                    if(buttonPushes == 1){



                        ZStack {

                            if text2.isEmpty {

                                Text("How many calories of it?")

                                    .foregroundColor(.black) // Set the placeholder text color

                                    .padding(10) // Ensure the padding matches the TextField padding

                                    .frame(width: 275, height: 40, alignment: .leading) // Align it properly within the TextField

                                    .cornerRadius(19)

                            }



                            TextField("", text: $text2)

                                .padding(10)

                                .frame(width: 275, height: 40)

                                .background(Color.white.opacity(0.85))

                                .foregroundColor(.black)

                                .cornerRadius(19)

                        }

                            .padding()



                        



                        



                    }



                    if(buttonPushes == 2){



                        VStack{



                        Text("Anything Else?")



                                .font(.title)

                                .foregroundColor(.black)

                                .padding()



                        HStack{



                            Button("Yes"){



                                foodsList.append(text + text2)



                                text = ""



                                text2 = ""



                                buttonPushes = 0



                            }



                            .frame(width: 150.0, height: 50.0)



                                .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                                .foregroundColor(.white)



                                .cornerRadius(19)



                            Button("No"){



                                buttonPushes += 1



                                foodsList.append(text + text2)



                                text = ""



                                text2 = ""

                                

                                entireMealCounter += 1



                                updateAll()



                            }



                            .frame(width: 150.0, height: 50.0)



                            .background(Color(red: 0.5, green: 0.0, blue: 0.0))



                                .foregroundColor(.white)



                                .cornerRadius(19)



                        }



                            .padding()



                        }



                    }



                    if (buttonPushes == 3) {



                        VStack{

                            

                            if(entireMealCounter>0){

                                

                                VStack{

                                    

                                    Text("Entire Meal:")

                                        .font(.system(size: 20))

                                        .bold()

                                        .foregroundColor(.black)

                                        .onAppear(){

                                            

                                            

                                            

                                        }

                                    

                                    HStack{

                                        

                                        VStack{

                                            

                                            Text("Emissions:")

                                                .foregroundColor(.black)

                                                .bold()

                                            

                                            Text(String(format: "%.6f", (totalEmission)) + " [kg CO₂e]")

                                                .foregroundColor(.black)

                                        }

                                        

                                        .padding()

                                        

                                        VStack{

                                            

                                            Text("Land Use:")

                                                .foregroundColor(.black)

                                                .bold()

                                            

                                            Text(String(format: "%.6f", (totalLand)) + " [m²]")

                                                .foregroundColor(.black)

                                        }

                                        

                                        .padding()

                                        

                                    }

                                    

                                    

                                    

                                    

                                    

                                    HStack{

                                        

                                        VStack{

                                            

                                            Text("Water Use:")

                                                .foregroundColor(.black)

                                                .bold()

                                            

                                            Text(String(format: "%.6f", (totalWater)) + " [L]")

                                                .foregroundColor(.black)

                                        }

                                        

                                        .padding()

                                        

                                        VStack{

                                            

                                            Text("Eutrophication:")

                                                .foregroundColor(.black)

                                                .bold()

                                            

                                            Text(String(format: "%.6f", (totalEutroph)) + " [gPO₄]")

                                                .foregroundColor(.black)

                                        }

                                        

                                        .padding()

                                        

                                    }

                                    

                                    .padding()

                                    

                                }

                                

                                .padding()

                                

                            }

                            

                            Button("Details"){

                                itemButt += 1

                            }

                            

                            

                           

                            .bold()

                            .foregroundColor(.black)

                            

                            .cornerRadius(5)

                            

                            .padding()

                        }

                        .background(Color.white.opacity(0.5))

                        if(itemButt % 2 == 1){

                            List{

                                

                                if let array = readCSV(from: FileName) {

                                    

                                    ForEach(0..<foodsList.count, id: \.self) { i in

                                        

                                        

                                        

                                        HStack(alignment: .center, spacing: 40){

                                            

                                            let foodItem = foodsList[i] as? String ?? ""

                                            

                                            let foodNameText = foodName(jumble: foodItem)

                                            

                                            let cals = foodCals(messy: foodItem)

                                            

                                            let calsText = "(" + String(cals) + " cals)"

                                            

                                            let rowIndex = findRow(combo: foodItem)

                                            

                                            

                                            

                                            let e = Double(array[rowIndex][1])

                                            

                                            let l = Double(array[rowIndex][5])

                                            

                                            let w = Double(array[rowIndex][17])

                                            

                                            let eu = Double(array[rowIndex][9])

                                            

                                            

                                            

                                            

                                            

                                            let resultLand = l! * (1/1000000)

                                            

                                            let resultWater = w! * (1/1000000)

                                            

                                            let resultEutroph = eu! * (1/1000000)

                                            

                                            let resultEmission = e! * (1/1000000)

                                            

                                            

                                            

                                            

                                            

                                            

                                            

                                            VStack{

                                                

                                                Text(foodNameText)

                                                    .font(.system(size: 17))

                                                    .bold()

                                                

                                                Text(calsText)

                                                    .font(.system(size: 13))

                                                    .bold()

                                                

                                            }

                                            

                                            

                                            

                                            VStack(spacing: 15){

                                                

                                                VStack{

                                                    

                                                    Text("Emissions:")

                                                        .font(.system(size: 13))

                                                        .bold()

                                                    

                                                    Text(String(format: "%.6f", (resultEmission * cals)) + " [kg CO₂e]")

                                                        .font(.system(size: 13))

                                                }

                                                

                                                VStack{

                                                    

                                                    Text("Land Use:")

                                                        .font(.system(size: 13))

                                                        .bold()

                                                    

                                                    Text(String(format: "%.6f", (resultLand * cals)) + " [m²]")

                                                        .font(.system(size: 13))

                                                }

                                                

                                                VStack{

                                                    

                                                    Text("Water Use:")

                                                        .font(.system(size: 13))

                                                        .bold()

                                                    

                                                    Text(String(format: "%.6f", (resultWater * cals)) + " [L]")

                                                        .font(.system(size: 13))

                                                }

                                                

                                                VStack{

                                                    

                                                    Text("Eutrophication:")

                                                        .font(.system(size: 13))

                                                        .bold()

                                                    

                                                    Text(String(format: "%.6f", (resultEutroph * cals)) + " [gPO₄]")

                                                        .font(.system(size: 13))

                                                }

                                                

                                            }

                                            

                                            

                                            

                                        }

                                        

                                        

                                        

                                        .padding()

                                        

                                        

                                        

                                    }

                                    

                                    

                                    

                                }

                                

                            }

                            .scrollContentBackground(.hidden) // Hide the default background of the List

                            .frame(maxWidth: 370)

                            .frame(minWidth: 370)

                            .frame(maxHeight: 200)

                            .frame(minHeight: 200)

                            .background(Color.clear) // Ensure the List background is clear

                            .cornerRadius(10)

                            .colorScheme(.light)

                        }

                

                        





                            HStack (spacing: 20.0){



                            Button("Save Meal"){



                                buttonPushes += 1

                                itemButt = 0



                            }



                                .frame(width: 150.0, height: 50.0)



                                .background(Color.black)



                                .foregroundColor(.white)



                                .cornerRadius(19)



                                .padding()



                            }

                            .padding(.top, 50.0)

                        



                                        



                        



                        



                    }



                    



            



                    



                }



                if(buttonPushes == 4){



                    ZStack {

                        if text3.isEmpty {

                            Text("Name the meal")

                                .foregroundColor(.black) // Set the placeholder text color

                                .padding(10) // Ensure the padding matches the TextField padding

                                .frame(width: 275, height: 40, alignment: .leading) // Align it properly within the TextField

                                .cornerRadius(19)

                        }



                        TextField("", text: $text3)

                            .padding(10)

                            .frame(width: 275, height: 40)

                            .background(Color.white.opacity(0.85))

                            .foregroundColor(.black)

                            .cornerRadius(19)

                            

                    }

                    .padding()



                    Button("Submit"){



                        if(text3 != ""){



                        meals.append("-")



                        meals.append(text3)



                        meals.append(String(format: "%.7f", (totalLand)))



                        meals.append(String(format: "%.7f", (totalWater)))



                        meals.append(String(format: "%.7f", (totalEutroph)))



                        meals.append(String(format: "%.7f", (totalEmission)))
                        
                            UserEmissionsTotal += (round(totalEmission * 10000000) / 10000000)
                            
                        saveUserEmissionsTotal()
                        
                        saveMeals()

                        for i in 0..<foodsList.count{



                            let foood = foodsList[i] as? String ?? ""



                            meals.append(foodName(jumble: foood))



                            meals.append(String(foodCals(messy: foood)))

                            

                            saveMeals()

                        }



                        text = ""



                        suggestions = [String]()



                        chosen = false



                        buttonPushes = 5



                        text2 = ""



                        foodsList = []



                        numFoods = 0



                        totalEmission = 0.0



                        totalWater = 0.0



                        totalLand = 0.0



                        totalEutroph = 0.0



                        entireMealCounter = 0



                        text3 = ""



                        SMealCounter = 1



                        }







                    }



                        .frame(width: 150.0, height: 50.0)



                        .background(Color.black)



                        .foregroundColor(.white)



                        .cornerRadius(19)



                    



                }
                    
                    if(buttonPushes == 5){
                        Text("Meal Saved!")
                            .font(.system(size: 32))
                            .bold()
                            .foregroundColor(Color.black)
                            .padding()
                        Button("Build Another Meal"){
                            buttonPushes = 0
                        }
                        .font(.system(size: 16))
                        
                    }



                if(buttonPushes < 3 && numFoods > 0){



                    Text(String(numFoods) + " Items")



                        .multilineTextAlignment(.center)



                        .frame(width: 75.0, height: 25.0)



                        .background(Color.black)



                        .foregroundColor(.white)



                        .cornerRadius(19)



                        .padding(.top, 200.0)



                }else if(numFoods == 0 && buttonPushes < 2){



                    Text(" ")



                        .frame(width: 150.0, height: 50.0)



                        .cornerRadius(19)



                        .padding(.top, 200.0)



                }



                if(buttonPushes<2 && buttonPushes>=0){



                    HStack{



                Button("Submit") {



                    if(buttonPushes == 0){



                    if let array = readCSV(from: FileName) {



                        for i in 0..<array.count-1{



                            if(text == array[i][20] && text != ""){



                                buttonPushes += 1



                                print(text)



                                print(buttonPushes)



                                



                            }



                        }



                    }



                    }



                    if(buttonPushes == 1 && (!text2.isEmpty && text2.allSatisfy { $0.isNumber })){



                        buttonPushes += 1



                        numFoods += 1



                    }



                }



                .frame(width: 150.0, height: 50.0)



                .background(Color.black)



                .foregroundColor(.white)



                .cornerRadius(19)



                



                    }

                       



                }



                }
            }
        }
    }
}
