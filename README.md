# ShuntSense-0
An iOS application for Normal Pressure Hydrocephalus (NPH) patients to track symptoms, manage medical data, and access educational resources. Built with SwiftUI
# ShuntSense

![Swift Version](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%2016%2B-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

**ShuntSense** is a secure, user-friendly iOS application designed to empower patients diagnosed with Normal Pressure Hydrocephalus (NPH). Developed for a predominantly geriatric audience, the app provides a simple and accessible way to track symptoms, manage care, and understand their condition, bridging the communication gap between patients and clinicians.

## About The Project

Normal Pressure Hydrocephalus (NPH) is often misdiagnosed as normal aging, Alzheimer's, or Parkinson's. Patients struggle with understanding their condition and tracking the progression of their symptoms—gait disturbances, cognitive decline, and urinary incontinence (the Hakim's Triad).

ShuntSense was created to address this gap. It replaces unreliable paper logs and overly complex generic health apps with a streamlined, NPH-specific tool. The app focuses on security, simplicity, and accessibility, ensuring that even patients unfamiliar with technology can confidently manage their health journey.

The user interface is inspired by Google's Material 3 design principles, adapted natively in SwiftUI to create a clean, high-contrast, and intuitive experience that feels at home on iOS.

## Core Features

-   **Secure Authentication:** Full user account creation and login powered by Supabase Auth.
-   **Daily Symptom Logging:** Quantitatively track the Hakim's Triad (Cognitive, Gait, Urinary) using simple 0-10 sliders.
-   **Qualitative Tracking:** Log symptom severity, frequency, and onset trends (Worsening, Stable, Improving).
-   **10-Meter Walk Test:** An integrated timer to objectively measure gait performance.
-   **Symptom History:** View a chronological history of all logged symptoms to visualize trends over time.
-   **Health Profile Management:**
    -   **Shunt Information:** Save the specific type and model of the user's shunt.
    -   **MRI Scan Log:** Upload MRI images, attach doctor's notes, and record the Evans' Index.
    -   **Gait Video Journal:** Record and store videos to visually track changes in gait.
-   **Appointment Scheduling:** A simple scheduler to keep track of upcoming doctor visits.
-   **NPH Education Hub:** Access curated articles and embedded YouTube videos explaining NPH.
-   **Resource Center:** Quick links to the Hydrocephalus Association and other support networks.
-   **AI Chatbot:** An NPH-trained chatbot to answer patient questions in simple, understandable language.


## Tech Stack

-   **Frontend:** SwiftUI, Swift
-   **Backend:** Supabase
    -   **Database:** Supabase Postgres
    -   **Authentication:** Supabase Auth
    -   **Storage:** Supabase Storage (for MRI images and gait videos)
-   **Platform:** iOS 16.0+
-   **IDE:** Xcode 15+

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

-   macOS with Xcode 15 or later installed.
