//
//  CheckboxFieldView.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import SwiftUI

struct CheckboxFieldView: View {
    @State var checked: Bool
    var callBack: (Bool) -> Void
    
    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .onTapGesture {
                self.checked.toggle()
                self.callBack(self.checked)
            }
    }
}

#Preview {
    @Previewable @State var checked = false
    CheckboxFieldView(checked: checked, callBack: { newValue in
    })
}
