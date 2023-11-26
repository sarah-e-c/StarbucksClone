// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct GiftCard: Codable, Equatable {
    let category: GiftCategory
    let image: String
    
    static var example = GiftCard(category: .affection, image: "SuchAGiftFY24.jpg")
}

enum GiftCategory: String, Codable, CaseIterable {
    case featured = "Featured"
    case redCup = "Red Cup"
    case holiday = "Holiday"
    case birthday = "Birthday"
    case thankYou = "Thank You"
    case appreciation = "Appreciation"
    case celebration = "Celebration"
    case hanukkah = "Hanukkah | 12/7-12/15"
    case thanksgiving = "Thanksgiving"
    case encouragement = "Encouragement"
    case affection = "Affection"
    case workplace = "Workplace"
    case anytime = "Anytime"
}

typealias Welcome = [GiftCard]
