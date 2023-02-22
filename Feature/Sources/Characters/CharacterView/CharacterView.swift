import SwiftUI
import ComposableArchitecture
import Common
import MarvelService

public struct CharacterView: View {
    var store: StoreOf<CharacterReducer>
    
    public init(store: StoreOf<CharacterReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Palette.darkGray
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    imageView
                    if !viewStore.detail.isEmpty {
                        detailView
                    }
                    Spacer()
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .navigationTitle(viewStore.name)
        }
    }
    
    var imageView: some View {
        WithViewStore(self.store) { viewStore in
            AsyncImage(url: viewStore.imageUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
            }
            .aspectRatio(
                CGSize(width: 256.0,height: 256.0),
                contentMode: .fit)
            .clipShape(Circle())
            .cornerRadius(8.0)
            .shadow(color: Palette.red, radius: 8.0)
            .padding(.horizontal, 64.0)
            .padding(.vertical, 16.0)
        }
    }
    
    var detailView: some View {
        WithViewStore(self.store) { viewStore in
            Text(viewStore.detail)
                .font(.body)
                .foregroundColor(Palette.white)
                .padding(.horizontal, 16.0)
                .padding(.top, 24.0)
        }
    }
}

public struct CharacterView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            NavigationStack {
                CharacterView(store: Store(
                    initialState: CharacterReducer.State(.mock),
                    reducer: CharacterReducer())
                )
            }
        }
    }
}
