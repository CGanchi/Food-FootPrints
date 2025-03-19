//
//  Best times view.swift
//  FoodEmissions
//
//  Created by Camron Ganchi  on 9/7/24.
//

import SwiftUI



import Foundation

struct BestTimesview: View {
    @Binding var BTimes: [String]
    var body: some View {
        ZStack{
            
            
            
            Color.gray.ignoresSafeArea()
            
            
            
            Image("baccy")
            
                .resizable()
            
                .scaledToFill()
            
                .edgesIgnoringSafeArea(.all)
            
            
            
            VStack{
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


            }
            }
        }
    }

