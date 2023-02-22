import SwiftUI
import ComposableArchitecture
import Common

public struct CharacterItemView: View {
    var store: StoreOf<CharacterItemReducer>
    
    public init(store: StoreOf<CharacterItemReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            GeometryReader { proxy in
                ZStack {
                    Palette.darkGray
                    RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                        .fill(Palette.lightGray)
                        .frame(width: proxy.size.width - 24.0, height: 74.0)
                        .shadow(radius: 4.0)
                    HStack(spacing: 16.0) {
                        AsyncImage(url: viewStore.imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Palette.gray)
                                }
                                .frame(width: 56.0, height: 56.0)
                                .cornerRadius(28.0)
                                .padding(.leading, 22.0)
                        Text(viewStore.name)
                            .font(.body)
                            .foregroundColor(Palette.white)
                            .fontWeight(.regular)
                            .lineLimit(2)
                            .padding(.trailing)
                        Spacer()
                    }
                    NavigationLink {
                        CharacterView(
                            store: self.store.scope(
                                state: \.character,
                                action: CharacterItemReducer.Action.character
                            )
                        )
                    } label: {
                        EmptyView()
                    }
                    .opacity(.zero)

                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}

public struct CharacterItemView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            CharacterItemView(store: Store(
                initialState: CharacterItemReducer.State(.mock),
                reducer: CharacterItemReducer())
            )
            .frame(height: 88.0)
            .background(Color.white)
        }
    }
}
