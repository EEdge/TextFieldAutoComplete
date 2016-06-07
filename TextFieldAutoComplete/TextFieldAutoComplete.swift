//
//  TextFieldAutoComplete.swift
//  TextFieldAutoComplete
//
//  Created by Evan Edge on 6/6/16.
//  Copyright © 2016 eedge. All rights reserved.
//

import Foundation
import UIKit

class TextFieldAutoComplete: UITextField {
    var dataSource: Array<String> //will hold entire data source
    var dataList: Array<String> //will be sorted, trimmed, etc. as user types
    
    required init? (coder aDecoder: NSCoder) {
        dataSource = []
        dataList = []
        super.init(coder: aDecoder)!
        addTarget(self, action: #selector(TextFieldAutoComplete.autoComplete), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func assignDataSource (data: Array<String>) {
        dataSource = data
        dataList = dataSource.sort()
    }
    
    @IBAction func autoComplete (){
        let range: UITextRange? = textRangeFromPosition(beginningOfDocument, toPosition: selectedTextRange!.start)
        
        let inputText = textInRange(range!)
        
        print("\(inputText)")
        
        if !dataList.isEmpty {
            for string in dataList {
                if string.lowercaseString.hasPrefix((inputText?.lowercaseString)!) {
                    displayAutoComplete(string, cursorPositionTextRange: selectedTextRange!)
                    break
                }
            }
        }
    }
    
    func displayAutoComplete (string: String, cursorPositionTextRange: UITextRange) {
        text = string
        selectedTextRange = cursorPositionTextRange
        let inputTextRange: UITextRange? = textRangeFromPosition(beginningOfDocument, toPosition: selectedTextRange!.start)
        let autoCompleteTextRange: UITextRange? = textRangeFromPosition(selectedTextRange!.start, toPosition: endOfDocument)
        attributedText = getColoredText(textInRange(inputTextRange!)!, autoCompleteText: textInRange(autoCompleteTextRange!)!)
        selectedTextRange = cursorPositionTextRange
        
        print("autocomplete portion: \(textInRange(autoCompleteTextRange!))")
    }
    
    
    //getColoredText adapted from https://stackoverflow.com/questions/14231879/is-it-possible-to-change-color-of-single-word-in-uitextview-and-uitextfield
    
    func getColoredText(inputText: String, autoCompleteText: String) -> NSMutableAttributedString {
        
        let text: NSMutableAttributedString = NSMutableAttributedString(string: (inputText + autoCompleteText))

        let range:NSRange = (text.string as NSString).rangeOfString(autoCompleteText)
        
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: range)
        
        return text
    }
}