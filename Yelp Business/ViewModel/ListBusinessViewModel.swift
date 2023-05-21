//
//  ListBusinessViewModel.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import Foundation
import SwiftyJSON

class ListBusinessViewMode: ObservableObject {
    
    @Published var items : [Business] = [Business]()
    @Published var business : BusinessDetailModel = BusinessDetailModel(id: "", alias: "", name: "", imageURL: "", isClaimed: false, isClosed: false, url: "", phone: "", displayPhone: "", reviewCount: 0, categories: [Category](), rating: 0.0, location: Location(address1: "", displayAddress: [String]()), coordinates: Coordinates(latitude: 0.0, longitude: 0.0), photos: [String](), price: "")
    @Published var message: String = ""
    @Published var isLoading: Bool = true
    @Published var totalPage: Int = 0
    @Published var reviews: [Review] = [Review]()
    
    init() {
        
    }
    
    func getBusinsessList(location: String, term: String, latitude: String?, longitude: String?, offset: Int) {
        isLoading = true
        CallApiProvider().moyaProvider.request(.getListBusiness(location: location, term: term, latitude: latitude, longitude: longitude, offset: offset)) { result in
            switch result {
            case .success(let response):
                let data = JSON.init(response.data)
                if (response.statusCode == 200) {
                    do {
                        let responseModel = try JSONDecoder().decode(BusinessModel.self, from: response.data)
                        self.totalPage = responseModel.total
                        for business in responseModel.businesses {
                            self.items.append(business)
                        }
                        
                    } catch {
                        self.message = error.localizedDescription
                    }
                    self.isLoading = false
                    
                } else {
                    self.message = data["error"]["description"].stringValue
                }
            case .failure(let error):
                self.message = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func getBusinessDetail(id: String) {
        isLoading = true
        CallApiProvider().moyaProvider.request(.getBusinessDetail(id: id)) { result in
            switch result {
            case .success(let response):
                let data = JSON.init(response.data)
                if (response.statusCode == 200) {
                    do {
                        let responseModel = try JSONDecoder().decode(BusinessDetailModel.self, from: response.data)
                        self.business = responseModel
                    } catch {
                        self.message = error.localizedDescription
                    }
                    self.isLoading = false
                } else {
                    self.message = data["error"]["description"].stringValue
                }
            case .failure(let error):
                self.message = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func getBusinessReview(id: String, offset: Int) {
        isLoading = true
        CallApiProvider().moyaProvider.request(.getBusinessReview(id: id, offset: offset)) { result in
            switch result {
            case .success(let response):
                let data = JSON.init(response.data)
                if (response.statusCode == 200) {
                    do {
                        let responseModel = try JSONDecoder().decode(ReviewModel.self, from: response.data)
                        self.totalPage = responseModel.total
                        self.reviews = responseModel.reviews
                    } catch {
                        self.message = error.localizedDescription
                    }
                    self.isLoading = false
                } else {
                    self.message = data["error"]["description"].stringValue
                }
            case .failure(let error):
                self.message = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func clearBusinessList() {
        items.removeAll()
    }
}
