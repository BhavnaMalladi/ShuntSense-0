//
//  SymptomManagementView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 3/20/25.
//


import SwiftUI

struct SymptomManagementView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text("Understanding NPH")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#243E36"))
                    .padding(.top)
                
                // Overview of NPH
                Text("Normal Pressure Hydrocephalus (NPH) is a condition caused by cerebrospinal fluid buildup in the brain, leading to neurological symptoms. It is commonly seen in older adults and is often mistaken for other neurodegenerative disorders.")
                    .foregroundColor(Color(hex: "#7CA982"))
                    .padding(.horizontal)
                
                // Hakim's Triad Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hakim's Triad")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#243E36"))
                    
                    Text("NPH symptoms are categorized into Hakim’s Triad:")
                        .foregroundColor(Color(hex: "#7CA982"))
                    
                    BulletPoint(text: "Gait Disturbance – Difficulty walking, shuffling steps, balance problems.")
                    BulletPoint(text: "Cognitive Impairment – Memory loss, confusion, difficulty concentrating.")
                    BulletPoint(text: "Urinary Incontinence – Frequent urination, urgency, accidents.")
                }
                .padding(.horizontal)
                
                // Symptom Management
                Text("Managing Symptoms")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#243E36"))
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    SymptomManagementCard(title: "Gait Disturbance", description: "Engage in physical therapy, use assistive devices like canes or walkers, and perform balance exercises.", youtubeLink: "https://youtu.be/F4PxppoQmHs?si=OTc69QEY8ujNBr9k")
                    SymptomManagementCard(title: "Cognitive Impairment", description: "Engage in cognitive therapy, do brain exercises like puzzles, and maintain a structured routine.", youtubeLink: "https://youtu.be/-5IdyD2wZUA?si=cKq_jIoxQpjgiFfU")
                    SymptomManagementCard(title: "Urinary Incontinence", description: "Practice bladder training, schedule bathroom breaks, and do pelvic floor exercises like Kegels.", youtubeLink: "https://youtu.be/l_PM-wN116Q?si=Pq9z6_1JTiOVHhCd")
                }
                .padding(.horizontal)
                
                // Other Symptoms Section
                Text("Other Symptoms")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#243E36"))
                    .padding(.horizontal)
                
                Text("Additional symptoms such as fatigue, depression, and headaches can also occur. Managing these through healthy lifestyle habits, medication, and doctor consultations is crucial.")
                    .foregroundColor(Color(hex: "#7CA982"))
                    .padding(.horizontal)
                
                // Chatbot Button
                Button(action: {
                    if let url = URL(string: "https://shuntsense.zapier.app") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Talk to a Chatbot About Symptoms")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#7CA982"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
        }
        .background(Color(hex: "#F1F7ED").ignoresSafeArea())
        .navigationTitle("Symptom Management")
    }
}

// Custom Bullet Point View
struct BulletPoint: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("•")
                .font(.headline)
                .foregroundColor(Color(hex: "#7CA982"))
            Text(text)
                .foregroundColor(Color(hex: "#7CA982"))
        }
    }
}

// Custom Card for Symptom Management
struct SymptomManagementCard: View {
    var title: String
    var description: String
    var youtubeLink: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(hex: "#243E36"))
            
            Text(description)
                .foregroundColor(Color(hex: "#7CA982"))
                .font(.subheadline)
            
            Button(action: {
                if let url = URL(string: youtubeLink) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Watch Video")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#7CA982"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Preview
struct SymptomManagementView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomManagementView()
    }
}
