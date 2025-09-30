// ShuntSenseMediaFeatures.swift - Aesthetic UI Upgrade with Logging

import SwiftUI
import PhotosUI
import AVFoundation
import UniformTypeIdentifiers
import AVKit

// MARK: - Color Palette
extension Color {
    static var background: Color { Color(hex: "#F1F7ED") }
    static var primaryText: Color { Color(hex: "#243E36") }
    static var accent: Color { Color(hex: "#7CA982") }
}

// MARK: - MediaEntry for Persistence
struct MediaEntry: Identifiable, Codable {
    let id: UUID
    let imageData: Data
    let date: Date

    init(image: UIImage, date: Date) {
        self.id = UUID()
        self.imageData = image.jpegData(compressionQuality: 0.8) ?? Data()
        self.date = date
    }

    var uiImage: UIImage? {
        UIImage(data: imageData)
    }
}

// MARK: - Home Button Style
struct HomeButtonLabel: View {
    let title: String
    var body: some View {
        Text(title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accent)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 4)
    }
}

// MARK: - Shunt Info Screen with Persistent Logging
struct ShuntInfoView: View {
    @AppStorage("shuntManufacturer") private var manufacturer: String = ""
    @AppStorage("shuntModel") private var model: String = ""
    @AppStorage("shuntSetting") private var setting: String = ""
    @AppStorage("shuntNotes") private var notes: String = ""
    @State private var changeDate: Date = Date()
    @State private var log: [String] = []

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Shunt Details").foregroundColor(.accent)) {
                    TextField("Manufacturer", text: $manufacturer)
                    TextField("Model Number", text: $model)
                    TextField("Setting", text: $setting)
                    DatePicker("Date of Change", selection: $changeDate, displayedComponents: .date)
                    TextField("Notes",text: $notes)
                        .frame(height: 100)

                    Button("Save Entry") {
                        let entry = "\(changeDate.formatted(date: .abbreviated, time: .omitted)) - \(manufacturer), \(model), Setting: \(setting)"
                        log.insert(entry, at: 0)
                        saveShuntLog()
                        notes = ""
                    }
                    .foregroundColor(.accent)
                }
            }
            Spacer()
            
            List {
                ForEach(log, id: \.self) { item in
                    Text(item)
                }
            }
        }
        .background(Color(hex: "#F1F7ED").ignoresSafeArea())
        .navigationTitle("Shunt Info")
        .onAppear(perform: loadShuntLog)
    }
  

    private func saveShuntLog() {
        UserDefaults.standard.set(log, forKey: "shuntLog")
    }

    private func loadShuntLog() {
        if let saved = UserDefaults.standard.stringArray(forKey: "shuntLog") {
            log = saved
        }
    }
}

// MARK: - Gait Video Screen with Persistent Storage
struct GaitVideoView: View {
    @State private var videoURLs: [URL] = []
    @State private var showVideoPicker = false
    @State private var showCameraAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                #if targetEnvironment(simulator)
                showCameraAlert = true
                #else
                showVideoPicker = true
                #endif
            }) {
                HomeButtonLabel(title: "Record Gait Video")
            }
            .background(Color(hex: "#F1F7ED").ignoresSafeArea())
            .alert("Camera not available in Simulator", isPresented: $showCameraAlert) {
                Button("OK", role: .cancel) {}
            }
            .sheet(isPresented: $showVideoPicker) {
                VideoPicker(onVideoPicked: { url in
                    saveVideo(url: url)
                })
            }

            ForEach(videoURLs, id: \.self) { url in
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding()
            }
        }
        .padding()
        .background(Color(hex: "#F1F7ED").ignoresSafeArea())
        .navigationTitle("Gait Videos")
        .onAppear(perform: loadVideos)
    }

    private func saveVideo(url: URL) {
        let fileManager = FileManager.default
        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destURL = documents.appendingPathComponent(url.lastPathComponent)
        do {
            if fileManager.fileExists(atPath: destURL.path) {
                try fileManager.removeItem(at: destURL)
            }
            try fileManager.copyItem(at: url, to: destURL)
            videoURLs.insert(destURL, at: 0)
            saveVideoPaths()
        } catch {
            print("Error saving video: \(error.localizedDescription)")
        }
    }

    private func saveVideoPaths() {
        let paths = videoURLs.map { $0.path }
        UserDefaults.standard.set(paths, forKey: "savedVideos")
    }

    private func loadVideos() {
        if let paths = UserDefaults.standard.stringArray(forKey: "savedVideos") {
            videoURLs = paths.compactMap { URL(fileURLWithPath: $0) }
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    let onVideoPicked: (URL) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [UTType.movie.identifier]
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: VideoPicker

        init(_ parent: VideoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.onVideoPicked(url)
            }
            picker.dismiss(animated: true)
        }
    }
}

// MARK: - Scan Upload Screen with Persistent Log
struct ScanUploadView: View {
    @State private var imageLog: [MediaEntry] = []
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                PhotosPicker("Upload CT/MRI Image", selection: $selectedItem, matching: .images)
                    .padding()
                    .background(Color.accent.opacity(0.1))
                    .cornerRadius(10)

                ForEach(imageLog) { entry in
                    if let image = entry.uiImage {
                        VStack(alignment: .leading, spacing: 6) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                            Text("Uploaded: \(entry.date.formatted(date: .abbreviated, time: .omitted))")
                                .font(.caption)
                                .foregroundColor(.primaryText)
                        }
                    }
                }
            }
            .padding()
        }
        .onChange(of: selectedItem) { _, newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    let newEntry = MediaEntry(image: image, date: Date())
                    imageLog.insert(newEntry, at: 0)
                    saveMediaLog()
                }
            }
        }
        .onAppear {
            loadMediaLog()
        }
        .background(Color.background)
        .navigationTitle("Scan Upload")
    }

    private func saveMediaLog() {
        if let encoded = try? JSONEncoder().encode(imageLog) {
            UserDefaults.standard.set(encoded, forKey: "imageLog")
        }
    }

    private func loadMediaLog() {
        if let savedData = UserDefaults.standard.data(forKey: "imageLog"),
           let decoded = try? JSONDecoder().decode([MediaEntry].self, from: savedData) {
            imageLog = decoded
        }
    }
}
