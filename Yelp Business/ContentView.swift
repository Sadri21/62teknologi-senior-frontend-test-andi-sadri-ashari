//
//  ContentView.swift
//  Yelp Business
//
//  Created by mmbs on 18/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var location = "Nearby Me"
    @State private var isShowLoading = true
    @State private var loadingMessage = ""
    
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var businessViewModel = ListBusinessViewMode()
    
    var body: some View {
        NavigationView {
            GeometryReader {display in
                ZStack(alignment: .topLeading) {
                    
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: display.size.height, alignment: .bottom)
                        .opacity(0.5)
                    VStack(alignment: .leading) {
                        Image("yelp-ico")
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: display.size.width / 2)
                            .padding(.top, -40)
                        Text("Business list")
                        
                        ScrollView {
                            VStack(spacing: 0) {
                                SearchDashboard(searchText: $searchText, location: $location, locationViewModel: locationViewModel, businessViewModel: businessViewModel)
                            }
                            
                            LazyVStack(spacing: 16) {
                                ForEach(businessViewModel.items, id: \.self) { item in
                                    NavigationLink {
                                        DetailBusinessView(idBusiness: item.id)
                                    } label: {
                                        BusinessItemView(businessItem: item)
                                    }
                                    .buttonStyle(FlatLinkStyle())  
                                }
                                if (!businessViewModel.items.isEmpty && businessViewModel.totalPage > businessViewModel.items.count) {
                                    Text(". Loading .")
                                        .padding(.vertical, 16)
                                        .onAppear {
                                            if (location != "Nearby me") {
                                                businessViewModel.getBusinsessList(location: location, term: searchText, latitude: nil, longitude: nil, offset: businessViewModel.items.count )
                                            } else {
                                                businessViewModel.getBusinsessList(location: "", term: searchText, latitude: "\(locationViewModel.location.latitude)", longitude: "\(locationViewModel.location.longitude)", offset: businessViewModel.items.count)
                                            }
                                        }
                                }
                            }
                            .padding(.top, 46)
                            
                            if (businessViewModel.isLoading == false) {
                                if (businessViewModel.message == "") {
                                    if (businessViewModel.items.isEmpty) {
                                        Text("No Business Found in location")
                                            .font(.system(size: 24))
                                            .fontWeight(.bold)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                            .opacity(0.2)
                                            .padding(.top, 24)
                                    }
                                } else {
                                    Text(businessViewModel.message)
                                        .font(.system(size: 24))
                                        .fontWeight(.bold)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                        .opacity(0.2)
                                        .padding(.top, 24)
                                }
                            }
                        }
                    }
                    .padding(16)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .onReceive(locationViewModel.$loadingLocation) {_ in
                    print(locationViewModel.location)
                    if (locationViewModel.location.latitude != 0) {
                        isShowLoading = false
                        businessViewModel.getBusinsessList(location: "", term: searchText, latitude: "\(locationViewModel.location.latitude)", longitude: "\(locationViewModel.location.longitude)", offset: 0)
                    }
                }
                .onAppear {
                    locationViewModel.requestAllowOnceLocationPermission()
                    loadingMessage = "Please wait"
                }
                .customDialog(isShowing: $isShowLoading) {
                    LoadingDialog(message: $loadingMessage)
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text(""))
        }
        .navigationViewStyle(StackNavigationViewStyle())    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
