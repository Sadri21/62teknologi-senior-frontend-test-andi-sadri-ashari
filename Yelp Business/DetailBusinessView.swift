//
//  DetailBusinessView.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI
import Kingfisher
import ACarousel
import Kingfisher
import MapKit

struct DetailBusinessView: View {
    
    @State var businessItem : BusinessDetailModel = BusinessDetailModel(id: "", alias: "", name: "test 123 business model dan mati", imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/8pUo1PBnQ6SCC86LUo-cIg/o.jpg", isClaimed: false, isClosed: true, url: "https://www.yelp.com/biz/konditori-singapore?adjust_creative=DSj6I8qbyHf-Zm2fGExuug&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=DSj6I8qbyHf-Zm2fGExuug", phone: "dawiawdhoi", displayPhone: "901234u0194", reviewCount: 2, categories: [Category(alias: "", title: "gaga"), Category(alias: "", title: "giman")], rating: 2, location: Location(address1: "", displayAddress: [String]()), coordinates: Coordinates(latitude: 0.0, longitude: 0.0), photos: ["https://s3-media1.fl.yelpcdn.com/bphoto/8pUo1PBnQ6SCC86LUo-cIg/o.jpg", "https://s3-media2.fl.yelpcdn.com/bphoto/q8vwl8vKe1--NvImvQzDMA/o.jpg"], price: "$$$")
    
    @State var idBusiness: String = ""
    @StateObject private var businessViewModel = ListBusinessViewMode()
    
    var body: some View {
        GeometryReader { display in
            ScrollView {
                VStack(alignment: .leading) {
                    if (!businessViewModel.business.photos.isEmpty) {
                        ACarousel(businessViewModel.business.photos, id: \.self,  spacing: 16,
                                  headspace: 10,
                                  sidesScaling: 0.7, autoScroll: .active(15)) { photos in
                            KFImage.url(URL(string: photos))
                                .placeholder({
                                    Image("image-placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                                        .cornerRadius(10)
                                        .clipped()
                                })
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                                .cornerRadius(10)
                                .clipped()
                            
                        }
                                  .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                    } else {
                        Image("image-placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                            .cornerRadius(10)
                            .clipped()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(businessViewModel.business.name)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .lineLimit(100)
                        
                        
                        
                        HStack {
                            FiveStarView(rating: Decimal(businessViewModel.business.rating), color: Color("primary"))
                                .frame(minWidth: 1, maxWidth: 120, minHeight: 1, maxHeight: 16, alignment: .center)
                            
                            Text("\(businessViewModel.business.reviewCount) Reviews")
                                .opacity(0.7)
                        }
                        
                        HStack {
                            Image("pin-location")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color("primary"))
                            
                            Group {
                                Text("\(businessViewModel.business.location.address1 ?? ""),")
                                Text("price")
                                Text("\(businessViewModel.business.price ?? "-" )")
                                    .foregroundColor(Color("green"))
                            }
                            .font(.system(size: 14))
                            .opacity(0.7)
                            
                            Spacer()
                            Button {
                                let url = URL(string: "maps://?ll=\(businessViewModel.business.coordinates.latitude),\(businessViewModel.business.coordinates.longitude)")
                                if UIApplication.shared.canOpenURL(url!) {
                                      UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                                }
                            } label: {
                                Image("map")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .padding(.trailing, 24)
                                    .foregroundColor(Color.blue)
                            }

                            
                        }
                        
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(businessViewModel.business.categories, id: \.self) { category in
                                    CategoryView(text: category.title)
                                }
                                
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                        }
                        
                        Text("User Review")
                        Divider()
                        
                        LazyVStack {
                            ForEach(businessViewModel.reviews, id: \.self) { review in
                                ReviewViewItem(review: review)
                            }
                        }
                        
                        
                    }
                    .padding(16)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Business Detail")
        .onAppear {
            businessViewModel.getBusinessDetail(id: idBusiness)
            businessViewModel.getBusinessReview(id: idBusiness, offset: 0)
        }
    }
}

struct DetailBusinessView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBusinessView()
    }
}
