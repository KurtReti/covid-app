//
//  ConductTestView.swift
//  COVID-APP
//
//  Created by Connor Jones on 18/5/21.
//

import SwiftUI

struct ConductTestView: View {
    @State var medicare = ""
    @State var isActive = false
    //@StateObject var ConductTestVM = ConducTestViewModel()
    var body: some View {
            VStack{
               
                NavigationLink(destination: FakeHomeForCheckInTest()){
                    Text("text")
                        
                      
                    
                    
                    
                    
                    
                }

                GroupBox() {
                    Image("searchIcon")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .opacity(1)
                    Text("Search")
                        .font(.title)
                    Text("Search Individual by medicare number to confirm testing")
                        .multilineTextAlignment(.center)
                    Text("")
                   
                    //Spacer()
                    TextField("Medicare Number", text: $medicare).frame(width: 300.0, height: 30.0).background(Color.white)
                        .padding(.bottom, 15)
                    
                    NavigationLink(destination: VaccineAdministrationView(medicare: $medicare), isActive: $isActive) {
                                    Button(action: {

                                        //IndividualSearchVM.vaccineHistorySearch(medicare: medicare)
                                      
                                    }){
                                        Text("Confirm")
                                            .font(.body)
                                            .foregroundColor(Color.white)
                                            .background(RoundedRectangle(cornerRadius: 0)
                                                            .foregroundColor(Color(#colorLiteral(red: 0.8900507092, green: 0.1440600455, blue: 0.0343856439, alpha: 1)))
                                                            .frame(width: 300.0, height: 40.0))
                                    }.padding(.bottom, 15)
                    }
                    
                 

                
                  
                    
                }
                .frame(width: 350.0, height: 300.0)
               // if(VaccineAdminVM.an){
              
               
             
                
            }
            
            .navigationBarTitle("Vaccination Admission", displayMode: .inline)

          
            
        
    }
}


struct ConductTestView_Previews: PreviewProvider {
    static var previews: some View {
        ConductTestView()
    }
}
