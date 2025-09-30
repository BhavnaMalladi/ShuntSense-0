//
//  HomeView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 3/10/25.
//
import SwiftUI
import SwiftData
import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var appointmentLocation = ""
    @State private var isDatePickerVisible = false
    @AppStorage("nextAppointmentDate") private var nextAppointmentDate: Double = Date().timeIntervalSince1970
    @AppStorage("nextAppointmentLocation") private var nextAppointmentLocation: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#243E36"))
                    .padding(.top)
                
                // Overview Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Your Next Appointment")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#7CA982"))
                        .padding(.bottom, 5)
                    
                    Button(action: {
                        isDatePickerVisible.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Pick a Date & Time")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#7CA982"))
                        .cornerRadius(10)
                    }
                    
                    if isDatePickerVisible {
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .accentColor(Color(hex: "#7CA982"))
                            .padding()
                    }
                    
                    TextField("Enter Location", text: $appointmentLocation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Save Appointment") {
                        nextAppointmentDate = selectedDate.timeIntervalSince1970
                        nextAppointmentLocation = appointmentLocation
                        isDatePickerVisible = false
                    }
                    .padding()
                    .background(Color(hex: "#7CA982"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                // Display Next Appointment
                VStack(spacing: 5) {
                    Text("Next Appointment")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#243E36"))
                    
                    let savedDate = Date(timeIntervalSince1970: nextAppointmentDate)
                    Text("Date: \(formattedDate(savedDate))")
                        .foregroundColor(Color(hex: "#7CA982"))
                    
                    Text("Location: \(nextAppointmentLocation.isEmpty ? "Not Set" : nextAppointmentLocation)")
                        .foregroundColor(Color(hex: "#7CA982"))
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
          
                

                
                            VStack(spacing: 20) {
                                NavigationLink("View/Edit Shunt Info", destination: ShuntInfoView())
                                NavigationLink("Record/View Gait Videos", destination: GaitVideoView())
                                NavigationLink("Upload/View MRI or CT Images", destination: ScanUploadView())
                            }
                            .padding()
                            .navigationTitle("ShuntSense Home")
                   
                
                // Quick-Access Buttons
                VStack(spacing: 10) {
                    NavigationLink(destination: LogSymptomsView()) {
                        Text("Log/View Symptom Reports")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SymptomManagementView()) {
                        Text("Manage NPH Symptom")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: ResourcesView()) {
                        Text("Online NPH Resources")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#7CA982"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .padding()
            .background(Color(hex: "#F1F7ED").ignoresSafeArea())
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
