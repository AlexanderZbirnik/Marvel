import SwiftUI
import ComposableArchitecture
import Common

public struct ComicsItemView: View {
    var store: StoreOf<ComicsItemReducer>
    
    public init(store: StoreOf<ComicsItemReducer>) {
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
                                .aspectRatio(
                                    CGSize(width: 100.0,height: 150.0),
                                    contentMode: .fit)
                                .cornerRadius(4.0)
                                .padding(.leading, 22.0)
                                .padding(.vertical, 16.0)
                        Text(viewStore.title)
                            .font(.body)
                            .foregroundColor(Palette.white)
                            .fontWeight(.regular)
                            .lineLimit(2)
                            .padding(.trailing)
                        Spacer()
                    }
                    NavigationLink {
                        ComicsView(
                            store: self.store.scope(
                                state: \.comics,
                                action: ComicsItemReducer.Action.comics
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

public struct ComicsItemView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            ComicsItemView(store: Store(
                initialState: ComicsItemReducer.State(.mock),
                reducer: ComicsItemReducer())
            )
            .frame(height: 88.0)
            .background(Color.white)
        }
    }
}
