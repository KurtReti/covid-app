//
//  PreviousVaccineView.swift
//  COVID-APP
//
//  Created by Connor Jones on 20/5/21.
//

import SwiftUI

struct PreviousVaccineView: View {
    
    //@State var test = ""
    let vaccination: Vaccination
    let vaccineList: [Vaccine]
    let individual: Individual
    @State var vaccine: Vaccine
    @State var doseNum: String
    
    
    var body: some View {
        
        
        VStack{
            VStack(alignment: .leading){
                
                Text("Cerificate of Vaccinataion")
                    .font(.title)
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
                    Text("Vaccine:")
                    Text(vaccine.name)
                        .multilineTextAlignment(.leading)
                    
                    
                    
                }
                
                HStack{
                    Text("Dose:")
                    Text("/")
                    Text(doseNum)
                        .multilineTextAlignment(.leading)
                    
                    
                    
                }
                
                // HStack{
                //  Text("Dose:")
                // Text(verbatim: vaccination.dose)
                //  Text("2")
                
                
                // }
                
            }
            .padding(.leading)
            Spacer()
        }.onAppear(){
            self.prepareData()
        }
        
    }
    
    
    func prepareData(){
        
        
        //Vaccine
        
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
