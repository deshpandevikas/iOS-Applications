    //
    //  NoteBook.swift
    //  InClass06App
    //
    //  Created by Deshpande, Vikas on 10/21/17.
    //  Copyright © 2017 Example. All rights reserved.
    //

    import Foundation

    class NoteBook{
        var name:String = ""
        var identifier:String = ""
        var date:String = ""
        
        init(name:String,identifier:String,date:String){
            self.name = name
            self.identifier = identifier
            self.date = date
        }
        init(){}
    }
