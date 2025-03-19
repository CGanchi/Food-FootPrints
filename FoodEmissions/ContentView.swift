import SwiftUI



import Foundation



struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var str = " worked!"
    var body: some View {
        TabView(selection: $selectedTab) {
            Gameview()
                .tabItem {
                    Label("Game", systemImage: selectedTab == 1 ? "gamecontroller.fill" : "gamecontroller")
                }
                .tag(1)
            
            Homeview()
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            Infoview()
                .tabItem {
                    Label("Info", systemImage: selectedTab == 2 ? "info.circle.fill" : "info.circle")
                }
                .tag(2)
        }
        .tabViewStyle(DefaultTabViewStyle())
        .accentColor(.blue)
        
    }
}

/*
struct ContentView: View {



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



            if(buttonPushes == -2 && dataCounter == 0 && fAndCCounter == 0 && HighOrLow == 0 && SMealCounter == 0){



                Button("English"){



                    buttonPushes += 1



                    FileName = "food-footprints"



                }



                    .frame(width: 200.0, height: 50.0)



                    .background(Color.mint)



                    .foregroundColor(.white)



                    .cornerRadius(19)



                Button("Spanish"){



                    buttonPushes += 1



                    FileName = "food-footprints-spanish"



                }



                    .frame(width: 200.0, height: 50.0)



                    .background(Color.mint)



                    .foregroundColor(.white)



                    .cornerRadius(19)



                Button("French"){



                    buttonPushes += 1



                    FileName = "food-footprints-french"



                }



                    .frame(width: 200.0, height: 50.0)



                    .background(Color.mint)



                    .foregroundColor(.white)



                    .cornerRadius(19)



            }



            if(buttonPushes == -1 && dataCounter == 0 && fAndCCounter == 0 && HighOrLow == 0 && SMealCounter == 0){



                VStack{



                Text("Food FootPrints")

                    .foregroundColor(Color.black)

                    .font(.largeTitle)



                    .bold()



                    .padding(.bottom, 100.0)



                Button("Build a Meal"){



                    buttonPushes += 1



                }



                    .frame(width: 200.0, height: 50.0)



                    .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                    .foregroundColor(.white)



                    .cornerRadius(19)



                Button("Saved"){



                    SMealCounter += 1



                }



                    .frame(width: 100.0, height: 30.0)



                    .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                    .foregroundColor(.white)



                    .cornerRadius(19)



                    .padding(.bottom, 20.0)



                    .font(.system(size: 14))



                Button("More or Less"){



                        HighOrLow += 1



                }



                    .frame(width: 200.0, height: 50.0)



                    .background(Color.black)



                    .foregroundColor(.white)



                    .cornerRadius(19)



                    .padding()



                Button("Source of Data"){



                    dataCounter += 1

                    print(BTimes)



                }



                    .frame(width: 200.0, height: 50.0)



                    .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                    .foregroundColor(.white)



                    .cornerRadius(19)



                    .padding()



                Button("Food and the Climate"){



                    fAndCCounter += 1



                }



                    .frame(width: 250.0, height: 50.0)



                    .background(Color.black)

                                



                    .foregroundColor(.white)



                    .cornerRadius(19)



                    .padding()



                   



                }



            }



            if(SMealCounter>0){



            if(SMealCounter == 1){

                if(meals.count < 1){

                    Text("Add Meals!")

                        

                        .font(.system(size: 20))

                    

                        .bold()



                        .foregroundColor(.black)



                        

                }else{

                    ScrollView{

                        if(meals.count < 1){

                            Text("Add Meals!")

                            

                                .font(.system(size: 20))

                            

                                .bold()

                            

                                .foregroundColor(.black)

                            

                            

                        }

                        

                        ForEach(0..<meals.count, id: \.self) { i in

                            

                            if(meals[i] == "-"){

                                

                                HStack(spacing: 100.0){

                                    

                                    

                                    Text(meals[i+1])

                                        .padding(15)

                                        

                                        

                                        

                                        

                                    

                                        .foregroundColor(Color.black)

                                    VStack{

                                        Button("Delete"){

                                            

                                            

                                            

                                            DeleteMeal(index: i)

                                            

                                            

                                            

                                            

                                            

                                            

                                            

                                        }

                                        .padding(.top, 14)

                                        .padding(.bottom, 14)

                                        .foregroundColor(.red)

                                        .bold()

                                        

                                        Button("Details"){

                                            

                                            

                                            

                                            SMealCounter += 1

                                            

                                            MealTracker = i

                                            

                                            

                                            

                                            

                                            

                                            

                                        }

                                        .padding(.bottom, 14)

                                        .foregroundColor(.blue)

                                        .bold()

                                    }

                                    

                                    

                                }

                                

                                

                                .frame(minWidth: 350.0)

                                

                                .frame(minHeight: 25.0)

                                

                                .frame(maxWidth: 350)

                                

                                .frame(maxHeight: 150.0)

                                

                                .background(Color.white.opacity(0.8))

                                

                            

                                .cornerRadius(5)

                                

                                .padding()

                                

                            }

                            

                        }

                        

                    }

                    

                    .frame(maxHeight: 500)

                }



                Button("Menu"){



                    SMealCounter = 0



                }



                    .frame(width: 150.0, height: 50.0)



                    .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                    .foregroundColor(.white)



                    .cornerRadius(19)



                    .padding(.top, 35)



            }



                if(SMealCounter == 2){

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



                    Button("Back"){



                        SMealCounter = 1



                    }



                        .frame(width: 150.0, height: 50.0)



                        .background(Color.black)



                        .foregroundColor(.white)



                        .cornerRadius(19)



                        .padding(.top, 35)



                    Button("Menu"){



                        SMealCounter = 0



                    }



                        .frame(width: 150.0, height: 50.0)



                        .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                        .foregroundColor(.white)



                        .cornerRadius(19)



                        .padding(.top, 35)



                }



                



            }



                



            



        }

            if(HighOrLow == 3){

                

                Text("Best Times")

                    .font(.largeTitle)

                    .foregroundColor(.black)

                    .padding(.bottom, 45)

                if(BTimes.count == 0){

                    Text("You have yet\nto win!")

                        .font(.system(size: 20))

                        .multilineTextAlignment(.center)

                        .bold()



                        .foregroundColor(.black)

                }else{

                ScrollView{

                    if(BTimes.count == 1){

                        Text(BTimes[0])

                            .padding(8)

                        

                            .background(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                    }else if(BTimes.count == 2){

                        Text(BTimes[0])

                            .padding(8)

                        

                            .background(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                        Text(BTimes[1])

                            .padding(8)

                        

                            .background(Color(red: 192/255, green: 192/255, blue: 192/255).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                    }else if(BTimes.count == 3){

                        Text(BTimes[0])

                            .padding(8)

                        

                            .background(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                        Text(BTimes[1])

                            .padding(8)

                        

                            .background(Color(red: 192/255, green: 192/255, blue: 192/255).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                        Text(BTimes[2])

                            .padding(8)

                        

                            .background(Color(red: 205/255, green: 127/255, blue: 50/255).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                    }else{

                        Text(BTimes[0])

                            .padding(8)

                        

                            .background(Color(red: 1.0, green: 0.84, blue: 0.0).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                        Text(BTimes[1])

                            .padding(8)

                        

                            .background(Color(red: 192/255, green: 192/255, blue: 192/255).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                        Text(BTimes[2])

                            .padding(8)

                        

                            .background(Color(red: 205/255, green: 127/255, blue: 50/255).opacity(0.89))

                        

                            .foregroundColor(.black)

                        

                            .cornerRadius(5)

                        ForEach(4..<BTimes.count, id: \.self) { i in

                            Text(BTimes[i])

                                .padding(8)

                            

                                .background(Color.white.opacity(0.89))

                            

                                .foregroundColor(.black)

                            

                                .cornerRadius(5)

                            

                        }

                    }

                }

                .frame(maxHeight: 350)

                .frame(minHeight: 350)

            }

                HStack{

                    Button("Back"){

                        

                        HighOrLow = 1

                        podium = 0

                        

                        

                        

                    }

                    .frame(width: 150.0, height: 50.0)

                    .font(.system(size: 17))

                    .background(Color.black)

                    

                    .foregroundColor(.white)

                    

                    .cornerRadius(19)

                    .padding(.top, 25.0)

                    Button("Menu"){

                        

                        HighOrLow = 0

                        podium = 0

                        

                        

                        

                    }

                    .frame(width: 150.0, height: 50.0)

                    .font(.system(size: 17))

                    .background(Color(red: 0, green: 0.5, blue: 0))

                    

                    .foregroundColor(.white)

                    

                    .cornerRadius(19)

                    .padding(.top, 25.0)

                    

                }

                .padding(.top, 25.0)

            }

                



                if(dataCounter>0){

                    

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

                                            .font(.system(size: 21))

                                        

                                            .background(Color.white.opacity(0.89))

                                        

                                            .foregroundColor(.black)

                                        

                                            .cornerRadius(9)

                                        

                                        

                                    }

                                    

                                    

                                    

                                    if isRSVisible {

                                        

                                        Text("Our World in Data is a well-regarded online publication that focuses on using data and research to address large global challenges. It collaborates with renowned academic institutions, including the University of Oxford, ensuring the credibility and reliability of the data it presents.")

                                        

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

                                            .font(.system(size: 21))

                                        

                                            .background(Color.white.opacity(0.89))

                                        

                                            .foregroundColor(.black)

                                        

                                            .cornerRadius(9)

                                        

                                        

                                        

                                    }

                                    

                                    

                                    

                                    if isCDCVisible {

                                        

                                        Text("The dataset includes extensive data on different food products and their environmental impacts, such as greenhouse gas emissions, land use, and water use. The data is collected from multiple reputable studies and reports, providing a holistic view of the environmental footprints associated with food production.")

                                        

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

                                        

                                        

                                            .font(.system(size: 21))

                                            .padding(8)

                                            .background(Color.white.opacity(0.89))

                                        

                                            .foregroundColor(.black)

                                        

                                            .cornerRadius(9)

                                        

                                        

                                        

                                    }

                                    

                                    

                                    

                                    if isTMVisible {

                                        

                                        Text("Our World in Data provides detailed explanations of the methodologies used to collect and analyze data. This transparency allows users to understand the sources, assumptions, and calculations behind the figures presented, ensuring confidence in the accuracy of the information.")

                                        

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

                                            .font(.system(size: 21))

                                        

                                            .background(Color.white.opacity(0.89))

                                        

                                            .foregroundColor(.black)

                                        

                                            .cornerRadius(9)

                                        

                                        

                                        

                                    }

                                    

                                    

                                    

                                    if isPRSVisible {

                                        

                                        Text("The data provided by Our World in Data is often sourced from peer-reviewed scientific literature and reputable institutions, adding another layer of reliability. This rigorous vetting process ensures that the information is scientifically sound and widely accepted within the research community.")

                                        

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

                                            .font(.system(size: 21))

                                            .background(Color.white.opacity(0.89))

                                        

                                            .foregroundColor(.black)

                                        

                                            .cornerRadius(9)

                                        

                                        

                                        

                                    }

                                    

                                    

                                    

                                    if isRUVisible {

                                        

                                        Text("The platform is committed to keeping its data up-to-date with the latest research findings. This ongoing effort to incorporate new data and insights ensures that the information remains relevant and accurate over time.")

                                        

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

                        HStack(spacing: 25){

                            Button("Menu"){

                                

                                suggestions = [String]()

                                

                                chosen = false

                                

                                buttonPushes = -1

                                

                                foodsList = []

                                

                                numFoods = 0

                                

                                totalEmission = 0.0

                                

                                totalWater = 0.0

                                

                                totalLand = 0.0

                                

                                totalEutroph = 0.0

                                

                                entireMealCounter = 0

                                

                                dataCounter = 0

                                

                                fAndCCounter = 0

                                

                            }

                            

                            .frame(width: 150.0, height: 50.0)

                            

                            .background(Color(red: 0.0, green: 0.5, blue: 0.0))

                            

                            .foregroundColor(.white)

                            

                            .cornerRadius(19)

                            

                            Link("The DataSet", destination: URL(string: "https://ourworldindata.org/explorers/food-footprints?tab=table&facet=none&uniformYAxis=0&Commodity+or+Specific+Food+Product=Specific+food+products&Environmental+Impact=Eutrophication&Kilogram+%2F+Protein+%2F+Calories=Per+1000+kilocalories&By+stage+of+supply+chain=false&country=Beef+%28beef+herd%29~Beef+%28dairy+herd%29~Beefburger~Cheese~Lamb+%26+Mutton~Maize~Milk~Peas~Pig+Meat~Pizza~Poultry+Meat~Prawns+%28farmed%29~Wheat+%26+Rye")!)

                            

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



                if(fAndCCounter>0){



                    VStack{



                    Text("The Importance of Food")



                        .font(.title)

                        .foregroundColor(.black)

                        .bold()



                        .multilineTextAlignment(.center)



                        .padding(.bottom, 50.0)



                



                    ScrollView{



                    Text("Food and dietary choices have a profound impact on the environment, influencing greenhouse gas emissions, deforestation, water usage, and biodiversity. The choices we make regarding what we eat can either exacerbate environmental issues or contribute to their mitigation. Understanding these impacts is crucial for fostering sustainable practices and promoting a healthier planet.\n Agriculture is a significant contributor to global greenhouse gas emissions, with food production accounting for about 26% of these emissions. Livestock farming, in particular, plays a major role due to the methane produced by cattle. Methane is a potent greenhouse gas, and livestock alone contributes nearly 14.5% of global greenhouse gas emissions. The high emissions from livestock farming highlight the need for more sustainable dietary choices to reduce our carbon footprint.\nThe demand for agricultural land has also led to widespread deforestation, especially in tropical regions. Forests, which serve as vital carbon sinks, are being cleared to make way for crops and pastures. This deforestation not only releases stored carbon into the atmosphere but also results in the loss of habitats for countless species, contributing to a decline in biodiversity. The impact of agricultural expansion on forests underscores the importance of sustainable land management and the protection of natural habitats.\nWater usage is another critical aspect of the environmental impact of food production. Agriculture is the largest consumer of freshwater resources, with irrigation for crops and water for livestock requiring vast amounts of water. Water-intensive crops like rice and animal products such as beef have particularly high water footprints. For instance, producing 1 kilogram of beef requires approximately 15,000 liters of water. This excessive water use can lead to the depletion of rivers, lakes, and aquifers, highlighting the need for water-efficient agricultural practices and dietary choices that consider water sustainability.\nThe environmental impact of food production extends to biodiversity loss as well. Agricultural practices often lead to habitat destruction, pesticide use, and monoculture farming, all of which reduce biodiversity and the resilience of ecosystems. Sustainable farming practices, such as agroforestry and organic farming, can help preserve biodiversity by maintaining habitats and reducing chemical inputs. These practices are essential for protecting ecosystem services that support human life and well-being.\nFood waste is another significant environmental issue, with approximately one-third of all food produced globally going to waste. This waste not only squanders the resources used in food production but also generates greenhouse gases when organic waste decomposes in landfills. Reducing food waste is a critical step in lowering the environmental footprint of the food system. By making efforts to minimize food waste, individuals and communities can significantly reduce their environmental impact.\nDietary choices play a crucial role in shaping the environmental impact of food production. Shifting towards plant-based diets can substantially reduce this impact, as plant-based foods generally require fewer resources and produce fewer emissions compared to animal-based foods. Incorporating more sustainable seafood, local and seasonal produce, and reducing meat and dairy consumption can collectively lower the environmental footprint of diets. These changes in dietary habits not only benefit the environment but also promote health and well-being. \nOur food and dietary choices have far-reaching effects on the environment. By making more sustainable choices, such as reducing meat consumption, minimizing food waste, and supporting sustainable farming practices, individuals can contribute to mitigating climate change, conserving water, and preserving biodiversity. Understanding the importance and impact of our dietary choices is essential for fostering a sustainable future and ensuring the health of our planet for generations to come.")

                            .padding()

                            .foregroundColor(.black)

                            .background(Color.white.opacity(0.55))



                            .cornerRadius(10)

                            .frame(maxWidth: 377)

                            .frame(minWidth: 377)



                        



                    }



                    .frame(height: 400.0)



                    .padding()



                    Button("Menu"){



                        suggestions = [String]()



                        chosen = false



                        buttonPushes = -1



                        foodsList = []



                        numFoods = 0



                        totalEmission = 0.0



                        totalWater = 0.0



                        totalLand = 0.0



                        totalEutroph = 0.0



                        entireMealCounter = 0



                        dataCounter = 0



                        fAndCCounter = 0



                    }



                    .frame(width: 150.0, height: 50.0)



                    .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                    .foregroundColor(.white)



                    .cornerRadius(19)



                    .padding(.top, 50.0)



                    }



                











                }



            if(buttonPushes>=0){



                VStack{



                if(buttonPushes<2 && buttonPushes>=0){



                    



                Text("Build Your Meal")



                    .font(.largeTitle)

                    .foregroundColor(.black)

                    .padding(.top, 100)





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



                        Button("Menu"){



                            suggestions = [String]()



                            chosen = false



                            buttonPushes = -1



                            foodsList = []



                            numFoods = 0



                            totalEmission = 0.0



                            totalWater = 0.0



                            totalLand = 0.0



                            totalEutroph = 0.0



                            entireMealCounter = 0



                            dataCounter = 0



                            fAndCCounter = 0

                            

                            itemButt = 0



                        }



                            .frame(width: 150.0, height: 50.0)



                            .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                            .foregroundColor(.white)



                            .cornerRadius(19)



                            .padding()



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



                    buttonPushes = -1



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



                    Button("Menu"){



                        suggestions = [String]()



                        chosen = false



                        buttonPushes = -1



                        foodsList = []



                        numFoods = 0



                        totalEmission = 0.0



                        totalWater = 0.0



                        totalLand = 0.0



                        totalEutroph = 0.0



                        entireMealCounter = 0



                        dataCounter = 0



                        fAndCCounter = 0



                        text = ""



                        text2 = ""



                    }



                    .frame(width: 150.0, height: 50.0)



                    .background(Color(red: 0.0, green: 0.5, blue: 0.0))



                    .foregroundColor(.white)



                    .cornerRadius(19)



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



}
*/






