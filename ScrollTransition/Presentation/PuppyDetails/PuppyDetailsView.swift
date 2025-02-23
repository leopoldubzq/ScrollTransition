import SwiftUI

struct PuppyDetailsView: View {
    
    let puppy: String
    
    var body: some View {
        VStack {
            Image(puppy)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

#Preview {
    PuppyDetailsView(puppy: "puppy_1")
}
