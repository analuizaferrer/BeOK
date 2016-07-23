//
//  AddRecordView3.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/16/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation

class AddRecordView3: UIView, UITextViewDelegate {
    
    var descriptionLabel = UILabel(frame: CGRectMake(14.53,91,400,18))
    var descriptionTextView = UITextView()
    var pageCounter = UIImageView()
    var placeholder = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.descriptionLabel.text = "What went through your head?"
        self.descriptionLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(descriptionLabel)
        
        placeholder.frame = CGRectMake(5.0, 0, self.frame.width - 10, 30)
        placeholder.text = "Write any relevant information"
        placeholder.textColor = UIColor.lightGrayColor()
        placeholder.textAlignment = .Left
      
        descriptionTextView = UITextView(frame: CGRectMake(14.53,121,self.frame.width - 29.06,100))
        descriptionTextView.addSubview(placeholder)
        descriptionTextView.delegate = self
        descriptionTextView.font = UIFont.systemFontOfSize(15)
        descriptionTextView.contentOffset = CGPointZero
        self.addSubview(descriptionTextView)
        
        pageCounter = UIImageView(frame: CGRectMake(self.frame.midX - 65.5, self.frame.height - 39, 131, 26))
        
        self.pageCounter.image = UIImage(named: "PageCounter3")
        self.addSubview(pageCounter)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        
    }
    
    func textViewDidChange(textView: UITextView) {
        if descriptionTextView.text.characters.count != 0 {
            placeholder.text = ""
        } else {
            placeholder.text = "Write any relevant information"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
}