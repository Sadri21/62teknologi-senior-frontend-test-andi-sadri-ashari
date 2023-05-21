//
//  BusinessItemView.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI
import Kingfisher

struct BusinessItemView: View {
    
    @State var businessItem : Business
//    @State var exampleimage = "https://s3-media1.fl.yelpcdn.com/bphoto/8pUo1PBnQ6SCC86LUo-cIg/o.jpg"

    
    var body: some View {
        VStack(alignment: .leading) {
                KFImage.url(URL(string: businessItem.imageURL))
                    .placeholder {
                        Image("image-placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                            .cornerRadius(10)
                            .clipped()
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                    .cornerRadius(10)
                    .clipped()
                Text(businessItem.name)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .lineLimit(100)
                  
                  
                  
                 
                HStack {
                    FiveStarView(rating: Decimal(businessItem.rating), color: Color("primary"))
                        .frame(minWidth: 1, maxWidth: 120, minHeight: 1, maxHeight: 16, alignment: .center)
                        
                    Text("\(businessItem.reviewCount) Reviews")
                        .opacity(0.7)
                }
                
                HStack {
                    Image("pin-location")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color("primary"))
                    
                    Group {
                        Text("\(businessItem.location.address1 ?? ""),")
                        Text("price")
                        Text("\(businessItem.price ?? "")")
                            .foregroundColor(Color("green"))
                    }
                    .font(.system(size: 14))
                    .opacity(0.7)
                }
        
              
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(businessItem.categories, id: \.self) { category in
                        CategoryView(text: category.title)
                    }
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
                
               
                
            
                    
                    
            }
            .padding()
            .background(Color.white)
            .modifier(CardBackground())
            .padding(.horizontal, 16)
            .foregroundColor(.black)

           
        
    }
}

struct BusinessItemView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessItemView(businessItem: Business(id: "", alias: "", name: "Konditori", imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/8pUo1PBnQ6SCC86LUo-cIg/o.jpg", isClosed: true, reviewCount: 21, categories: [Category](), rating: 3.4, price: "$$$", location: Location(address1: "jln 1 de", displayAddress: [String]()), phone: "832088023", distance: 2.3, displayPhone: "233223"))
    }
}
