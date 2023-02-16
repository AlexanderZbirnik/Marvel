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
                                .cornerRadius(8.0)
                                .padding(.leading, 22.0)
                        Text(viewStore.title)
                            .font(.body)
                            .foregroundColor(Palette.white)
                            .fontWeight(.regular)
                            .lineLimit(2)
                            .padding(.trailing)
                        Spacer()
                    }
                    NavigationLink {
                        SeriesView(
                            store: self.store.scope(
                                state: \.series,
                                action: SeriesItemReducer.Action.series
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

public struct SeriesItemView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            SeriesItemView(store: Store(
                initialState: SeriesItemReducer.State(.mock),
                reducer: SeriesItemReducer())
            )
            .frame(height: 88.0)
            .background(Color.white)
        }
    }
}
