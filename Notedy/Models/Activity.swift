//
//  Activity.swift
//  Notedy
//
//  Created by Nuntapat Hirunnattee on 3/8/2565 BE.
//

import Foundation
import RealmSwift


class Activity: Object{
    @Persisted var title: String = ""
    @Persisted var location: String = ""
    @Persisted var time: String
    @Persisted var date: String
    @Persisted var detail: String = ""
}
