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

## Screenshots

*(It is highly recommended to add screenshots of your app here to showcase the UI)*

| Login Screen | Home Screen | Symptom Logging |
| :----------: | :---------: | :-------------: |
|  *(image)*  |  *(image)*  |    *(image)*   |

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
-   A free [Supabase](https://supabase.com) account.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/shuntsense.git
    cd shuntsense
    ```

2.  **Set up the Supabase Backend:**
    -   Log in to your Supabase account and create a new project.
    -   Navigate to the **SQL Editor** and run the schema script found in `backend_schema.sql` (or copy the schema from the section below) to create the necessary tables (`profiles`, `symptom_logs`, etc.).
    -   Navigate to the **Storage** section and create two new public buckets: `mri_scans` and `gait_videos`.
    -   Go to **Project Settings > API** to find your Project URL and `anon` public key.

3.  **Configure Environment Keys:**
    -   In Xcode, right-click on the project navigator and select "New File...".
    -   Choose the "Property List" template and name the file `Supabase-Keys.plist`.
    -   **Important:** Make sure this file is added to your `.gitignore` to keep your keys secure!
    -   Open the `Supabase-Keys.plist` file and add two new rows:
        -   Key: `SUPABASE_URL`, Type: `String`, Value: `YOUR_SUPABASE_PROJECT_URL`
        -   Key: `SUPABASE_ANON_KEY`, Type: `String`, Value: `YOUR_SUPABASE_ANON_KEY`
    -   Your `.plist` file's source code should look like this:
        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>SUPABASE_URL</key>
            <string>https://your-project-id.supabase.co</string>
            <key>SUPABASE_ANON_KEY</key>
            <string>your-long-anon-public-key</string>
        </dict>
        </plist>
        ```

4.  **Open and Run the Project:**
    -   Open the `.xcodeproj` or `.xcworkspace` file in Xcode.
    -   Select your target device or simulator and press `Cmd+R` to build and run the app.

## Backend Schema

Here is the SQL schema required for the Supabase database.

```sql
-- Profiles table to store user information
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  full_name TEXT,
  date_of_birth DATE,
  shunt_type TEXT
);

-- Symptom Logs table
CREATE TABLE symptom_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  cognitive_score SMALLINT,
  gait_score SMALLINT,
  urinary_score SMALLINT,
  severity TEXT,
  frequency TEXT,
  onset_trend TEXT,
  walk_test_seconds REAL,
  notes TEXT
);

-- MRI Logs table
CREATE TABLE mri_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  image_url TEXT,
  doctors_notes TEXT,
  evans_index REAL
);

-- Gait Videos table
CREATE TABLE gait_videos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  video_url TEXT
);

-- Enable Row Level Security (RLS) on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE symptom_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE mri_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE gait_videos ENABLE ROW LEVEL SECURITY;

-- Create policies to allow users to manage their own data
CREATE POLICY "Users can manage their own profile" ON profiles FOR ALL USING (auth.uid() = id);
CREATE POLICY "Users can manage their own symptom logs" ON symptom_logs FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their own MRI logs" ON mri_logs FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their own gait videos" ON gait_videos FOR ALL USING (auth.uid() = user_id);
