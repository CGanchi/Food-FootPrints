//
//  Game View.swift
//  FoodEmissions
//
//  Created by Camron Ganchi  on 9/9/24.
//
import SwiftUI
import Foundation

struct Gameview: View {
    @State private var rand1 = Int.random(in: 1..<213)
    @State private var rand2 = Int.random(in: 1..<213)
    @State private var rand1Res = 0.0
    @State private var rand2Res = 0.0
    @State private var HighOrLow = 1
    @State private var HOLScore = 0
    @State private var lose = false
    @State private var win = false
    @State private var timer: Timer?
    @State private var counter: Int = 0
    @State private var replacement: Int = 0
    @State private var isTimerRunning: Bool = false
    @State private var FileName = "food-footprints"
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



    @State private var meals: [String] = UserDefaults.standard.array(forKey: "meals") as? [String] ?? []



    @State private var text3: String  = ""



    @State private var SMealCounter = 0



    @State private var MealTracker = -100



    @State private var CalsVSNon = 0


    

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

    




    



    func updateRandResesFirst(){



        rand1 = Int.random(in: 2..<213)



        rand2 = Int.random(in: 2..<213)



        if let array = readCSV(from: FileName) {



            rand1Res = Double(array[rand1][1])! * (1/1000000)



            rand2Res = Double(array[rand2][1])! * (1/1000000)



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
    var body: some View {
        NavigationView{
            ZStack{
                
                
                
                Color.gray.ignoresSafeArea()
                
                
                
                Image("baccy")
                
                    .resizable()
                
                    .scaledToFill()
                
                    .edgesIgnoringSafeArea(.all)
                
                
                
                VStack{
                    
                    
                    if(HighOrLow > 0 && lose == false && win == false){
                        
                        if(HighOrLow == 1 || HighOrLow == 2){
                            
                            Text("More or Less")
                            
                            
                            
                                .font(.title)
                            
                                .foregroundColor(.black)
                            
                                .bold()
                            
                            
                            
                            Text("(15 points to win!)")
                            
                                .foregroundColor(.black)
                            
                                .padding(.bottom, 25.0)
                            
                        }
                        
                        if(HighOrLow == 1){
                            
                            
                            
                            Button("Start"){
                                
                                
                                
                                HighOrLow = 2
                                
                                
                                
                                isTimerRunning = true
                                
                                
                                
                                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                                    
                                    
                                    
                                    counter += 1
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                            .frame(width: 150.0, height: 50.0)
                            
                            
                            
                            .background(Color(red: 0.0, green: 0.5, blue: 0.0))
                            
                            
                            
                            .foregroundColor(.white)
                            
                            
                            
                            .cornerRadius(19)
                            
                            
                            NavigationLink(destination: BestTimesview(BTimes: $BTimes)){
                                
                                Text("Best Times")
                                
                                    .frame(width: 100.0, height: 40.0)
                                
                                    .font(.system(size: 14))
                                
                                    .background(Color.black)
                                
                                
                                
                                    .foregroundColor(.white)
                                
                                
                                    .cornerRadius(19)
                                
                                
                                
                            }
                            .padding(.top, 25.0)
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        if(HighOrLow == 2){
                            
                            
                            
                            Text("\(counter)")
                            
                            
                            
                                .padding(.bottom, 50.0)
                            
                                .foregroundColor(.black)
                            
                                .frame(maxWidth: .infinity)
                            
                            
                            
                                .multilineTextAlignment(.center)
                            
                            
                            
                            
                            
                            
                            
                            VStack{
                                
                                HStack(spacing: 50.0){
                                    
                                    
                                    
                                    if let array = readCSV(from: FileName) {
                                        
                                        
                                        
                                        VStack(alignment: .center){
                                            
                                            
                                            
                                            Text(String(array[rand1][20]))
                                            
                                                .foregroundColor(.black)
                                            
                                            
                                            
                                                .bold()
                                            
                                            
                                            
                                                .font(.system(size: 17.5))
                                            
                                                .padding(.bottom, 15.0)
                                            
                                            
                                            
                                                .multilineTextAlignment(.center)
                                            
                                            
                                            
                                            Text("has")
                                            
                                                .foregroundColor(.black)
                                            
                                                .font(.system(size: 15))
                                            
                                            Text(String(format: "%.8f", (rand1Res)))
                                            
                                                .foregroundColor(.black)
                                            
                                                .font(.system(size: 15))
                                            
                                            Text("emissions")
                                            
                                                .font(.system(size: 15))
                                            
                                                .foregroundColor(.black)
                                            
                                                .multilineTextAlignment(.center)
                                            
                                            Text("per calorie")
                                            
                                                .font(.system(size: 15))
                                            
                                                .foregroundColor(.black)
                                            
                                                .multilineTextAlignment(.center)
                                            
                                        }
                                        
                                        
                                        
                                        VStack(alignment: .center){
                                            
                                            
                                            
                                            Text(String(array[rand2][20]))
                                            
                                                .foregroundColor(.black)
                                            
                                                .bold()
                                            
                                            
                                            
                                                .font(.system(size: 17.5))
                                            
                                            
                                            
                                                .multilineTextAlignment(.center)
                                            
                                            
                                            
                                            Text("has")
                                            
                                                .foregroundColor(.black)
                                            
                                                .font(.system(size: 15))
                                            
                                            Button("More"){
                                                
                                                
                                                
                                                if(rand2Res>=rand1Res){
                                                    
                                                    
                                                    
                                                    HOLScore += 1
                                                    
                                                    
                                                    
                                                    if(HOLScore == 15){
                                                        
                                                        
                                                        
                                                        win = true
                                                        
                                                        
                                                        
                                                        isTimerRunning = false
                                                        
                                                        
                                                        
                                                        timer?.invalidate()
                                                        
                                                        
                                                        
                                                        timer = nil
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    rand1 = rand2
                                                    
                                                    
                                                    
                                                    rand1Res = rand2Res
                                                    
                                                    
                                                    
                                                    rand2 = Int.random(in: 1..<213)
                                                    
                                                    
                                                    
                                                    rand2Res = Double(array[rand2][1])! * (1/1000000)
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                else{
                                                    
                                                    
                                                    
                                                    lose = true
                                                    
                                                    
                                                    
                                                    isTimerRunning = false
                                                    
                                                    
                                                    
                                                    timer?.invalidate()
                                                    
                                                    
                                                    
                                                    timer = nil
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                            
                                            .frame(width: 125, height: 60.0)
                                            
                                            
                                            
                                            .background(Color.black)
                                            
                                            
                                            
                                            .foregroundColor(.white)
                                            
                                            
                                            
                                            .cornerRadius(5)
                                            
                                            
                                            
                                            
                                            
                                            Button("Less"){
                                                
                                                
                                                
                                                if(rand2Res<=rand1Res){
                                                    
                                                    
                                                    
                                                    HOLScore += 1
                                                    
                                                    
                                                    
                                                    if(HOLScore == 15){
                                                        
                                                        
                                                        
                                                        win = true
                                                        
                                                        
                                                        
                                                        isTimerRunning = false
                                                        
                                                        
                                                        
                                                        timer?.invalidate()
                                                        
                                                        
                                                        
                                                        timer = nil
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    rand1 = rand2
                                                    
                                                    
                                                    
                                                    rand1Res = rand2Res
                                                    
                                                    
                                                    
                                                    rand2 = Int.random(in: 1..<213)
                                                    
                                                    
                                                    
                                                    rand2Res = Double(array[rand2][1])! * (1/1000000)
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                else{
                                                    
                                                    
                                                    
                                                    lose = true
                                                    
                                                    
                                                    
                                                    isTimerRunning = false
                                                    
                                                    
                                                    
                                                    timer?.invalidate()
                                                    
                                                    
                                                    
                                                    timer = nil
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                            
                                            .frame(width: 125, height: 60.0)
                                            
                                            
                                            
                                            .background(Color.black)
                                            
                                            
                                            
                                            .foregroundColor(.white)
                                            
                                            
                                            
                                            .cornerRadius(5)
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                                
                                .padding(.bottom, 30.0)
                                
                                
                                
                                .onAppear(){
                                    
                                    
                                    
                                    updateRandResesFirst()
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                                
                                
                                
                                Text("Score: " + String(HOLScore))
                                
                                    .foregroundColor(.black)
                                
                                    .bold()
                                
                            }
                            
                            .padding()
                            
                            .background(Color.white.opacity(0.5))
                            
                            .frame(maxWidth: 375)
                            
                            .frame(minWidth: 375)
                            
                            .cornerRadius(10)
                            
                            
                            
                            Button("Quit"){
                                
                                
                                
                                text = ""
                                
                                
                                
                                suggestions = [String]()
                                
                                
                                
                                chosen = false
                                
                                
                                
                                buttonPushes = -1
                                
                                
                                
                                text2 = ""
                                
                                
                                
                                foodsList = []
                                
                                
                                
                                numFoods = 0
                                
                                
                                
                                totalEmission = 0.0
                                
                                
                                
                                totalWater = 0.0
                                
                                
                                
                                totalLand = 0.0
                                
                                
                                
                                totalEutroph = 0.0
                                
                                
                                
                                entireMealCounter = 0
                                
                                
                                
                                dataCounter = 0
                                
                                
                                
                                fAndCCounter = 0
                                
                                
                                
                                isCDCVisible = false
                                
                                
                                
                                isRSVisible = false
                                
                                
                                
                                isTMVisible = false
                                
                                
                                
                                isPRSVisible = false
                                
                                
                                
                                isRUVisible = false
                                
                                
                                
                                HighOrLow = 1
                                
                                
                                
                                HOLScore = 0
                                
                                
                                
                                lose = false
                                
                                
                                
                                firstHL = true
                                
                                
                                
                                isTimerRunning = false
                                
                                
                                
                                timer?.invalidate()
                                
                                
                                
                                timer = nil
                                
                                
                                
                                counter = 0
                                
                                
                                
                            }
                            
                            
                            
                            .frame(width: 150.0, height: 50.0)
                            
                            
                            
                            .background(Color(red: 0.0, green: 0.5, blue: 0.0))
                            
                            
                            
                            .foregroundColor(.white)
                            
                            
                            
                            .cornerRadius(19)
                            
                            
                            
                            .padding(.top, 75.0)
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    if(win == true){
                        
                        
                        
                        Text("You Win!")
                        
                        
                        
                            .bold()
                        
                            .foregroundColor(.black)
                        
                            .font(.system(size: 22))
                            .onAppear(){
                                
                                if(counter > 0){
                                    BTimes.append("\(counter) seconds: " + getCurrentDateTime())
                                    replacement = counter
                                }
                                saveTimes()

                                counter = 0
                                
                                BTimes.sort { (first, second) -> Bool in
                                    
                                    // Extract the numbers from the strings
                                    
                                    let firstNumber = Int(first.split(separator: " ")[0]) ?? 0
                                    
                                    let secondNumber = Int(second.split(separator: " ")[0]) ?? 0
                                    
                                    
                                    
                                    // Sort in descending order
                                    
                                    return firstNumber < secondNumber
                                    
                                }
                                
                                
                                
                                saveTimes()
                                
                                
                                
                            }
                        
                        
                        
                        Text("It took you " + String(replacement) + " seconds")
                        
                            .foregroundColor(.black)
                        
                            .padding()
                            
                        
                        
                        
                        HStack(spacing: 50.0){
                            
                            
                            
                            Button("Play Again"){
                                
                                
                                
                                HOLScore = 0
                                
                                
                                
                                HighOrLow = 1
                                
                                
                                
                                lose = false
                                
                                
                                
                                win = false
                                
                                
                                
                                counter = 0
                                
                                
                                
                            }
                            
                            
                            
                            .frame(width: 150.0, height: 50.0)
                            
                            
                            
                            .background(Color(red: 0.0, green: 0.5, blue: 0.0))
                            
                            
                            
                            .foregroundColor(.white)
                            
                            
                            
                            .cornerRadius(19)
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        .padding(.top, 25.0)
                        
                        NavigationLink(destination: BestTimesview(BTimes: $BTimes)){
                            
                            Text("Best Times")
                            
                                .frame(width: 100.0, height: 40.0)
                            
                                .font(.system(size: 14))
                            
                                .background(Color.black)
                            
                            
                            
                                .foregroundColor(.white)
                            
                            
                                .cornerRadius(19)
                            
                            
                            
                        }
                        .padding(.top, 25.0)
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    if(lose == true){
                        
                        
                        
                        Text("You Lose!")
                        
                        
                        
                            .bold()
                        
                            .foregroundColor(.black)
                        
                            .font(.system(size: 22))
                        
                        
                        
                        
                        
                        HStack(spacing: 50.0){
                            
                            
                            
                            Button("Try Again"){
                                
                                
                                
                                HOLScore = 0
                                
                                
                                
                                HighOrLow = 1
                                
                                
                                
                                lose = false
                                
                                
                                
                                counter = 0
                                
                                
                                
                            }
                            
                            
                            
                            .frame(width: 150.0, height: 50.0)
                            
                            
                            
                            .background(Color.red)
                            
                            
                            
                            .foregroundColor(.white)
                            
                            
                            
                            .cornerRadius(19)
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        .padding(.top, 25.0)
                        
                        
                        
                    }
                }
            }
        }
    }
}
