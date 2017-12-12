//
//  Users.swift
//  InClass04
//
//  Created by Deshpande, Vikas on 9/28/17.
//  Copyright © 2017 Deshpande, Vikas. All rights reserved.
//

import Foundation

class Users{
    var userName:String = ""
    var userEmail:String = ""
    var userPassword:String = ""
    var userDepartment:String = ""
    
    init(userName:String,userEmail:String,userPassword:String,userDepartment:String){
        self.userDepartment = userDepartment
        self.userEmail = userEmail
        self.userName = userName
        self.userPassword = userPassword
    }
    
    init(){}
    
}
