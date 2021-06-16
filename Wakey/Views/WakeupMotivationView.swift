//
//  WakeupMotivationView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI

struct WakeupMotivationView: View {
    @State var api = WakeupWisdomAPI()
    @State var dailyQuote: String = ""
    @State var showError: Bool = false
    @State var backgroundImageUrl: String = ""
    
    func loadData() {
        api.getWakeupWisdom(completion: { resp in
            let data = resp.map({$0 as Welcome})
            switch data {
            case let .success(value):
                dailyQuote = value.contents.quotes[0].quote
                
            case .failure(_):
                self.error()
            }
        })
    }
    
    func error() {
        showError = true
    }
    var body: some View {
        ZStack {
            Image("motivationBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(dailyQuote)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .frame(width: 400)
                    .alert(isPresented: $showError, content: {
                        Alert(title: Text("Error"),
                              message: Text("Could not load wakeup motivation")
                        )
                    }
                    )
                Spacer()
                Button(action: actionSheet) {
                    Image(systemName: "square.and.arrow.up")
                }
            }.padding(.top, 100)
            
        }.navigationBarBackButtonHidden(false)
        .onAppear(perform: loadData)
    }
    
    func actionSheet() {
        let items = ["The wisdom of the day: \(dailyQuote)"]
        let av = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct WakeupMotivationView_Previews: PreviewProvider {
    static var previews: some View {
        WakeupMotivationView()
    }
}
