//
//  EventAPI+Requests.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
//import RxSwift
//import Wrap
//
//extension EventsAPI {
//    
//    static func rx_getEvent(_ eventRequest: EventRequest) -> Observable<Event> {
//        return EventsAPI
//            .getEvent(id: eventRequest.id, query: try? wrap(eventRequest))
//            .validatedRequest()
//            .rx_responseModel(Event.self)
//    }
//    
//    static func rx_getEvents(_ parameters: EventsRequest) -> Observable<[Event]> {
//        do {
//            let requestDict: WrappedDictionary = try wrap(parameters)
//            return EventsAPI
//                .getEvents(reqestModel: requestDict)
//                .validatedRequest()
//                .rx_responseModelsArray(Event.self, at: "data")
//        } catch let e {
//            return Observable.error(ModelError.wrappingError(error: e, type: EventRequest.self))
//        }
//    }
//}
