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
                        DetailView(detail: viewStore.detail)
                    }
                    if let comics = viewStore.comics {
                        comicsView(comics)
                    }
                    if let series = viewStore.series {
                        seriesView(series)
                    }
                    if let links = viewStore.links {
                        LinksView(links: links)
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
                Image.bigRectPlaceholder
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
    
    func comicsView(_ comics: PreviewComicsList) -> some View {
        VStack(spacing: 2.0) {
            SubtitleView(subtitle: comics.name)
            ForEach(0..<comics.items.count, id: \.self) { index in
                HStack {
                    Text(comics.items[index].name)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Palette.white)
                        .padding(.horizontal, 16.0)
                        .padding(.top, 8.0)
                    Spacer()
                }
                if index < comics.items.count - 1 {
                    Rectangle()
                        .frame(height: 1.0)
                        .foregroundColor(Palette.lightGray)
                        .padding(.horizontal, 32.0)
                        .padding(.top, 4.0)
                }
            }
        }
    }
    
    func seriesView(_ series: PreviewSeriesList) -> some View {
        VStack(spacing: 2.0) {
            SubtitleView(subtitle: series.name)
            ForEach(0..<series.items.count, id: \.self) { index in
                HStack {
                    Text(series.items[index].name)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Palette.white)
                        .padding(.horizontal, 16.0)
                        .padding(.top, 8.0)
                    Spacer()
                }
                if index < series.items.count - 1 {
                    Rectangle()
                        .frame(height: 1.0)
                        .foregroundColor(Palette.lightGray)
                        .padding(.horizontal, 32.0)
                        .padding(.top, 4.0)
                }
            }
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
