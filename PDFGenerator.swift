//
//  PDFGenerator.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/25/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit


var currentText = CFAttributedStringCreate(nil, "Test String to Create PDF", nil)

var frameSetter = CTFramesetterCreateWithAttributedString(currentText)
var pdfFileName = "Test File One"

func makePDFPage() {
	UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil)

	var currentRange = CFRange(location: 0, length: 0)
	var currentPage : Int = 0
	var done = false
	
	
	// Mark the beginning of a new page.
		UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil)
	



}



