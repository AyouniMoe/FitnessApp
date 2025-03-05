//
//  HKWorkoutActivityType+Ext.swift
//  FitnessApp
//
//  Created by Mohamad Alayouni on 3/4/25.
//

import Foundation
import HealthKit
import SwiftUI

extension HKWorkoutActivityType {
    
    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .dance:                        return "Dance"
        case .danceInspiredTraining:        return "Dance Inspired Training"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"
            
            // iOS 10
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"
            
            // iOS 11
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"
            
            // iOS 13
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"
            
            // Catch-all
        default:                            return "Other"
        }
    }
    
    var image: String {
        let symbolName: String
        switch self {
        case .americanFootball:             symbolName = "figure.american.football"
        case .archery:                      symbolName = "figure.archery"
        case .australianFootball:           symbolName = "figure.australian.football"
        case .badminton:                    symbolName = "figure.badminton"
        case .baseball:                     symbolName = "figure.baseball"
        case .basketball:                   symbolName = "figure.basketball"
        case .bowling:                      symbolName = "figure.bowling"
        case .boxing:                       symbolName = "figure.boxing"
        case .climbing:                     symbolName = "figure.climbing"
        case .crossTraining:                symbolName = "figure.cross.training"
        case .curling:                      symbolName = "figure.curling"
        case .cycling:                      symbolName = "figure.cycling"
        case .dance:                        symbolName = "figure.dance"
        case .danceInspiredTraining:        symbolName = "figure.dance.inspired.training"
        case .elliptical:                   symbolName = "figure.elliptical"
        case .equestrianSports:             symbolName = "figure.equestrian.sports"
        case .fencing:                      symbolName = "figure.fencing"
        case .fishing:                      symbolName = "figure.fishing"
        case .functionalStrengthTraining:   symbolName = "figure.functional.strength.training"
        case .golf:                         symbolName = "figure.golf"
        case .gymnastics:                   symbolName = "figure.gymnastics"
        case .handball:                     symbolName = "figure.handball"
        case .hiking:                       symbolName = "figure.hiking"
        case .hockey:                       symbolName = "figure.hockey"
        case .hunting:                      symbolName = "figure.hunting"
        case .lacrosse:                     symbolName = "figure.lacrosse"
        case .martialArts:                  symbolName = "figure.martial.arts"
        case .mindAndBody:                  symbolName = "figure.mind.and.body"
        case .mixedMetabolicCardioTraining: symbolName = "figure.mixed.metabolic.cardio.training"
        case .paddleSports:                 symbolName = "figure.paddle.sports"
        case .play:                         symbolName = "figure.play"
        case .preparationAndRecovery:       symbolName = "figure.preparation.and.recovery"
        case .racquetball:                  symbolName = "figure.racquetball"
        case .rowing:                       symbolName = "figure.rowing"
        case .rugby:                        symbolName = "figure.rugby"
        case .running:                      symbolName = "figure.run"
        case .sailing:                      symbolName = "figure.sailing"
        case .skatingSports:                symbolName = "figure.skating.sports"
        case .snowSports:                   symbolName = "figure.snow.sports"
        case .soccer:                       symbolName = "figure.soccer"
        case .softball:                     symbolName = "figure.softball"
        case .squash:                       symbolName = "figure.squash"
        case .stairClimbing:                symbolName = "figure.stair.climbing"
        case .surfingSports:                symbolName = "figure.surfing.sports"
        case .swimming:                     symbolName = "figure.swimming"
        case .tableTennis:                  symbolName = "figure.table.tennis"
        case .tennis:                       symbolName = "figure.tennis"
        case .trackAndField:                symbolName = "figure.track.and.field"
        case .traditionalStrengthTraining:  symbolName = "figure.traditional.strength.training"
        case .volleyball:                   symbolName = "figure.volleyball"
        case .walking:                      symbolName = "figure.walking"
        case .waterFitness:                 symbolName = "figure.water.fitness"
        case .waterPolo:                    symbolName = "figure.water.polo"
        case .waterSports:                  symbolName = "figure.water.sports"
        case .wrestling:                    symbolName = "figure.wrestling"
        case .yoga:                         symbolName = "figure.yoga"
            
            // iOS 10
        case .barre:                        symbolName = "figure.barre"
        case .coreTraining:                 symbolName = "figure.core.training"
        case .crossCountrySkiing:           symbolName = "figure.cross.country.skiing"
        case .downhillSkiing:               symbolName = "figure.downhill.skiing"
        case .flexibility:                  symbolName = "figure.flexibility"
        case .highIntensityIntervalTraining: symbolName = "figure.high.intensity.interval.training"
        case .jumpRope:                     symbolName = "figure.jump.rope"
        case .kickboxing:                   symbolName = "figure.kickboxing"
        case .pilates:                      symbolName = "figure.pilates"
        case .snowboarding:                 symbolName = "figure.snowboarding"
        case .stairs:                       symbolName = "figure.stairs"
        case .stepTraining:                 symbolName = "figure.step.training"
        case .wheelchairWalkPace:           symbolName = "figure.wheelchair.walk.pace"
        case .wheelchairRunPace:            symbolName = "figure.wheelchair.run.pace"
            
            // iOS 11
        case .taiChi:                       symbolName = "figure.tai.chi"
        case .mixedCardio:                  symbolName = "figure.mixed.cardio"
        case .handCycling:                  symbolName = "figure.hand.cycling"
            
            // iOS 13
        case .discSports:                   symbolName = "figure.disc.sports"
        case .fitnessGaming:                symbolName = "figure.fitness.gaming"
            
            // Catch-all
        default:                            symbolName = "figure.other"
            
        }
        return symbolName
        
    }
    var color: UIColor {
        switch self {
        case .americanFootball:             return UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1) // Red
        case .archery:                      return UIColor(red: 0.4, green: 0.6, blue: 0.2, alpha: 1) // Green
        case .australianFootball:           return UIColor(red: 0.8, green: 0.5, blue: 0.2, alpha: 1) // Orange
        case .badminton:                    return UIColor(red: 0.9, green: 0.7, blue: 0.3, alpha: 1) // Light Yellow
        case .baseball:                     return UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1) // Blue
        case .basketball:                   return UIColor(red: 0.8, green: 0.4, blue: 0.1, alpha: 1) // Orange
        case .bowling:                      return UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) // Gray
        case .boxing:                       return UIColor(red: 0.9, green: 0.2, blue: 0.3, alpha: 1) // Red
        case .climbing:                     return UIColor(red: 0.5, green: 0.7, blue: 0.3, alpha: 1) // Olive Green
        case .crossTraining:                return UIColor(red: 0.7, green: 0.5, blue: 0.2, alpha: 1) // Dark Yellow
        case .curling:                      return UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1) // Blue
        case .cycling:                      return UIColor(red: 0.3, green: 0.8, blue: 0.4, alpha: 1) // Green
        case .dance:                        return UIColor(red: 1.0, green: 0.5, blue: 0.7, alpha: 1) // Pink
        case .danceInspiredTraining:        return UIColor(red: 0.9, green: 0.5, blue: 0.6, alpha: 1) // Light Pink
        case .elliptical:                   return UIColor(red: 0.6, green: 0.8, blue: 0.9, alpha: 1) // Light Blue
        case .equestrianSports:             return UIColor(red: 0.5, green: 0.4, blue: 0.2, alpha: 1) // Brown
        case .fencing:                      return UIColor(red: 0.8, green: 0.9, blue: 0.2, alpha: 1) // Yellow Green
        case .fishing:                      return UIColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 1) // Blue
        case .functionalStrengthTraining:   return UIColor(red: 0.7, green: 0.3, blue: 0.1, alpha: 1) // Brick Red
        case .golf:                         return UIColor(red: 0.1, green: 0.8, blue: 0.1, alpha: 1) // Golf Green
        case .gymnastics:                   return UIColor(red: 0.9, green: 0.6, blue: 0.3, alpha: 1) // Light Orange
        case .handball:                     return UIColor(red: 0.5, green: 0.3, blue: 0.7, alpha: 1) // Purple
        case .hiking:                       return UIColor(red: 0.5, green: 0.7, blue: 0.4, alpha: 1) // Forest Green
        case .hockey:                       return UIColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1) // Blue
        case .hunting:                      return UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1) // Brown
        case .lacrosse:                     return UIColor(red: 0.6, green: 0.7, blue: 0.1, alpha: 1) // Lime Green
        case .martialArts:                  return UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1) // Dark Red
        case .mindAndBody:                  return UIColor(red: 0.5, green: 0.5, blue: 0.8, alpha: 1) // Lavender
        case .mixedMetabolicCardioTraining: return UIColor(red: 0.9, green: 0.8, blue: 0.1, alpha: 1) // Bright Yellow
        case .paddleSports:                 return UIColor(red: 0.1, green: 0.5, blue: 0.6, alpha: 1) // Teal
        case .play:                         return UIColor(red: 1.0, green: 0.9, blue: 0.3, alpha: 1) // Light Yellow
        case .preparationAndRecovery:       return UIColor(red: 0.8, green: 0.9, blue: 0.8, alpha: 1) // Light Green
        case .racquetball:                  return UIColor(red: 0.7, green: 0.2, blue: 0.5, alpha: 1) // Purple
        case .rowing:                       return UIColor(red: 0.4, green: 0.7, blue: 0.9, alpha: 1) // Light Blue
        case .rugby:                        return UIColor(red: 0.7, green: 0.3, blue: 0.1, alpha: 1) // Rust Orange
        case .running:                      return UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1) // Bright Red
        case .sailing:                      return UIColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 1) // Sky Blue
        case .skatingSports:                return UIColor(red: 0.3, green: 0.4, blue: 0.8, alpha: 1) // Blue
        case .snowSports:                   return UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1) // Light Blue
        case .soccer:                       return UIColor(red: 0.2, green: 0.6, blue: 0.2, alpha: 1) // Green
        case .softball:                     return UIColor(red: 0.8, green: 0.4, blue: 0.1, alpha: 1) // Orange
        case .squash:                       return UIColor(red: 0.9, green: 0.7, blue: 0.1, alpha: 1) // Yellow
        case .stairClimbing:                return UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1) // Light Gray
        case .surfingSports:                return UIColor(red: 0.1, green: 0.8, blue: 0.9, alpha: 1) // Aqua Blue
        case .swimming:                     return UIColor(red: 0.3, green: 0.7, blue: 0.9, alpha: 1) // Ocean Blue
        case .tableTennis:                  return UIColor(red: 0.6, green: 0.1, blue: 0.4, alpha: 1) // Purple
        case .tennis:                       return UIColor(red: 0.9, green: 0.8, blue: 0.3, alpha: 1) // Light Yellow
        case .trackAndField:                return UIColor(red: 0.8, green: 0.2, blue: 0.3, alpha: 1) // Pink
        case .traditionalStrengthTraining:  return UIColor(red: 0.5, green: 0.2, blue: 0.1, alpha: 1) // Dark Brown
        case .volleyball:                   return UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1) // Gold
        case .walking:                      return UIColor(red: 0.8, green: 0.9, blue: 0.4, alpha: 1) // Lime Green
        case .waterFitness:                 return UIColor(red: 0.4, green: 0.8, blue: 0.9, alpha: 1) // Light Cyan
        case .waterPolo:                    return UIColor(red: 0.2, green: 0.3, blue: 0.6, alpha: 1) // Navy Blue
        case .waterSports:                  return UIColor(red: 0.3, green: 0.8, blue: 0.6, alpha: 1) // Seafoam Green
        case .wrestling:                    return UIColor(red: 0.6, green: 0.2, blue: 0.3, alpha: 1) // Burgundy
        case .yoga:                         return UIColor(red: 0.7, green: 0.6, blue: 0.9, alpha: 1) // Lavender
            
            // iOS 10
        case .barre:                        return UIColor(red: 0.9, green: 0.4, blue: 0.7, alpha: 1) // Pink
        case .coreTraining:                 return UIColor(red: 0.6, green: 0.4, blue: 0.6, alpha: 1) // Lavender
        case .crossCountrySkiing:           return UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1) // Ice Blue
        case .downhillSkiing:               return UIColor(red: 0.5, green: 0.7, blue: 0.9, alpha: 1) // Sky Blue
        case .flexibility:                  return UIColor(red: 0.9, green: 0.7, blue: 0.6, alpha: 1) // Peach
        case .highIntensityIntervalTraining: return UIColor(red: 0.8, green: 0.2, blue: 0.8, alpha: 1) // Magenta
        case .jumpRope:                     return UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1) // Coral
        case .kickboxing:                   return UIColor(red: 0.9, green: 0.1, blue: 0.3, alpha: 1) // Hot Pink
        case .pilates:                      return UIColor(red: 0.7, green: 0.8, blue: 0.6, alpha: 1) // Soft Green
        case .snowboarding:                 return UIColor(red: 0.9, green: 0.6, blue: 0.2, alpha: 1) // Gold
        case .stairs:                       return UIColor(red: 0.8, green: 0.7, blue: 0.5, alpha: 1) // Taupe
        case .stepTraining:                 return UIColor(red: 0.6, green: 0.7, blue: 0.3, alpha: 1) // Olive Green
        case .wheelchairWalkPace:           return UIColor(red: 0.5, green: 0.6, blue: 0.9, alpha: 1) // Light Blue
        case .wheelchairRunPace:            return UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1) // Royal Blue
            
            // iOS 11
        case .taiChi:                       return UIColor(red: 0.6, green: 0.8, blue: 0.6, alpha: 1) // Mint Green
        case .mixedCardio:                  return UIColor(red: 0.7, green: 0.7, blue: 0.2, alpha: 1) // Olive Green
        case .handCycling:                  return UIColor(red: 0.3, green: 0.5, blue: 0.9, alpha: 1) // Blue
            
            // iOS 13
        case .discSports:                   return UIColor(red: 0.9, green: 0.4, blue: 0.2, alpha: 1) // Orange
        case .fitnessGaming:                return UIColor(red: 0.5, green: 0.8, blue: 0.9, alpha: 1) // Light Blue
            
            // Catch-all
        default:                            return UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1) // Neutral Gray
        }
    }
}
