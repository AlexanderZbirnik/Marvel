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
                        DetailView(detail: viewStore.detail)
                    }
                    if let characters = viewStore.characters {
                        charactersView(characters)
                    }
                    if let creators = viewStore.creators {
                        creatorsView(creators)
                    }
                    dateAndPricesView
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
    
    func charactersView(_ characters: PreviewCharactersList) -> some View {
        VStack(spacing: .zero) {
            SubtitleView(subtitle: characters.name)
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
    
    var formatPagesView: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: .zero) {
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
            SubtitleView(subtitle: links.name)
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
    
    var dateAndPricesView : some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: .zero) {
                if !viewStore.dates.isEmpty {
                    datesView(viewStore.dates)
                }
                if !viewStore.prices.isEmpty {
                    pricesView(viewStore.prices)
                }
                EmptyView()
                    .hidden()
            }
        }
    }
    
    func datesView(_ dates: [PreviewDate]) -> some View {
        VStack(spacing: .zero) {
            ForEach(dates) { date in
                infoView(date.title, info: date.date)
            }
        }
    }
    
    func pricesView(_ prices: [PreviewPrice]) -> some View {
        VStack(spacing: .zero) {
            ForEach(prices) { price in
                infoView(price.title, info: price.price)
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
