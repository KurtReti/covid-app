//
//  PreviousVaccineView.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//

import SwiftUI

struct PreviousVaccineView: View {
    
    
    let vaccination: Vaccination
    let vaccineList: [Vaccine]
    let individual: Individual
    @State var vaccine: Vaccine
    @State var doseNum: String
    
    
    var body: some View {
        
        
        VStack{

                        Text("Cerificate of Vaccinataion")

                            .font(.title)

                        List{

                            HStack{

                                Text("Medicare Number: ")

                                Text(individual.id ?? "error")

                            }

                            HStack{

                                Text("Name:")

                                Text(individual.firstName)

                                Text(individual.lastName)

                            }

                            HStack{

                                Text("Adress:")

                                Text(individual.address)

                            }

                            HStack{

                                Text("Vaccine:")

                                Text(vaccine.name)

                                    .multilineTextAlignment(.leading)

                            }



                            HStack{

                                Text("Date:")

                                Text(vaccination.doseDate)

                                    .multilineTextAlignment(.leading)

                            }


                        }

                        .padding(.leading)

                        Spacer()

                    }.onAppear(){
            self.prepareData()
        }
        
    }
    
    //links vaccineID in vaccintation with vaccine used for vaccination
    func prepareData(){

        for vaccine1 in vaccineList {
            if  vaccine1.id == vaccination.vaccineID{
                vaccine = vaccine1
                print("vaccine available")
                doseNum = String(vaccine1.dosageAmount)
                
                //batchID = vaccineBatch.id
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
}
