import SwiftUI
import ComposableArchitecture
import Common

public struct SeriesItemView: View {
    var store: StoreOf<SeriesItemReducer>
    
    public init(store: StoreOf<SeriesItemReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                AsyncImage(url: viewStore.imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 56.0, height: 56.0)
                Text(viewStore.title)
                    .font(.title3)
                    .foregroundColor(Palette.black)
                    .fontWeight(.regular)
                Spacer()
            }
            .padding([.leading, .trailing], 8.0)
        }
    }
}

public struct SeriesItemView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            SeriesItemView(store: Store(
                initialState: SeriesItemReducer.State(.mock),
                reducer: SeriesItemReducer())
            )
            .frame(height: 64.0)
            .background(Color.white)
        }
    }
}
