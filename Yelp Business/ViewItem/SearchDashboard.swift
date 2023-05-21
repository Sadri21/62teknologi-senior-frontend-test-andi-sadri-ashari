//
//  SearchDashboard.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI

struct SearchDashboard: View {
    
    @Binding var searchText: String
    @Binding var location: String
    @ObservedObject var locationViewModel: LocationViewModel
    @ObservedObject var businessViewModel: ListBusinessViewMode
    
    var body: some View {
        VStack {
            TextField("Search Business", text: $searchText)
                .frame(height: 10)
                .modifier(BorderView(cornerRadii: 10, lineWidht: 1, backgroundColor: Color("grey-light")))
            
            HStack {
                TextField("Location", text: $location)
                    .frame(height: 10)
                    .modifier(BorderView(cornerRadii: 10, lineWidht: 1, backgroundColor: Color("grey-light")))
                Button {
                    location = "Nearby me"
                    locationViewModel.requestAllowOnceLocationPermission()
                    print("\(locationViewModel.location.latitude), \(locationViewModel.location.longitude)")
                } label: {
                    Image("my-location")
                }
            }
            Button {
                businessViewModel.clearBusinessList()
                if (location != "Nearby me") {
                    businessViewModel.getBusinsessList(location: location, term: searchText, latitude: nil, longitude: nil, offset: 0)
                } else {
                    businessViewModel.getBusinsessList(location: "", term: searchText, latitude: "\(locationViewModel.location.latitude)", longitude: "\(locationViewModel.location.longitude)", offset: 0)
                }
            } label: {
                Text("Search")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 15)
            .modifier(ButtonModifier())
            .padding(.top, 16)
        }
    }
}

struct SearchDashboard_Previews: PreviewProvider {
    static var previews: some View {
        SearchDashboard(searchText: .constant(""), location: .constant(""), locationViewModel: LocationViewModel(), businessViewModel: ListBusinessViewMode())
    }
}
