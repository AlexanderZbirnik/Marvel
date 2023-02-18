import SwiftUI
import ComposableArchitecture
import Common

public struct SeriesView: View {
    var store: StoreOf<SeriesReducer>
    
    public init(store: StoreOf<SeriesReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            GeometryReader { proxy in
                ZStack {
                    Palette.darkGray
                        .ignoresSafeArea()
                    ScrollView(.vertical) {
                        AsyncImage(url: viewStore.imageUrl) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                        }
                        .aspectRatio(
                            CGSize(width: 300.0,height: 450.0),
                            contentMode: .fit)
                        .cornerRadius(8.0)
                        .shadow(color: Palette.red, radius: 8.0)
                        .padding([.leading, .trailing], 64.0)
                        .padding([.top, .bottom])
                        Text(viewStore.detail)
                            .font(.body)
                            .foregroundColor(Palette.white)
                            .padding(16.0)
                        Spacer()
                    }
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
                .navigationTitle(viewStore.title)
            }
        }
    }
}

public struct SeriesView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            NavigationStack {
                SeriesView(store: Store(
                    initialState: SeriesReducer.State(.mock),
                    reducer: SeriesReducer())
                )
            }
        }
    }
}
