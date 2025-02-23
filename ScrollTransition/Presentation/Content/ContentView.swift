import SwiftUI

struct ContentView: View {
    
    @Namespace private var animation
    @State private var navigationPath: [String] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            GeometryReader {
                let size = $0.size
                let cellWidth = size.width * 0.8
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(1...5, id: \.self) { index in
                            PuppyView("puppy_\(index)", width: cellWidth)
                        }
                    }
                    .scrollTargetLayout()
                }
                .padding(.horizontal, 16)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(.leading, ((size.width - cellWidth) / 2) - 16)
                .scrollClipDisabled()
                .frame(height: 300)
                .padding(.vertical)
                .navigationTitle("Puppies")
            }
            .navigationDestination(for: String.self) { puppy in
                PuppyDetailsView(puppy: puppy)
                    .toolbarVisibility(.hidden, for: .navigationBar)
                    .navigationTransition(
                        .zoom(
                            sourceID: puppy,
                            in: animation
                        )
                    )
            }
        }
    }
    
    private func PuppyView(_ puppy: String, width: CGFloat) -> some View {
        Image(puppy)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width)
            .clipShape(.rect(cornerRadius: 12))
            .matchedTransitionSource(
                id: puppy,
                in: animation
            )
            .contentShape(.rect)
            .onTapGesture {
                navigationPath.append(puppy)
            }
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.7)
                    .scaleEffect(phase.isIdentity ? 1 : 0.9)
                    .blur(radius: phase.isIdentity ? 0 : 1)
                    .rotationEffect(.degrees(phase.value * 5))
            }
    }
}

#Preview {
    ContentView()
}
