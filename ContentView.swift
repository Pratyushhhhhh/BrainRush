import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Fast Math")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink(destination: GameView().navigationBarBackButtonHidden(true)){
                    HStack{
                        Image(systemName: "play.circle")
                            .font(.title3)
                        Text("Start")
                            .font(.title)
                    }
                    .frame(width: 250,height: 50)
                    .background(.indigo)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                    .navigationBarHidden(true)
                }
            }
        }
    
        }
    }

