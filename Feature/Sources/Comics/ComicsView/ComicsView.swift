import SwiftUI
import ComposableArchitecture
import Common
import MarvelService

public struct ComicsView: View {
    var store: StoreOf<ComicsReducer>
    
    public init(store: StoreOf<ComicsReducer>) {
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
                    if let characters = viewStore.characters {
                        charactersView(characters)
                    }
                    if let creators = viewStore.creators {
                        creatorsView(creators)
                    }
                    if let series = viewStore.series {
                        seriesView(series)
                    }
                    if !viewStore.dates.isEmpty {
                       datesView
                    }
                    formatPagesView
                    codesView
                    if let links = viewStore.links {
                        linksView(links)
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
        WithViewStore(self.store) { viewStore in
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
    
    func comicsView(_ comics: PreviewComicsList) -> some View {
        VStack(spacing: 2.0) {
            subtitleView(comics.name)
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
    
    func seriesView(_ series: PreviewSeriesList) -> some View {
        VStack(spacing: 2.0) {
            subtitleView(series.name)
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
    
    func charactersView(_ characters: PreviewCharactersList) -> some View {
        VStack(spacing: .zero) {
            subtitleView(characters.name)
            HStack {
                Text(characters.list)
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
    
    func creatorsView(_ creators: PreviewCreatorsList) -> some View {
        VStack(spacing: .zero) {
            subtitleView(creators.name)
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
    
    func subtitleView(_ text: String) -> some View {
        HStack {
            Text(text)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Palette.gray)
                .padding(.horizontal, 16.0)
                .padding(.top, 4.0)
            Spacer()
        }
    }
    
    var formatPagesView: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: 0.0) {
                if !viewStore.format.isEmpty {
                    infoView("Format:", info: viewStore.format)
                }
                if viewStore.pageCount != 0 {
                    infoView("Page count:", info: "\(viewStore.pageCount)")
                }
                EmptyView()
                    .hidden()
            }
        }
    }
    
    var codesView: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: .zero) {
                if !viewStore.isbn.isEmpty {
                    infoView("ISBN:", info: viewStore.isbn)
                }
                if !viewStore.ean.isEmpty {
                    infoView("EAN:", info: viewStore.ean)
                }
                if !viewStore.upc.isEmpty {
                    infoView("UPC:", info: viewStore.upc)
                }
                if !viewStore.diamondCode.isEmpty {
                    infoView("DIAMOND CODE:", info: viewStore.diamondCode)
                }
                EmptyView()
                    .hidden()
            }
        }
    }
    
    func infoView(_ title: String, info: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Text(info)
            Spacer()
        }
        .foregroundColor(Palette.white)
        .padding(.horizontal, 16.0)
        .padding(.vertical, 8.0)
    }
    
    func linksView(_ links: PreviewLinksList) -> some View {
        VStack(spacing: 2.0) {
            subtitleView(links.name)
            HStack {
                ForEach(0..<links.links.count, id: \.self) { index in
                    Link(links.types[index],
                         destination: links.links[index])
                    .foregroundColor(Palette.red)
                    if index < links.links.count - 1 {
                        Circle()
                            .frame(width: 3.0)
                            .foregroundColor(Palette.red)
                            .offset(y: 2.0)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
        }
    }
    
    var datesView: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: .zero) {
                ForEach(viewStore.dates) { date in
                    infoView(date.title, info: date.date)
                }
                EmptyView()
                    .hidden()
            }
        }
    }
}

public struct ComicsView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            NavigationStack {
                ComicsView(store: Store(
                    initialState: ComicsReducer.State(.mock),
                    reducer: ComicsReducer())
                )
            }
        }
    }
}
