//
//  MealView.swift
//  FoodEmissions
//
//  Created by Camron Ganchi  on 9/11/24.
//

import Foundation
import SwiftUI

struct Mealview: View {
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
    
    
    
    @Binding var meals: [String]
    
    
    
    @State private var text3: String  = ""
    
    
    
    @State private var SMealCounter = 0
    
    
    
    @Binding var MealTracker: Int
    
    
    
    @State private var CalsVSNon = 0
    
    
    
    @State private var FileName = "food-footprints"
    
    
    
    @State private var itemButt = 0
    
    
    
    @State private var BTimes: [String] = UserDefaults.standard.array(forKey: "BTimes") as? [String] ?? []
    
    
    
    @State private var podium = 0
    
    
    @State private var quotes: [String] = ["The environment is mad important type.", "The Earth is what we all have in common."]
    
    
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
        ZStack{
            
            
            
            Color.gray.ignoresSafeArea()
            
            
            
            Image("baccy")
            
                .resizable()
            
                .scaledToFill()
            
                .edgesIgnoringSafeArea(.all)
            
            
            
            VStack{
                if(MealTracker>(-1) && MealTracker<meals.count){
                    VStack{
                        
                        Text(meals[MealTracker+1])
                        
                        
                        
                            .font(.system(size: 24))
                        
                            .foregroundColor(.black)
                        
                            .bold()
                        
                        
                        
                        customView1(i: MealTracker)
                        
                        ScrollView{
                            
                            ForEach((MealTracker+6)..<(findClosestIndex(of: "-", in: meals, from: (MealTracker+6))!), id: \.self) { i in
                                
                                
                                
                                if(DoesHaveNumInIt(string: meals[i])){
                                    
                                    
                                    
                                    Text(meals[i] + " cals")
                                    
                                        .foregroundColor(.black)
                                    
                                    
                                    
                                }
                                
                                
                                
                                else{
                                    
                                    
                                    
                                    Text(meals[i] + ":")
                                    
                                        .foregroundColor(.black)
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        .frame(minHeight: 75)
                        
                        .frame(maxHeight: 75)
                        
                        
                        
                    }
                    
                    .padding()
                    
                    .background(Color.white.opacity(0.5))
                    
                    .frame(maxWidth: 375)
                    
                    .frame(minWidth: 375)
                    
                    
                    
                    .cornerRadius(10)
                    
                    
                    
                    HStack{
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }
            }
            
        }
    }
}
