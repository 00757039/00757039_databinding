//
//  SecondPage.swift
//  00757039_databinding
//
//  Created by User04 on 2020/11/4.
//

import SwiftUI

struct SecondPage: View {
    @State var mood = Int.random(in: 1..<10)
    @State var health = Int.random(in: 1..<10)
    @Binding var showSecondPage : Bool
    @Binding var gender : String
    @Binding var selectname : String
    @Binding var name : String
    @Binding var birthday: Date
    @Binding var red: Double
    @Binding var green: Double
    @Binding var blue: Double
    let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter
        }()
    var body: some View {
        VStack{
            Image(selectname).resizable()
                .scaledToFill()
                .frame(width:300, height:300)
                .clipped()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 5))
            
            Form{
                Text("名字 : " + name).bold()
                Text("生日 : " + dateFormatter.string(from:     birthday)).bold()
                Text("性別 : " + gender).bold()
                VStack{
                    Text("不知道牠的心情好不好？")
                    Text("心情指數 : \(mood)")
                    Stepper(value: $mood, in: 0...10) {
                                        if mood <= 3 {
                                            Text("心情 : Bad")
                                        }
                                        else if (mood > 3   && mood <= 7) {
                                            Text("心情 :  Normal")
                                        }
                                        else {
                                            Text("心情 : Good")
                                        }
                        
                                }
                    if mood <= 3 {
                        Text("心情不太好喔！是不是肚子餓了？")
                    }
                    else if (mood > 3   && mood <= 7) {
                        Text("心情普通，不開心但也不難過。")
                    }
                    else {
                        Text("心情很好誒～看來主人照顧得相當好！")
                    }
                    
                }
                VStack{
                    Text("不知道牠健不健康？")
                    Text("健康指數 : \(health)")
                    Stepper(value: $health, in: 0...10) {
                                        if health <= 3 {
                                            Text("身體狀況 : Bad")
                                        }
                                        else if (health > 3   && health <= 7) {
                                            Text("身體狀況 :  Normal")
                                        }
                                        else {
                                            Text("身體狀況 : Good")
                                        }
                        
                                }
                    
                        if health <= 3 {
                            Text("身體不太好喔！是不是生病了？")
                        }
                        else if (health > 3   && health <= 7) {
                            Text("身體狀態普通，要記得吃好睡好。")
                        }
                        else {
                            Text("身體很好誒～請繼續保持！")
                        }
                    
                }
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 10))
            
        }.padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(red: red, green:green, blue: blue)
        .edgesIgnoringSafeArea(.all))
    }
}

struct SecondPage_Previews: PreviewProvider {
    static var previews: some View {
        SecondPage(showSecondPage: .constant(true), gender: .constant("boy"),selectname: .constant(""), name: .constant(""), birthday: .constant(Date()), red: .constant(0), green: .constant(0), blue: .constant(0))
    }
}
