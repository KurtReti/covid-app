
import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct VaccinesView: View {
    @StateObject var viewModel = VaccinesViewModel()
    var body: some View {
        VStack{

            List(viewModel.vaccinationList) { vaccination in
                VStack{
                    
                    NavigationLink(destination: VaccineCertView(vaccination: vaccination, vaccineList: viewModel.vaccineList, vaccineDict: viewModel.vaccineDictionary, individual: viewModel.currentIndividual, vaccine: viewModel.currentVaccine, doseNum: "")){
                        Text(vaccination.doseDate)
                        
                        
                        
                        
                        
                        
                        
                    }
                }
                
                
            }

            
            
            
        }.onAppear(){
            viewModel.startProcess()
        }
}
}


class VaccinesViewModel: ObservableObject{
    
    
    private let db = Firestore.firestore()
    
    //tied to picker selection for vaccine
    
    
    
    
    @Published var currentIndividual: Individual
   // @Published var currentHealthOfficial: HealthOfficial
    @Published var currentHealthCentre: HealthCentre
    
    @Published var currentVaccine: Vaccine
    
    @Published var isActive = false
    @Published var vaccinationList = [Vaccination]()
    
    @Published var vaccineBatchList = [VaccineBatch]()
    
    @Published var vaccineList = [Vaccine]()
    @Published var vaccineDictionary = [String: Vaccine]()
    
    
    @Published var intitialLoad = true
    @Published var showProfile = false
    @Published var medicareNum = ""
    
    
    init() {
        currentIndividual = Individual(id: "", firstName: "", lastName: "", address: "", email: "", phoneNum: "", dob: "")
        
        currentVaccine = Vaccine(id: "", name: "", dosageAmount: 0, manufacture: "")
        
        currentHealthCentre = HealthCentre(id: "", accessLevel: "", address: "", email: "", phoneNum: "", uid: "")
        
        //getVaccineSupply()
       
        
        
    }
    func startProcess(){
     
        populateVaccineList()
        vaccineHistorySearch()
        fillVacineDictionary()

    }
    
    func populateVaccineList(){
        
        let query = db.collection("vaccine").whereField("active", isEqualTo: true).limit(to: 8)
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents1 = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.vaccineList = documents1.compactMap { (queryDocumentSnapshot) -> Vaccine? in
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = queryDocumentSnapshot.data()
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    
                    let fsDosageAmount = data["dosageAmount"] as? Int ?? 0
                    let fsName = data["name"] as? String ?? ""
                    let fsManufcature = data["manufacture"] as? String ?? ""
                    print("in Supply")
                    return Vaccine(id: fsVaccineID, name: fsName, dosageAmount: fsDosageAmount, manufacture: fsManufcature)
                }
                
                var tempVaccineList = [Vaccine]()
                for vaccine in self.vaccineList{
                    print("in Supply1")
                    var vaccineInSupply = false
                    for vaccineBatch in self.vaccineBatchList{
                        
                        if(vaccine.id == vaccineBatch.vaccineID){
                            vaccineInSupply = true
                        }
                        
                    }
                    if(vaccineInSupply){
                        print(vaccine.name)
                        print("in Supply2")
                        tempVaccineList.append(vaccine)
                    }
                }
                self.vaccineList = tempVaccineList
                
                self.getVaccinationHistory()
               //self.intitialLoad = false
               // self.vaccineHistorySearch(medicare: self.medicareNum)
                
            }
        
    }

    func getVaccinationHistory(){
        
       
        print(medicareNum)
        
        var anyVaccinationHistory = false
      
        
        
        let query = db.collection("vaccination").whereField("individualID", isEqualTo: Singleton.shared.accountID ?? "")
        query
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.vaccinationList = documents.compactMap { (queryDocumentSnapshot) -> Vaccination? in
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    anyVaccinationHistory = true
                    let data = queryDocumentSnapshot.data()
                    let fsVaccinationID = data["vaccinationID"] as? String ?? ""
                    let fsIndividualID = data["individualID"] as? String ?? ""
                    let fsHealthOfficialID = data["healthCentreID"] as? String ?? ""
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsBookingID = data["bookingID"] as? String ?? ""
                    let fsDoseDate = data["doseDate"] as? String ?? ""
                    
                    
                  
                    return Vaccination(id: fsVaccinationID, bookingID: fsBookingID, individualID: fsIndividualID, healthCentreID: fsHealthOfficialID, vaccineID: fsVaccineID, doseDate: fsDoseDate)
                }
                
                
                if (anyVaccinationHistory == true){
                    print("vaccine history present1")
                    self.intitialLoad = false
                    //self.getVaccine()
                   // self.getVaccineSupply()
                    
                }else{
                    print("no vaccine history")
                    self.intitialLoad = false
                    //self.getVaccine()
                   // self.getVaccineSupply()
                }
                
            }
        
        if (anyVaccinationHistory == true){
            print("vaccine history present2")
            self.intitialLoad = false
            
        }else{
            print("no vaccine history2")
            self.intitialLoad = false
        }
        
        
    }
    
    func vaccineHistorySearch(){
        
        
        
        db.collection("individual").whereField("accountID", isEqualTo: Singleton.shared.accountID ?? "" ).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    //  let id = document.documentID
                    let fsAccountID = data["accountID"] as? String ?? ""
                    let fsAddress = data["address"] as? String ?? ""
                    let fsDOB = data["dob"] as? String ?? ""
                    let fsEmail = data["email"] as? String ?? ""
                    let fsFirstName = data["first_name"] as? String ?? ""
                    let fsLastName = data["last_name"] as? String ?? ""
                    let fsPhoneNum = data["phoneNum"] as? String ?? ""
                    
                    
                    self.currentIndividual = Individual(id: fsAccountID, firstName: fsFirstName, lastName: fsLastName, address: fsAddress, email: fsEmail, phoneNum: fsPhoneNum, dob: fsDOB)
                    
                    
                    print(fsFirstName)
                    self.getVaccinationHistory()
                    
                    // self.getBusiness()
                    
                    //do some error stuff
                }
                
                //
                
                
                
            }
            
        }
        
        
        
        
        
        
    }
    func fillVacineDictionary(){
        
        db.collection("vaccine").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
                
            } else {
                
                
                for document in querySnapshot!.documents {
                    //return try? queryDocumentSnapshot.data(as: Dependent.self)
                    //anyVaccinationHistory = true
                    let data = document.data()
                    
                    let fsVaccineID = data["vaccineID"] as? String ?? ""
                    let fsName = data["name"] as? String ?? ""
                    let fsDosageAmount = data["dosageAmount"] as? Int ?? 0
                    let fsManufacture = data["manufacture"] as? String ?? ""
                    let vac = Vaccine(id: fsVaccineID, name: fsName, dosageAmount: fsDosageAmount, manufacture: fsManufacture)
                    self.vaccineDictionary[fsVaccineID] = vac
                    
                    
                    
                }
                
                
            }
        }
    }
    
    
}


struct VaccineCertView: View {
    
    
    let vaccination: Vaccination
    let vaccineList: [Vaccine]
    let vaccineDict: [String: Vaccine]
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

                                Text("Address:")

                                Text(individual.address)

                            }

                            HStack{

                                Text("Vaccine:")

                                Text(vaccineDict[vaccination.vaccineID]?.name ?? "")

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
