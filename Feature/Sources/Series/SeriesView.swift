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
            VStack {
                Text("series")
                List {
                    ForEach(viewStore.series, content: { series in
                        HStack {
                            AsyncImage(url: series.imageUrl!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "photo.fill")
                                    }.frame(width: 56.0, height: 56.0)
                            VStack {
                                HStack {
                                    Text(series.title ?? "")
                                    Spacer()
                                }
                                HStack {
                                    Text("\(series.startYear ?? 0)")
                                    Text("-")
                                    Text("\(series.endYear ?? 0)")
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                    })
                }
            }
            .onAppear{
                viewStore.send(.onAppear)
            }
        }
    }
}

public struct Series_Previews: PreviewProvider {
    public static var previews: some View {
        SeriesView(store: Store(
            initialState: SeriesReducer.State(),
            reducer: SeriesReducer())
        )
    }
}
