**TravelEasy**
An easy-to-use travel decision app that suggests destination taylored for you!

-Build with SwiftUI, including OOP, protocol-oriented design, MVVM architecture, centralized routing, error handling, testing, and Git version control.


##1. Concept Implementation
**OOP + Protocol-Oriented Design**
  - `Destination`, `TravelPreferences` as model structs
  - Enums (`Mood`, `DistanceBand`, `Transport`) with computed properties
  - `DestinationRepository` & `RecommendationStrategy` as protocols for data + algorithm abstraction
  - `LocalDestinationRepository` (concrete implementation) demonstrates polymorphism
  - `SimpleRecommendationStrategy` shows algorithm plug-in through dependency injection

**MVVM Architecture**
  - `RecommendationViewModel` as observable source of truth
  - Models are decoupled from UI, and strategies/repositories are injected

##2. UI Design
**Multi-step flow with centralized routing (`Screen` enum + NavigationStack.path`):**
  Page 1: Origin city input (default: Sydney, Australia) *will extend choice in future
  Page 2: Mood selection (4 types for now)
  Page 3: Distance selection or "Surprise Me"
  Page 4: Recommendation page with destination details
  
**Intuitive UI**
  - Mood and distance tiles
  - Clear button-based navigation, no hidden gestures
  - “Try Another” button resets state and returns directly to Mood page
  - Alerts show when no match occurs
  
##3. Error Handling
**Centralized AppError enum**
  - `invalidInput`, `noMatch`, `dataUnavailable`, `network`
  - Validation in TravelPreferences
  - Checks for empty origin and ensures mood + distance selected (unless surprise)

**UI Feedback**
  - `.alert(item:)` displays user-friendly error messages
  - Stays on current page if no match, avoiding empty navigation states
  - Recommendation page also supports “no match” empty state UI

##4. Testing and Debugging
**Unit Testing (XCTest)**
  - Verify strategy returns correct recommendations given mood + distance
  - Invalid inputs trigger `AppError.invalidInput`
  - No match case returns `AppError.noMatch`
**Debugging**
  - Used helper `debugCounts()` to inspect candidate filtering counts
  - Breakpoints to confirm `generateRecommendation()` updates VM state
  - Verified reset functions ('resetForEnteringMood()') work correctly


## 5. Version Control Usage
- Project tracked with Git and commit history
- https://github.com/kinolovestea/TravelEasy_v1.git


## 6. Documentation
**Source Code Documentation**
  - Each file begins with purpose comments
  - `Screen` enum annotated as central navigation routes
  - Models, ViewModel, and Views documented with comments
**README**
  - Explains architecture, features, error handling, and testing


## Future Work
- Integrate Weather API (placeholder in `RecommendationView`)
- Replace local repository with CoreData or CloudKit backend
- City autocomplete with Apple MapKit tool
- Add Saved Destinations feature (favorites)
- Support multi-user data sync
- Support more language

