//  LogSymptomsView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 3/10/25.
//
import SwiftUI

struct SymptomLog: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let cognitiveFunction: Double
    let gaitAbnormalities: Double
    let urinaryFunction: Double
    let severity: String
    let frequency: String
    let onsetTrend: String
    let additionalNotes: String
    let walkingTime: Double? // New field for walking test
}

struct LogSymptomsView: View {
    @State private var cognitiveFunction: Double = 5
    @State private var gaitAbnormalities: Double = 5
    @State private var urinaryFunction: Double = 5
    @State private var additionalNotes: String = ""
    @State private var severity: String = "Mild"
    @State private var frequency: String = "Daily"
    @State private var onsetTrend: String = "Stable"
    @State private var symptomLogs: [SymptomLog] = []
    @State private var navigateToWalkingTest = false
    @State private var latestSymptomLogID: UUID? = nil // To track the last log
    
    let severities = ["Mild", "Moderate", "Severe"]
    let frequencies = ["Daily", "Weekly", "Rarely"]
    let onsetTrends = ["Worsening", "Stable", "Improving"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Symptom Log")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    SymptomSlider(title: "Cognitive Function", value: $cognitiveFunction)
                    SymptomSlider(title: "Gait Abnormalities", value: $gaitAbnormalities)
                    SymptomSlider(title: "Urinary Function", value: $urinaryFunction)
                    
                    PickerSelection(title: "Severity", selection: $severity, options: severities)
                    PickerSelection(title: "Frequency", selection: $frequency, options: frequencies)
                    PickerSelection(title: "Onset Trend", selection: $onsetTrend, options: onsetTrends)
                    
                    Text("Additional Notes")
                        .font(.headline)
                    TextEditor(text: $additionalNotes)
                        .frame(height: 100)
                        .border(Color.gray, width: 1)
                    
                    Button(action: saveSymptomLog) {
                        Text("Submit")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                    
                    NavigationLink(destination: WalkingTestScreen(onWalkingTimeSaved: updateWalkingTime), isActive: $navigateToWalkingTest) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: SymptomHistoryView(symptomLogs: symptomLogs)) {
                        Text("View Symptom History")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .navigationTitle("Log Symptoms")
            .onAppear {
                loadSymptomLogs()
            }
        }
    }
    
    private func saveSymptomLog() {
        let newLog = SymptomLog(
            date: Date(),
            cognitiveFunction: cognitiveFunction,
            gaitAbnormalities: gaitAbnormalities,
            urinaryFunction: urinaryFunction,
            severity: severity,
            frequency: frequency,
            onsetTrend: onsetTrend,
            additionalNotes: additionalNotes,
            walkingTime: nil // Will be updated after walking test
        )
        
        symptomLogs.append(newLog)
        latestSymptomLogID = newLog.id
        
        if let encoded = try? JSONEncoder().encode(symptomLogs) {
            UserDefaults.standard.set(encoded, forKey: "symptomLogs")
        }
        
        navigateToWalkingTest = true
    }
    
    private func updateWalkingTime(_ walkingTime: Double) {
        if let index = symptomLogs.firstIndex(where: { $0.id == latestSymptomLogID }) {
            symptomLogs[index] = SymptomLog(
                date: symptomLogs[index].date,
                cognitiveFunction: symptomLogs[index].cognitiveFunction,
                gaitAbnormalities: symptomLogs[index].gaitAbnormalities,
                urinaryFunction: symptomLogs[index].urinaryFunction,
                severity: symptomLogs[index].severity,
                frequency: symptomLogs[index].frequency,
                onsetTrend: symptomLogs[index].onsetTrend,
                additionalNotes: symptomLogs[index].additionalNotes,
                walkingTime: walkingTime
            )
            
            if let encoded = try? JSONEncoder().encode(symptomLogs) {
                UserDefaults.standard.set(encoded, forKey: "symptomLogs")
            }
        }
    }
        private func loadSymptomLogs() {
            if let savedData = UserDefaults.standard.data(forKey: "symptomLogs"),
               let decodedLogs = try? JSONDecoder().decode([SymptomLog].self, from: savedData) {
                symptomLogs = decodedLogs
            }
        }
    }
    
    
    struct WalkingTestScreen: View {
        var onWalkingTimeSaved: (Double) -> Void
        
        @State private var timerRunning = false
        @State private var elapsedTime: Double = 0
        @State private var manualEntry: String = ""
        @State private var timer: Timer? = nil
        
        var body: some View {
            VStack(alignment: .center, spacing: 20) {
                Text("Walk 10 meters and record time.")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Elapsed Time: \(String(format: "%.1f", elapsedTime)) seconds")
                    .font(.headline)
                
                Button(action: {
                    if timerRunning {
                        timer?.invalidate()
                        timer = nil
                        timerRunning = false
                    } else {
                        elapsedTime = 0
                        timerRunning = true
                        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                            elapsedTime += 0.1
                        }
                    }
                }) {
                    Text(timerRunning ? "Stop Timer" : "Start Timer")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                VStack {
                    Text("Or enter time manually:")
                    TextField("Enter time", text: $manualEntry)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                Button(action: saveWalkingTime) {
                    Text("Save Result")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        
        private func saveWalkingTime() {
            let timeToSave = (Double(manualEntry) ?? elapsedTime)
            onWalkingTimeSaved(timeToSave)
        }
    }
    
    struct SymptomHistoryView: View {
        let symptomLogs: [SymptomLog]
        
        var body: some View {
            List(symptomLogs.reversed()) { log in
                VStack(alignment: .leading) {
                    Text(log.date, style: .date)
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Cognitive: \(Int(log.cognitiveFunction))")
                    Text("Gait: \(Int(log.gaitAbnormalities))")
                    Text("Urinary: \(Int(log.urinaryFunction))")
                    Text("Severity: \(log.severity)")
                    Text("Frequency: \(log.frequency)")
                    Text("Onset Trend: \(log.onsetTrend)")
                    
                    if let walkingTime = log.walkingTime {
                        Text("Walking Time: \(walkingTime, specifier: "%.2f") seconds")
                    }
                    
                    if !log.additionalNotes.isEmpty {
                        Text("Notes: \(log.additionalNotes)")
                            .italic()
                    }
                }
            }
            .navigationTitle("Symptom History")
        }
    }

    
    
    struct SymptomSlider: View {
        let title: String
        @Binding var value: Double
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(hex: "#243E36"))
                Slider(value: $value, in: 0...10, step: 1)
                    .accentColor(Color(hex: "#7CA982"))
                Text("Severity: \(Int(value))")
                    .font(.caption)
            }
        }
    }
    
    struct PickerSelection: View {
        let title: String
        @Binding var selection: String
        let options: [String]
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(hex: "#243E36"))
                Picker(title, selection: $selection) {
                    ForEach(options, id: \..self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
    
    struct FileAttachmentButton: View {
        let icon: String
        let title: String
        
        var body: some View {
            Button(action: {
                // Handle file attachment
            }) {
                VStack {
                    Image(systemName: icon)
                        .font(.largeTitle)
                        .foregroundColor(Color(hex: "#7CA982"))
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 80, height: 80)
                .background(Color(hex: "#E0EEC6"))
                .cornerRadius(10)
            }
        }
    }
    
    
    
    struct LogSymptomsView_Previews: PreviewProvider {
        static var previews: some View {
            LogSymptomsView()
        }
    }

