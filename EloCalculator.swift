//
//  EloCalculator.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/16/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation



// Scoring Delegate
// calcuateScore
// updateScore
// add ScoringDelegate to scoring table
protocol ScoreCalculatorDelegate {
	func calculatePlayerScores(playerOneCurrentScore: Double, playerTwoCurrentScore: Double, kFactor: KFactor) -> (playerOneNewScore: Double,
		playerTwoNewScore: Double)
	func updateScore(playerOne: Double, playerTwo: Double) -> String
}

enum KFactor {
	case twenty
	case thirty
	case forty
	
	var currentKFactor : Double {
		switch self {
		case .twenty: return 20.0
		case .thirty: return 30.0
		case .forty: return 40.0
		}
	}
}







	

class EloCalculator : ScoreCalculatorDelegate {
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
    var ratingPlayerOne : Double = 0.0
    var ratingPlayerTwo : Double = 0.0
	
	
	
	
	
	
	
    enum Outcome {
        case win
        case lost
        case draw
        
        var score : Double {
            switch self {
            case win : return 1.0
            case lost : return 0.0
            case draw : return 0.5
            }
        }
        
        var stringRawValue : String {
            switch self {
            case win : return "Win"
            case lost : return "Lost"
            case draw : return "Draw"
            }
        }
        
    }
	
	// Mark: ScoreCalculatorDelegate
	
	func calculatePlayerScores( playerOneCurrentScore : Double, playerTwoCurrentScore : Double, kFactor: KFactor = KFactor.thirty) -> (playerOneNewScore: Double, playerTwoNewScore: Double) {
		
		var ratingA = (playerOneCurrentScore)
		var ratingB = (playerTwoCurrentScore)
		
		// Determines expected rating.
		func eRating(ratingA: Double, ratingB: Double) -> Double {
			let exponent = (ratingB - ratingA)/400
			let raised = pow(10, exponent)
			return 1 / (raised + 1)
		}
		
		
		// Calculate the expected rating for each player.
		var aExpectedScore = eRating(ratingA, ratingB: ratingB)
		var bExpectedScore = eRating(ratingB, ratingB: ratingA)
		
		// Score for match 1 = win, 0 = lost, .5 = draw
		var aScore = playerOneCurrentScore
		var bScore: Double {
			
			
			// Returns the opposite score for the opponent or draw.
			switch aScore {
			case 1.0 : return 0.0
			case 0.5 : return 0.5
			case 0.0 : return 1.0
			default : return 9999.0
			}
			
			
		}
		
		let aNewElo = (kFactor.currentKFactor * (aScore - aExpectedScore)) + ratingA
		
		ratingPlayerOne = aNewElo
		
		let bNewElo = (kFactor.currentKFactor * (bScore - bExpectedScore)) + ratingB
		
		ratingPlayerTwo = bNewElo
		
		return (round(aNewElo), (round(bNewElo)))
		
		
		
	}
	
	
	func updateScore(playerOne: Double, playerTwo: Double) -> String {
		let string = ("Player One score: \(playerOne), Player Two score: \(playerTwo)")
		print(string)
		return string
	}
	
	
	
    // EloRating expected rating formula where:
    // rB = rating for player 2
    // rA = rating for player 1
    // Ea = expected rating
    
    // Ea =  1/ {1 + (10 ^ (rB - rA)/400)}
    
    
    // EloRating new rating formula where:
    // rA = rating for player 1
    // K = KFactor 20,30,40
    // Sa = Score 1 = win, 0 = loss, .5 = draw
    // EaNew = rA + K(Sa - Ea)
	
