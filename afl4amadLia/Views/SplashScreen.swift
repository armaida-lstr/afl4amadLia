////
////  SplashScreen.swift
////  afl4amadLia
////
////  Created by MacBook Pro on 06/06/22.
////
//
//import SwiftUI
//
//struct SplashScreen: View {
//    @State var splashScreen  = false
//    // 1.
//     //   @State var isActive:Bool = false
//    var body: some View {
//        
//        ZStack{
//            ZStack{
//                Image("Logo")
//                    .resizable()
//                    .renderingMode(.original)
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 10, height: 10)
//            }
//            .ignoresSafeArea(.all, edges: .all)
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//               
//                self.splashScreen = true
//                                        }
//            }
//        }
//    }
//}
//        
//        
//        
////        VStack {
////                    // 2.
////                    if self.isActive {
////                        // 3.
////                        Image(systemName: "Logo")
////                    } else {
////                        // 4.
////                        NewsTab()
////                    }
////                }
////                // 5.
////                .onAppear {
////                    // 6.
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                        // 7.
////                        withAnimation {
////                            self.isActive = true
////                        }
////                    }
////                }
////            }
////
////        }
//
////struct SplashScreen_Previews: PreviewProvider {
////    static var previews: some View {
////        SplashScreen()
////    }
////}
