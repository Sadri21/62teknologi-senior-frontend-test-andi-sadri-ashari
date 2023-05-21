//
//  ReviewViewItem.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI
import Kingfisher

struct ReviewViewItem: View {
    
    @State var review = Review(id: "", url: "", text: "dawughiu oawifbaiofbaofba", rating: 3.4, timeCreated: "30.392.02 : 200", user: User(id: "", profileURL: "https://www.yelp.com/user_details?userid=e3fX7_qkoSm-6-yTdlwcXw", imageURL: "https://s3-media1.fl.yelpcdn.com/photo/Gh0D95PfvEMdM7YS2LSDUg/o.jpg", name: "hani fan"))
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage.url(URL(string: review.user.imageURL ?? "http://www.facebook.com/image"))
                    .placeholder {
                        Image("avatar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                
                
                
                VStack(alignment: .leading) {
                    Text(review.user.name)
                    Text(review.timeCreated)
                        .font(.system(size: 12))
                        .opacity(0.7)
                    FiveStarView(rating: Decimal(review.rating))
                        .frame(minWidth: 1, maxWidth: 80, minHeight: 1, maxHeight: 10, alignment: .center)
                }
                .padding(.leading, 8)
            }
            
            Text(review.text)
                .multilineTextAlignment(.leading)
                .opacity(0.8)
                .lineLimit(100)
                .padding(.top, 16)
            
            Divider()
            
        }
        
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
   

}

struct ReviewViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ReviewViewItem()
    }
}



