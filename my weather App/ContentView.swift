//
//  ContentView.swift
//  my weather App
//
//  Created by Atharva Lavhate on 27/02/25.
//

import SwiftUI
import Alamofire
//contains data from json


struct ContentView: View {
    @State private var results = [ForecastDay]()
    @State var backgroundColor = Color.init(red: 47/255, green: 79/255, blue: 79/255)
    @State var weatherEmoji = "☀️"
    @State var currentTemp = 0
    @State var conditionText = "Sunny"
    @State var cityName = "Mumbai"
    @State var hourlyForecast = [Hour]()
    @State var query : String = ""
    @State var contentSize : CGSize = .zero
    @State var textFieldHeight = 15.0
    @State var loading = true
    
    var body: some View {
        if loading{
            ZStack{
                Color.init(backgroundColor)
                    .ignoresSafeArea()
                ProgressView()
                    .scaleEffect(2,anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .task {
                        await fetchWeather(query: "")
                    }
            }
        }else{
            
            //UI view
            NavigationView{
                VStack {
                    Spacer()
                    TextField("Enter city name or postal code", text: $query , onEditingChanged: getFocus)
                        .textFieldStyle(PlainTextFieldStyle())
                        .background(
                            Rectangle()
                                .foregroundColor(.white.opacity(0.2))
                                .cornerRadius(25)
                                .frame(height: 50)
                        )
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        .padding(.bottom, 15)
                        .padding(.top, textFieldHeight)
                        .multilineTextAlignment(.center)
                        .accentColor(.white)
                        .font(Font.system(size: 20, design: .default))
                        .onSubmit {
                            Task {
                                await fetchWeather(query: query)
                            }
                            withAnimation {
                                textFieldHeight = 15
                            }
                        }
                    Text("\(cityName)")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("\(Date().formatted(date:.complete, time: .omitted))")
                        .bold()
                    Text(weatherEmoji)
                        .font(.system(size:180))
                    
                    Text("\(currentTemp)°C")
                        .font(.system(size:50))
                        .bold()
                    
                    Text("\(conditionText)")
                        .font(.system(size: 22))
                        .bold()
                    
                    Spacer()
                    Spacer()
                    
                    Text("Hourly Forecast")
                        .font(.system(size:22))
                        .foregroundColor(.white)
                        .bold()
                    ScrollView(.horizontal , showsIndicators: false){
                        HStack{
                            Spacer()
                            ForEach(hourlyForecast) { Forecast in
                                VStack{
                                    Text("\(getShortTime(time: Forecast.time ))")
                                        .shadow(color: .black.opacity(0.2), radius: 1)
                                    Text("\(getWeatherEmoji(code: Forecast.condition.code))")
                                        .frame(width: 50, height: 14)
                                        .shadow(color: .black.opacity(0.2), radius: 1)
                                    
                                    Text("\(Int(Forecast.temp_c))°C")
                                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                                    
                                }
                                .frame(width: 50, height: 90)
                            }
                        }
                        .background(Color.white.blur(radius: 75).opacity(0.35))
                        
                    }
                    Spacer(minLength: 20)
                    Text("7 Days Forecast")
                        .font(.title2)
                        .bold()
                    
                    //forecast list
                    List($results){ $forecast in
                        ForEach (Array(results.enumerated()), id: \.1.id) { index, forecast in
                            NavigationLink{
                                WeatherDetails(results: $results, cityName: $cityName, index: index)
                            }label: {
                                
                                HStack(alignment: .center , spacing: nil){
                                    Text("\(getShortDate(epoch: forecast.date_epoch))")
                                        .frame(maxWidth: 70, alignment: .leading)
                                        .bold()
                                    
                                    Text("\(getWeatherEmoji(code: forecast.day.condition.code))")
                                        .frame(maxWidth: 50, alignment: .leading)
                                        .bold()
                                    
                                    Text("\(Int(forecast.day.avgtemp_c))°C")
                                        .frame(maxWidth: 50, alignment: .leading)
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Text("\(forecast.day.condition.text)")
                                        .bold()
                                }
                                .listRowBackground(Color.white.blur(radius: 75).opacity(0.5))
                            }
                            
                            
                            .scrollContentBackground(.hidden)
                            .preferredColorScheme(.dark)
                            
                        }
                    }
                }
            }
        }
    }
    
    func getFocus(focused: Bool) {
         withAnimation {
             textFieldHeight = 130
         }
     }
    //fetch weather
    func fetchWeather(query: String) async{
        var queryText = ""
        if (query == "") {
            queryText = "http://api.weatherapi.com/v1/forecast.json?key=b94801885e204d72aab141008252702&q=Mumbai&days=7&aqi=no&alerts=no"
        } else {
            queryText = "http://api.weatherapi.com/v1/forecast.json?key=b94801885e204d72aab141008252702&q=\(query)&days=7&aqi=no&alerts=no"
        }
        let request = AF.request(queryText)
        
        request.responseDecodable(of: Weather.self) { response in
            switch response.result{
            case .success(let weather):
                //dump(weather)
                cityName = weather.location.name
                results = weather.forecast.forecastday
                var index = 0
                if Date(timeIntervalSince1970: TimeInterval(results[0].date_epoch)).formatted(Date.FormatStyle().weekday(.abbreviated)) != Date().formatted(Date.FormatStyle().weekday(.abbreviated)){
                    index = 1
                }
                
                currentTemp = Int(results[index].day.avgtemp_c)
                hourlyForecast = results[index].hour
                backgroundColor = getBackgroundColor(code: results[index].day.condition.code)
                weatherEmoji = getWeatherEmoji(code: results[index].day.condition.code)
                conditionText = results[index].day.condition.text
                loading = false
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
                
    }


#Preview {
    ContentView()
}
