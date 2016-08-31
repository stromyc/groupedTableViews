//
//  Event.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/23/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation

class Event {
	let title: String
	var time: NSDate
	init(title: String, time: NSDate) {
		self.title = title
		self.time = time
	}
	
	var dateFormatter = NSDateFormatter()
	func setDateFormatter() {
		dateFormatter.dateStyle = .ShortStyle
	}


}