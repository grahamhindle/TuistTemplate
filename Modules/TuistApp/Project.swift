import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.tuist(module: .app("TuistApp", [
    .project(target: "UIFramework", path: "../UIFramework")
]))


// MARK: - Known Issues

/*
Issues:
1. Hot Reloading Setup
   - Currently using Inject package for hot reloading
   - Only works in DEBUG configuration
   - Requires manual .enableInjection() and @ObserveInjection setup in each view

2. Project Structure
   - Basic single module setup
   - May need to be split into feature modules as project grows
   - Dependencies management could be improved with clear module boundaries

3. SwiftUI Integration
   - Using ComposableArchitecture but minimal implementation
   - Need to establish consistent patterns for state management
   - View modifiers and extensions could be better organized

4. Build Configuration
   - Only basic debug/release configurations
   - Missing staging/QA environments
   - No custom build settings for different environments

5. Testing Infrastructure
   - Missing unit test targets
   - No UI test setup
   - No snapshot testing implementation

6. CI/CD Pipeline
   - No automated build process
   - Missing fastlane integration
   - No automated deployment workflow

7. Documentation
   - Limited inline documentation
   - No API documentation
   - Missing architecture documentation

8. Dependencies
   - Minimal dependency management
   - No version pinning strategy defined
   - Could benefit from dependency injection framework

9. Asset Management
   - Basic asset catalog
   - No localization setup
   - No dynamic color/theme system

10. Performance
    - No performance monitoring setup
    - Memory usage tracking not implemented
    - Network layer optimization needed
*/
