//
//  NPHEducationView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 3/10/25.
//

import SwiftUI

struct NPHEducationView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // Section 1: Understanding NPH
                    Group {
                        Text("Understanding NPH")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "#243E36"))
                        
                        Text("Learn about Normal Pressure Hydrocephalus (NPH) and how it differs from Alzheimer’s and Parkinson’s. Watch videos and read articles for in-depth information.")
                            .font(.body)
                            .foregroundColor(Color(hex: "#7CA982"))
                        
                        Link("Watch Video on NPH", destination: URL(string: "https://www.example.com/nph-video")!)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#E0EEC6"))
                            .cornerRadius(10)
                        
                        Link("Read Article on NPH", destination: URL(string: "https://www.example.com/nph-article")!)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#E0EEC6"))
                            .cornerRadius(10)
                    }
                    
                    Divider()
                    
                    // Section 2: Shunt Surgery Information
                    Group {
                        Text("Shunt Surgery Information")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "#243E36"))
                        
                        Text("Get detailed information about shunt surgery, including what to expect before and after the procedure. Understand the benefits and potential risks.")
                            .font(.body)
                            .foregroundColor(Color(hex: "#7CA982"))
                        
                        Link("Shunt Surgery Guide", destination: URL(string: "https://www.example.com/shunt-surgery-guide")!)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#E0EEC6"))
                            .cornerRadius(10)
                    }
                    
                    Divider()
                    
                    // Section 3: Symptom Management Tips
                    Group {
                        Text("Symptom Management Tips")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "#243E36"))
                        
                        Text("Find practical tips for managing NPH symptoms. Learn about exercise routines, lifestyle adjustments, and get the latest research updates.")
                            .font(.body)
                            .foregroundColor(Color(hex: "#7CA982"))
                        
                        Link("Exercise & Lifestyle Tips", destination: URL(string: "https://www.example.com/exercise-tips")!)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#E0EEC6"))
                            .cornerRadius(10)
                        
                        Link("Latest Research on NPH", destination: URL(string: "https://www.example.com/nph-research")!)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#E0EEC6"))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("NPH Education")
            .background(Color(hex: "#F1F7ED").ignoresSafeArea())
        }
    }
}


// MARK: - Preview

struct NPHEducationView_Previews: PreviewProvider {
    static var previews: some View {
        NPHEducationView()
    }
}
