//
//  ResourcesView.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 3/10/25.
//
import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Hydrocephalus Association Section
                    SectionView(
                        title: "Hydrocephalus Association",
                        description: "Visit the Hydrocephalus Association for comprehensive information and support.",
                        linkTitle: "Visit Website",
                        url: URL(string: "https://www.hydroassoc.org/")!
                    )
                    
                    // Support Group Meetings Section
                    SectionView(
                        title: "Support Group Meetings",
                        description: "Connect with local community networks for support and information.",
                        linkTitle: "Find a Community Network",
                        url: URL(string: "https://www.hydroassoc.org/find-a-community-network/")!
                        
                        
                    )
                    
                    SectionView(
                        title: "OC Support Group",
                        description: "In partnership with the Hydrocephalus Association, the Orange County California virtual NPH support group is led by Dr. Jefferson Chen. This group has been created to share additional resources, information, and support offered to individuals and families affected by NPH.",
                        linkTitle: "Get Support",
                        url: URL(string: "https://www.hydroassoc.org/event/virtual-meetup-orange-county-ca-nph-support-group-meeting-2/")!
                    )
                    
                    // Educational Resources Section
                    SectionView(
                        title: "Educational Resources",
                        description: "Access educational articles, videos, and FAQs to learn more about hydrocephalus.",
                        linkTitle: "Explore Resources",
                        url: URL(string: "https://www.hydroassoc.org/resources/")!
                    )
                    
                    // Additional Support Section
                    SectionView(
                        title: "Additional Support",
                        description: "Get comprehensive help and support from the Hydrocephalus Association.",
                        linkTitle: "Get Support",
                        url: URL(string: "https://www.hydroassoc.org/get-support/")!
                    )
                    
                    // Helpline Section
                    SectionView(
                        title: "Helpline",
                        description: "Contact the Hydrocephalus Association's helpline for personalized assistance.",
                        linkTitle: "Contact Helpline",
                        url: URL(string: "https://www.hydroassoc.org/helpline/")!
                    )
                }
                .padding()
            }
            .navigationTitle("Resources")
        }
    }
}

struct SectionView: View {
    let title: String
    let description: String
    let linkTitle: String
    let url: URL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(hex: "#243E36"))
            Text(description)
                .font(.subheadline)
                .foregroundColor(Color(hex: "#243E36"))
            Link(linkTitle, destination: url)
                .font(.body)
                .foregroundColor(.blue)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color(hex: "#E0EEC6"))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(hex: "#F1F7ED"))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}




