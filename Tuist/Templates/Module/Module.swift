import ProjectDescription
import Foundation

let companyName: Template.Attribute.Value = "Graham Hindle"
var defaultYear: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: Date())
}

var defaultDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: Date())
}

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .optional("author", default: .string("Graham Hindle"))
let yearAttribute: Template.Attribute = .optional("year", default: .string(defaultYear))
let dateAttribute: Template.Attribute = .optional("date", default: .string(defaultDate))
let companyAttribute: Template.Attribute = .optional("company", default: companyName)

let template = Template(
    description: "A template for a new feature",
    attributes: [
        nameAttribute,
        authorAttribute,
        yearAttribute,
        dateAttribute,
        companyAttribute,
        .optional("platform", default: .string("ios")),
    ],
    items: [
        .file(path: "Modules/\(nameAttribute)/Project.swift", templatePath: "Project.stencil"),
        .file(
            path: "Modules/\(nameAttribute)/Sources/\(nameAttribute)View.swift",
            templatePath: "AppView.stencil"
        ),
        .file(path: "Modules/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift", templatePath: "Tests.stencil"),
        .file(path: "Modules/\(nameAttribute)/Readme.swift", templatePath: "Readme.stencil"),
        .file(path: "Modules/\(nameAttribute)/Resources/Assets.xcassets/AccentColor.colorset/Contents.json",
              templatePath: "AccentColor.stencil"),
        .file(path: "Modules/\(nameAttribute)/Resources/Assets.xcassets/AppIcon.appiconset/Contents.json",
              templatePath: "AppIcon.stencil"),
    ]
)
