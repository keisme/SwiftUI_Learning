//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Bruce on 2020/5/16.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct AddressView: View {
  @ObservedObject var order: Order
  var body: some View {
    Form {
      Section {
        TextField("Name", text: $order.name)
        TextField("Street Address", text: $order.streetAddress)
        TextField("City", text: $order.city)
        TextField("Zip", text: $order.zip)
      }
      
      Section {
        NavigationLink(destination: CheckoutView(order: order)) {
          Text("Check out")
        }
      }
      .disabled(order.hasValidAddress == false)
    }
  }
}

struct extraFrosting_Previews: PreviewProvider {
  static var previews: some View {
    AddressView(order: Order())
  }
}
