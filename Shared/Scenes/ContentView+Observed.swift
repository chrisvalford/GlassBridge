//
//  ContentView+Observed.swift
//  GlassBridge
//
//  Created by Christopher Alford on 29/4/22.
//

import CoreData
import SwiftUI

extension ContentView {
    class Observed: ObservableObject {
        @Published var chartImage = Image("map")

        var chartId = "RYA TC4_B"
        var fullWidth: Float?
        var fullHeight: Float?
        var magnificationFactor: Float = 0.2
        var extents: ChartExtents?
        var imageSize: CGSize?

        private var context: NSManagedObjectContext = {
            PersistenceController.shared.container.viewContext
        }()

        init() {
            guard let path = Bundle.main.path(forResource: chartId, ofType: "bundle"), let bundle = Bundle(path: path) else {
                print("Bundle error")
                return
            }
            chartImage = Image(chartId, bundle: bundle)
            // If we have a ChartExtents entity ...
            let request: NSFetchRequest<ChartExtents> = ChartExtents.fetchRequest()
            let predicate = NSPredicate(format: "chartId = %@", self.chartId)
            request.predicate = predicate

            do {
                let results = try (context.fetch(request)) as [ChartExtents]
                if results.count > 0 {
                    extents = results.first
                } else {
                    //TODO: Have a popup to enter the new chart extents fields, for now
                    self.extents = NSEntityDescription.insertNewObject(forEntityName: "ChartExtents", into: context) as? ChartExtents
                    self.extents?.chartId = self.chartId
                    do {
                        try context.save()
                    } catch {
                        print("Failed to save new ChartExtents: \(error)")
                    }
                }
            } catch {
                print("Error reading ChartExtents; \(error.localizedDescription)")
            }

            if extents?.toTopLeft == nil {
                let cc = NSEntityDescription.insertNewObject(forEntityName: "ChartCoordinate", into: context) as? ChartCoordinate
                extents!.toTopLeft = cc
                extents!.toTopLeft!.chartId = self.chartId
            }

            if extents?.toTopRight == nil {
                let cc = NSEntityDescription.insertNewObject(forEntityName: "ChartCoordinate", into: context) as? ChartCoordinate
                extents!.toTopRight = cc
                extents!.toTopRight!.chartId = self.chartId
            }

            if extents?.toBottomLeft == nil {
                let cc = NSEntityDescription.insertNewObject(forEntityName: "ChartCoordinate", into: context) as? ChartCoordinate
                extents!.toBottomLeft = cc
                extents!.toBottomLeft!.chartId = self.chartId
            }

            if extents?.toBottomRight == nil {
                let cc = NSEntityDescription.insertNewObject(forEntityName: "ChartCoordinate", into: context) as? ChartCoordinate
                extents!.toBottomRight = cc
                extents!.toBottomRight!.chartId = self.chartId
            }

            do {
                try context.save()
            } catch {
                print("Failed to save new ChartCoordinates: \(error)")
            }
            
            self.extents?.chartId = self.chartId

            // Do any additional setup after loading the view.
            magnificationFactor = 0.5 //magnificationSlider.floatValue / 100

            //TODO: scrollView.contentSize = CGSize(width: 8286, height: 5460) // Size of Image
        }
    }
}
