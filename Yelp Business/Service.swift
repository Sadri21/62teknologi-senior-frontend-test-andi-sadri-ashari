//
//  Service.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import Moya

public enum Service {
    case getListBusiness(location: String, term: String, latitude: String?, longitude: String?, offset: Int)
    case getBusinessDetail(id: String)
    case getBusinessReview(id: String, offset: Int)
}

let serviceClosure = { (target: Service) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    let token = "Ubf1-f0uqsJUnssqPMGo-tiFeZTT85oFmKfznlPmjDtX8s83jYMoAb-ApuD63wgq6LDZNsUXG6gurZIVYaj2jzxJmmLdCdXbDqIHU_b6KiCEVi8v-YB0OSsW6MWaY3Yx"
    switch target {
    case .getListBusiness, .getBusinessDetail, .getBusinessReview:
        return defaultEndpoint
            .adding(newHTTPHeaderFields: ["Authorization": "Bearer \(token)"])
    }
}

extension Service: TargetType {
    public var baseURL: URL {
        return URL(string:"https://api.yelp.com/v3/businesses/")!
    }
    
    public var path: String {
        switch self {
        case .getListBusiness:
            return "search"
        case .getBusinessDetail(id: let id):
            return "\(id)"
        case .getBusinessReview(id: let id, offset: _):
            return "\(id)/reviews"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getListBusiness, .getBusinessDetail, .getBusinessReview:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getListBusiness(location: let location, term: let term, latitude: let latitude, longitude: let longitude, offset: let offset):
            var paramter = [String:String]()
            paramter["term"] = term
            paramter["sort_by"] = "best_match"
            paramter["offset"] = "\(offset)"
            if (latitude == nil || longitude == nil) {
                paramter["location"] = location
            } else {
                paramter["latitude"] = latitude!
                paramter["longitude"] = longitude!
            }
            return .requestParameters(parameters: paramter, encoding: URLEncoding.queryString)
        case .getBusinessDetail:
            return .requestPlain
        case .getBusinessReview(id:  _, offset: let offset):
            return .requestParameters(parameters: ["offset" : offset, "sort_by" : "yelp_sort"], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}


class CallApiProvider {
    let moyaProvider = MoyaProvider<Service>(endpointClosure: serviceClosure, plugins: [NetworkLoggerPlugin()])
}
