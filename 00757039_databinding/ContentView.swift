//
//  ContentView.swift
//  00757039_databinding
//
//  Created by User04 on 2020/11/3.
//

import SwiftUI

struct ContentView: View {
    var imageName = ["Fox","Dog", "Cat", "Hedgehog", "Otter", "Turtle"]
    var genders = ["boy", "girl"]
    @State private var isHandsome = true
    @State private var gender = "boy"
    @State private var showSecondPage = false
    @State private var selectname = "Fox"
    @State private var opacityAmount:Double = 0
    @State private var showAlert = false
    @State private var name = ""
    @State private var selectDate = Date()
    @State var red :Double = 0
    @State var green :Double = 0
    @State var blue :Double = 0
    
    var year: Int {
        Calendar.current.component(.year, from: selectDate)
    }
    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
    
    var body: some View {
        //ScrollView{
        VStack {
            isHandsome ? (Image("fox_handsome").resizable()
                .frame(width: 150, height: 100)) : Image("fox_cute")
                .resizable()
                .frame(width: 150, height: 100)
            Text(isHandsome ? "認真起來一個眼神帥死你" : "眉頭一皺抬起頭擄獲人心")
            Toggle("動物們的另一面?", isOn: $isHandsome)
            Form {
                TextField("如果能有個可愛的寵物，牠名字會是．．．", text: $name, onEditingChanged: { (editing) in
                    print("onEditingChanged", editing)
                     self.showAlert = true
                }){
                    print(self.name)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 5))
                .padding()
                .alert(isPresented: $showAlert) { () -> Alert in
                   let result: String
                    if self.name.isEmpty {
                      result = "偶想要一個名字！！"
                   } else {
                        result = self.name + "是個好名字！～"
                   }
                   return Alert(title: Text(result))
                }
                VStack(alignment: .leading) {
                                        Picker("Boy or Girl?", selection: $gender) {
                                            ForEach(genders, id: \.self) { (gende) in
                                                Text(gende)
                                            }
                                        }
                                    .pickerStyle(SegmentedPickerStyle())
                                    }
                DatePicker("牠的生日？", selection: self.$selectDate, in: self.startDate...self.today, displayedComponents:.date).pickerStyle(WheelPickerStyle())
            
                VStack{
                    ZStack{
                        Image(selectname)
                            .resizable()
                            .scaledToFill()
                            .frame(width:300, height:300)
                            .clipped()
                            .opacity(1-self.opacityAmount)
                        Image(selectname + "1")
                            .resizable()
                            .scaledToFill()
                            .frame(width:300, height:300)
                            .clipped()
                            .opacity(self.opacityAmount)
                    }
                    Picker(selection: $selectname, label:   Text("想看哪個小可愛？")){
                        ForEach(imageName,id: \.self){
                            (imageName)in Text(imageName)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    HStack{
                        Text("不同的他們");
                        Slider(value: self.$opacityAmount, in: 0...1)
                    }
                    Text("總有一種顏色適合你的寵物！")
                    chooseColor(red: $red, green: $green, blue: $blue)
                }
                
    }
            Button(action: {self.showSecondPage = true}) {
                            Text("去看看寵物！")
                                .font(.headline)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color(red: red, green: green, blue: blue))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 5))
                                .clipped()
                        }
                        .sheet(isPresented: self.$showSecondPage) {
                            SecondPage(showSecondPage: self.$showSecondPage,
                                       gender: self.$gender, selectname : self.$selectname, name: self.$name, birthday: self.$selectDate, red: self.$red, green: self.$green, blue: self.$blue)
                        }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
        }
    }
struct chooseColor: View {
    @Binding var red: Double
    @Binding var green: Double
    @Binding var blue: Double
    var body: some View {
        VStack {
            HStack {
                Text("Red")
                    .foregroundColor(Color.red)
                Slider(value: $red, in: 0...1)
                    .accentColor(.red)
            }
            HStack {
                Text("Green")
                    .foregroundColor(Color.green)
                Slider(value: $green, in: 0...1)
                    .accentColor(.green)
            }
            HStack {
                Text("Blue")
                    .foregroundColor(Color.blue)
                Slider(value: $blue, in: 0...1)
                    .accentColor(.blue)
            }
        }
    }
}

