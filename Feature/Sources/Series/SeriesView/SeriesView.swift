import SwiftUI
import ComposableArchitecture
import Common
import MarvelService

extension SeriesView {
    struct ViewState: Equatable {
        let title: String
        let detail: String
        let imageUrl: URL
        let characters: PreviewCharactersList?
        let creators: PreviewCreatorsList?
        let comics: PreviewComicsList?
        
        init(state: SeriesReducer.State) {
            self.title = state.title
            self.detail = state.detail
            self.imageUrl = state.imageUrl
            self.characters = state.characters
            self.creators = state.creators
            self.comics = state.comics
        }
    }
}

public struct SeriesView: View {
    var store: StoreOf<SeriesReducer>
    
    public init(store: StoreOf<SeriesReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
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
                    if let characters = viewStore.characters {
                        CharactersPreView(title: characters.name,
                                          characters: characters.list)
                    }
                    if let creators = viewStore.creators {
                        creatorsView(creators)
                    }
                    Spacer()
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .navigationTitle(viewStore.title)
        }
    }
    
    var imageView: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            AsyncImage(url: viewStore.imageUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Image.bigRectPlaceholder
                    .resizable()
            }
            .aspectRatio(
                CGSize(width: 300.0,height: 450.0),
                contentMode: .fit)
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
                if index < comics.items.count {
                    Rectangle()
                        .frame(height: 1.0)
                        .foregroundColor(Palette.lightGray)
                        .padding(.horizontal, 32.0)
                        .padding(.top, 4.0)
                }
            }
        }
    }
    
    func creatorsView(_ creators: PreviewCreatorsList) -> some View {
        VStack(spacing: .zero) {
            SubtitleView(subtitle: creators.name)
            ForEach(creators.list, id: \.self) { role in
                HStack {
                    Text(role.title + ":")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Palette.gray)
                        .padding(.horizontal, 16.0)
                        .padding(.top, 8.0)
                    Spacer()
                }
                HStack {
                    Text(role.names)
                        .font(.headline)
                        .fontWeight(.regular)
                        .italic()
                        .foregroundColor(Palette.white)
                        .padding(.horizontal, 16.0)
                        .padding(.top, 4.0)
                    Spacer()
                }
            }
        }
    }
}

public struct SeriesView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            NavigationStack {
                SeriesView(
                    store: Store(initialState: SeriesReducer.State(.mock)) {
                        SeriesReducer()
                    }
                )
            }
        }
    }
}
