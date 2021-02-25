//
//  AddView.swift
//  iExpense
//
//  Created by Jacob LeCoq on 2/22/21.
//

import Combine
import SwiftUI

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
        return formatter
    }
}

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""

    @ObservedObject var expenses: Expenses

    static let types = ["Business", "Personal"]

    private func string(from value: Int) -> String {
        guard let s = NumberFormatter().string(from: NSNumber(value: value)) else { return "" }
        return s
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                    .foregroundColor(Int(amount) ?? 0 > 10 ? .black : .red)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
