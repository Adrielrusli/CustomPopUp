//
//  ContentView.swift
//  CustomPopUp
//
//  Created by Adriel Bernard Rusli on 24/05/23.
//

//
//  Test.swift
//  FlowerID
//
//  Created by Audrey on 24/05/23.
//

//import SwiftUI
//
//struct ContentView1: View {
//    var body: some View {
//        MyView()
//
//            .frame(width: 200, height: 300) // Set the desired width and height
//            .background(Color.black)
//    }
//}
//
//struct MyView: View {
//    var body: some View {
//        // Your view content here
//        Text("Hello, World!")
//            .font(.title)
//            .foregroundColor(.blue)
//    }
//}
//
//struct ContentView1_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView1()
//    }
//}

import SwiftUI



struct ContentView1: View {
    @State private var isShowingPopUp = false
    
    var body: some View {
        ZStack {
            Button(action: {
                isShowingPopUp.toggle()
            }) {
                Text("Show Pop-Up")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            
            
            if isShowingPopUp {
                PopUpView(isShowingPopUp: $isShowingPopUp)
                    .transition(.scale)
                    .animation(.easeIn(duration: 20))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
}

struct PopUpView: View {
    
    @Binding var isShowingPopUp: Bool
    @State private var curHeight: CGFloat = 250
    
    let minHeight: CGFloat = 250
    let maxHeight: CGFloat = 700
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowingPopUp{
                
                Color(.black)
                    .opacity(0.1)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowingPopUp = false
                    }
                

                mainView
                    .transition(.move(edge: .bottom))
  
            }
            
        } .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut)
    }
    
    var mainView: some View{
        VStack{
            ZStack{
                Capsule()
                
                    .frame(width: 60, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.0001))
            .gesture(dragGesture)
            ZStack{
                if(curHeight < 300){
                    
                    VStack(alignment: .leading){
                        Text("Placeholder Nama")
                            
                        
                        
                        Text("Ini Description loh")
                            
                        
                    }
                    .padding(.horizontal, 30)
                }else{
                    VStack(){
                        VStack(alignment: .center){
                            Image("rose")
                                .multilineTextAlignment(.center)
                        }
                        
                        
                        
                        VStack(alignment: .leading){
                            Text("Placeholder Nama")
                           
                            
                            
                            
                            Text("Ini Description loh")
                              
                        }
                           
                        
                    }.frame(width: .infinity)
                    .padding(.horizontal, 30)
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }.frame(height: curHeight)
            .frame(maxWidth: .infinity)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(.white)
                    Rectangle()
                        .frame(height: curHeight / 2 )
                    
                    
                }
                    .foregroundColor(.clear)
            )
        
        
        
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture{
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged{
                val in
                
                let dragAmount = val.translation.height - prevDragTranslation.height
                
                if curHeight > maxHeight || curHeight < minHeight{
                    curHeight -= dragAmount / 6
                }else{
                    curHeight -= dragAmount
                }
                
                
                
                prevDragTranslation = val.translation
            }
            .onEnded{ val in
                prevDragTranslation = .zero
            }
    }
}




struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
