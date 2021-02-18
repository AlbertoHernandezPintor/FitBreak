//
//  Weather.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 18/2/21.
//

import SwiftUI
import UIKit

struct Weather: UIViewControllerRepresentable {

  func makeUIViewController(context: UIViewControllerRepresentableContext<Weather>) -> UIViewController {

    //Load the storyboard
    let loadedStoryboard = UIStoryboard(name: "Weather", bundle: nil)

    //Load the ViewController
    return loadedStoryboard.instantiateViewController(withIdentifier: "Weather")
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Weather>) {
  }
}
