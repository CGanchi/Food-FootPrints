//
//  Info View.swift
//  FoodEmissions
//
//  Created by Camron Ganchi  on 9/9/24.
//
import SwiftUI
import Foundation

struct Infoview: View {
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



    @State private var MealTracker = -100



    @State private var CalsVSNon = 0



    @State private var FileName = "food-footprints"

    

    @State private var itemButt = 0

    

    @State private var BTimes: [String] = UserDefaults.standard.array(forKey: "BTimes") as? [String] ?? []

    

    @State private var podium = 0

    

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

                        

                        VStack{

                            ScrollView{

                                VStack(alignment: .leading){

                                    VStack(alignment: .leading, spacing: 10) {

                                        

                                        Button(action: {

                                            

                                            withAnimation {

                                                

                                                isRSVisible.toggle()

                                                

                                            }

                                            

                                        }) {

                                            

                                            Text("Reputable Source")

                                                .padding(8)

                                                .font(.system(size: 15))

                                            

                                                .background(Color.white.opacity(0.89))

                                            

                                                .foregroundColor(.black)

                                            

                                                .cornerRadius(9)

                                            

                                            

                                        }

                                        

                                        

                                        

                                        if isRSVisible {

                                            

                                            Text("Our World in Data is a well-regarded online publication that focuses on using data and research to address large global challenges. It collaborates with renowned academic institutions, including the University of Oxford, ensuring the credibility and reliability of the data it presents.")

                                            
                                                .font(.system(size: 11))
                                                .padding()
                                                
                                            

                                                .background(Color.white.opacity(0.4))

                                                .foregroundColor(.black)

                                                .cornerRadius(10)

                                            

                                                .transition(.opacity)

                                            

                                        }

                                        

                                    }

                                    

                                    .padding()

                                    

                                    VStack(alignment: .leading, spacing: 10) {

                                        

                                        Button(action: {

                                            

                                            withAnimation {

                                                

                                                isCDCVisible.toggle()

                                                

                                            }

                                            

                                        }) {

                                            

                                            Text("Comprehensive Data Collection")

                                            

                                                .padding(8)

                                                .font(.system(size: 15))

                                            

                                                .background(Color.white.opacity(0.89))

                                            

                                                .foregroundColor(.black)

                                            

                                                .cornerRadius(9)

                                            

                                            

                                            

                                        }

                                        

                                        

                                        

                                        if isCDCVisible {

                                            

                                            Text("The dataset includes extensive data on different food products and their environmental impacts, such as greenhouse gas emissions, land use, and water use. The data is collected from multiple reputable studies and reports, providing a holistic view of the environmental footprints associated with food production.")

                                            
                                                .font(.system(size: 11))
                                                .padding()

                                            

                                                .background(Color.white.opacity(0.4))

                                                .foregroundColor(.black)

                                                .cornerRadius(10)

                                            

                                                .transition(.opacity)

                                            

                                        }

                                        

                                    }

                                    

                                    .padding()

                                    

                                    VStack(alignment: .leading, spacing: 10) {

                                        

                                        Button(action: {

                                            

                                            withAnimation {

                                                

                                                isTMVisible.toggle()

                                                

                                            }

                                            

                                        }) {

                                            

                                            Text("Transparent Methodology")

                                            

                                            

                                                .font(.system(size: 15))

                                                .padding(8)

                                                .background(Color.white.opacity(0.89))

                                            

                                                .foregroundColor(.black)

                                            

                                                .cornerRadius(9)

                                            

                                            

                                            

                                        }

                                        

                                        

                                        

                                        if isTMVisible {

                                            

                                            Text("Our World in Data provides detailed explanations of the methodologies used to collect and analyze data. This transparency allows users to understand the sources, assumptions, and calculations behind the figures presented, ensuring confidence in the accuracy of the information.")

                                            
                                                .font(.system(size: 11))
                                                .padding()

                                            

                                                .background(Color.white.opacity(0.4))

                                                .foregroundColor(.black)

                                                .cornerRadius(10)

                                            

                                                .transition(.opacity)

                                            

                                        }

                                        

                                    }

                                    

                                    .padding()

                                    

                                    VStack(alignment: .leading, spacing: 10) {

                                        

                                        Button(action: {

                                            

                                            withAnimation {

                                                

                                                isPRSVisible.toggle()

                                                

                                            }

                                            

                                        }) {

                                            

                                            Text("Peer-Reviewed Sources")

                                            

                                                .padding(8)

                                                .font(.system(size: 15))

                                            

                                                .background(Color.white.opacity(0.89))

                                            

                                                .foregroundColor(.black)

                                            

                                                .cornerRadius(9)

                                            

                                            

                                            

                                        }

                                        

                                        

                                        

                                        if isPRSVisible {

                                            

                                            Text("The data provided by Our World in Data is often sourced from peer-reviewed scientific literature and reputable institutions, adding another layer of reliability. This rigorous vetting process ensures that the information is scientifically sound and widely accepted within the research community.")

                                            
                                                .font(.system(size: 11))
                                                .padding()

                                                .foregroundColor(.black)

                                                .background(Color.white.opacity(0.4))

                                            

                                                .cornerRadius(10)

                                            

                                                .transition(.opacity)

                                            

                                        }

                                        

                                    }

                                    

                                    .padding()

                                    

                                    VStack(alignment: .leading, spacing: 10) {

                                        

                                        Button(action: {

                                            

                                            withAnimation {

                                                

                                                isRUVisible.toggle()

                                                

                                            }

                                            

                                        }) {

                                            

                                            Text("Regular Updates")

                                            

                                                .padding(8)

                                                .font(.system(size: 15))

                                                .background(Color.white.opacity(0.89))

                                            

                                                .foregroundColor(.black)

                                            

                                                .cornerRadius(9)

                                            

                                            

                                            

                                        }

                                        

                                        

                                        

                                        if isRUVisible {

                                            

                                            Text("The platform is committed to keeping its data up-to-date with the latest research findings. This ongoing effort to incorporate new data and insights ensures that the information remains relevant and accurate over time.")

                                            
                                                .font(.system(size: 11))
                                                .padding()

                                                .foregroundColor(.black)

                                                .background(Color.white.opacity(0.4))

                                            

                                                .cornerRadius(10)

                                            

                                                .transition(.opacity)

                                            

                                        }

                                        Text("'gvhgjhgjhgjhgjhgjhgh                                            ")

                                            .foregroundColor(.clear)

                                    }

                                    

                                    .padding()

                                }

                            }

                            .frame(maxHeight: 400)
                            .frame(maxWidth: 350)

                            HStack(spacing: 25){


                                

                                Link("Cick to Access The DataSet", destination: URL(string: "https://ourworldindata.org/explorers/food-footprints?tab=table&facet=none&uniformYAxis=0&Commodity+or+Specific+Food+Product=Specific+food+products&Environmental+Impact=Eutrophication&Kilogram+%2F+Protein+%2F+Calories=Per+1000+kilocalories&By+stage+of+supply+chain=false&country=Beef+%28beef+herd%29~Beef+%28dairy+herd%29~Beefburger~Cheese~Lamb+%26+Mutton~Maize~Milk~Peas~Pig+Meat~Pizza~Poultry+Meat~Prawns+%28farmed%29~Wheat+%26+Rye")!)

                                

                                    .frame(width: 150.0, height: 50.0)

                                

                                    .background(Color.black)

                                

                                    .foregroundColor(.white)

                                

                                    .cornerRadius(19)

                                

                                    .padding()

                                

                            }

                            .padding(.top, 50)

                            }

                            .frame(maxWidth: 450)

                            .frame(minWidth: 450)

                        

                        



                    
                }
            }
        
    }
}
