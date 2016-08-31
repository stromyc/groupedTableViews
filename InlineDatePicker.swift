//
//  InlineDatePicker.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/23/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation

class InlineDatePicker {
	
	// Date pickerCell
	var datePickerCell : NSIndexPath?
	var rows = 0
	var dateCellRows = 1
	
	var date = NSDate()
	var dateFormatter : NSDateFormatter = {
		let formatter = NSDateFormatter()
		formatter.dateStyle = .ShortStyle
		return formatter
	}()
	
	func dateString() -> String {
		return dateFormatter.stringFromDate(date)
	}
	
	
}