	/*
	var ratingPlayerOne : Double = 0.0
	var ratingPlayerTwo : Double = 0.0
	
	
	enum KFactor {
		case twenty
		case thirty
		case forty
		
		var currentKFactor : Double {
			switch self {
			case .twenty: return 20.0
			case .thirty: return 30.0
			case .forty: return 40.0
			}
		}
	}
	
	
	
	
	
	enum Outcome {
		case win
		case lost
		case draw
		
		var score : Double {
			switch self {
			case win : return 1.0
			case lost : return 0.0
			case draw : return 0.5
			}
		}
		
		var stringRawValue : String {
			switch self {
			case win : return "Win"
			case lost : return "Lost"
			case draw : return "Draw"
			}
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	func calculatePlayerScores( playerOneCurrentScore : Double, playerTwoCurrentScore : Double, kFactor: KFactor = KFactor.thirty, matchOutcomePlayerOne: Outcome) -> (playerOneNewScore: Double, playerTwoNewScore: Double) {
		
		var ratingA = (playerOneCurrentScore)
		var ratingB = (playerTwoCurrentScore)
		
		// Determines expected rating.
		func eRating(ratingA: Double, ratingB: Double) -> Double {
			let exponent = (ratingB - ratingA)/400
			let raised = pow(10, exponent)
			return 1 / (raised + 1)
		}
		
		
		// Calculate the expected rating for each player.
		var aExpectedScore = eRating(ratingA, ratingB: ratingB)
		var bExpectedScore = eRating(ratingB, ratingB: ratingA)
		
		// Score for match 1 = win, 0 = lost, .5 = draw
		var aScore = matchOutcomePlayerOne.score
		var bScore: Double {
			
			
			// Returns the opposite score for the opponent or draw.
			switch aScore {
			case 1.0 : return 0.0
			case 0.5 : return 0.5
			case 0.0 : return 1.0
			default : return 9999.0
			}
			
			
		}
		
		let aNewElo = (kFactor.currentKFactor * (aScore - aExpectedScore)) + ratingA
		
		ratingPlayerOne = aNewElo
		
		let bNewElo = (kFactor.currentKFactor * (bScore - bExpectedScore)) + ratingB
		
		ratingPlayerTwo = bNewElo
		
		return (round(aNewElo), (round(bNewElo)))
		
	}
	
	let calc = calculatePlayerScores(300, playerTwoCurrentScore: 500, kFactor: KFactor.forty, matchOutcomePlayerOne: .win)
	
	
	
	calc.playerOneNewScore
	calc.playerTwoNewScore
*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	func calculatePlayerNewScores( playerOne : PlayerInfoEntity, playerTwo : PlayerInfoEntity, kFactor: KFactor = KFactor.thirty) -> (playerOneNewScore: Float, playerTwoNewScore: Float) {
//		
//		var ratingA = playerOne.score as Float
//		var ratingB = playerTwo.score as Float
//		
//		// Determines expected rating.
//		func eRating(ratingA: Float, ratingB: Float) -> Float {
//			let exponent = (ratingB - ratingA)/400
//			let raised = pow(10, exponent)
//			return 1 / (raised + 1)
//		}
//		
//		
//		// Calculate the expected rating for each player.
//		var aExpectedScore = eRating(ratingA, ratingB: ratingB)
//		var bExpectedScore = eRating(ratingB, ratingB: ratingA)
//		
//		// Score for match 1 = win, 0 = lost, .5 = draw
//		var aScore = playerOne.score as Float
//		var bScore: Float {
//			
//			
//			// Returns the opposite score for the opponent or draw.
//			switch aScore {
//			case 1.0 : return 0.0
//			case 0.5 : return 0.5
//			case 0.0 : return 1.0
//			default : return 9999.0
//			}
//			
//			
//		}
//		
//		let aNewElo = (kFactor.currentKFactor * (aScore - aExpectedScore)) + ratingA
//		
//		ratingPlayerOne = aNewElo
//		
//		let bNewElo = (kFactor.currentKFactor * (bScore - bExpectedScore)) + ratingB
//		
//		ratingPlayerTwo = bNewElo
//		
//		return (round(aNewElo), round(bNewElo))
//		
//		
//		
//	}
//	
//	
//	
//	
//    func newEloRating(ratingA: Float, ratingB: Float, playerOneScore: Outcome, kFactor: KFactor) -> (playerOneElo: Float, playerTwoElo: Float) {
//		
//        // Determines expected rating.
//        func eRating(ratingA: Float, ratingB: Float) -> Float {
//            let exponent = (ratingB - ratingA)/400
//            let raised = pow(10, exponent)
//            return 1 / (raised + 1)
//        }
//        
//        
//        // Calculate the expected rating for each player.
//        var aExpectedScore = eRating(ratingA, ratingB: ratingB)
//        var bExpectedScore = eRating(ratingB, ratingB: ratingA)
//        
//        // Score for match 1 = win, 0 = lost, .5 = draw
//        var aScore = playerOneScore.score
//        var bScore: Float {
//            
//            
//            // Returns the opposite score for the opponent or draw.
//            switch aScore {
//            case 1.0 : return 0.0
//            case 0.5 : return 0.5
//            case 0.0 : return 1.0
//            default : return 9999.0
//            }
//            
//            
//        }
//        
//        let aNewElo = (kFactor.currentKFactor * (aScore - aExpectedScore)) + ratingA
//        
//        ratingPlayerOne = aNewElo
//        
//        let bNewElo = (kFactor.currentKFactor * (bScore - bExpectedScore)) + ratingB
//        
//        ratingPlayerTwo = bNewElo
//        
//        return (round(aNewElo), round(bNewElo))
//        
//    }
}
