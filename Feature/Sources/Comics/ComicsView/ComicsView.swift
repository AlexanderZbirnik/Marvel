import SwiftUI
import ComposableArchitecture
import Common
import MarvelService

extension ComicsView {
    struct ViewState: Equatable {
        let title: String
        let imageUrl: URL
        let detail: String
        let characters: PreviewCharactersList?
        let creators: PreviewCreatorsList?
        let links: PreviewLinksList?
        let format: String
        let pageCount: Int
        let isbn: String
        let ean: String
        let upc: String
        let diamondCode: String
        let dates: [PreviewDate]
        let prices: [PreviewPrice]
        
        init(state: ComicsReducer.State) {
            self.title = state.title
            self.imageUrl = state.imageUrl
            self.detail = state.detail
            self.characters = state.characters
            self.creators = state.creators
            self.links = state.links
            self.format = state.format
            self.pageCount = state.pageCount
            self.isbn = state.isbn
            self.ean = state.ean
            self.upc = state.upc
            self.diamondCode = state.diamondCode
            self.dates = state.dates
            self.prices = state.prices
        }
    }
}

public struct ComicsView: View {
    var store: StoreOf<ComicsReducer>
    
    public init(store: StoreOf<ComicsReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            ZStack {
                Palette.darkGray
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    imageView(viewStore.imageUrl)
                    if !viewStore.detail.isEmpty {
                        DetailView(detail: viewStore.detail)
                    }
                    if let characters = viewStore.characters {
                        CharactersPreView(title: characters.name,
                                          characters: characters.list)
                    }
                    if let creators = viewStore.creators {
                        creatorsView(creators)
                    }
                    dateAndPricesView(dates: viewStore.dates, prices: viewStore.prices)
                    formatPagesView(viewStore.format, pageCount: viewStore.pageCount)
                    codesView(isbn: viewStore.isbn,
                              ean: viewStore.ean,
                              upc: viewStore.upc,
                              diamondCode: viewStore.diamondCode)
                    if let links = viewStore.links {
                        LinksView(links: links)
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
    
    func imageView(_ url: URL) -> some View {
        AsyncImage(url: url) { image in
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
    
    func formatPagesView(_ format: String, pageCount: Int) -> some View {
        VStack(spacing: .zero) {
            if !format.isEmpty {
                infoView("Format:", info: format)
            }
            if pageCount != 0 {
                infoView("Page count:", info: "\(pageCount)")
            }
            EmptyView()
                .hidden()
        }
    }
    
    func codesView(isbn: String, ean: String, upc: String, diamondCode: String) -> some View {
        VStack(spacing: .zero) {
            if !isbn.isEmpty {
                infoView("ISBN:", info: isbn)
            }
            if !ean.isEmpty {
                infoView("EAN:", info: ean)
            }
            if !upc.isEmpty {
                infoView("UPC:", info: upc)
            }
            if !diamondCode.isEmpty {
                infoView("DIAMOND CODE:", info: diamondCode)
            }
            EmptyView()
                .hidden()
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
    
    func dateAndPricesView(dates: [PreviewDate], prices: [PreviewPrice]) -> some View {
        VStack(spacing: .zero) {
            if !dates.isEmpty {
                datesView(dates)
            }
            if !prices.isEmpty {
                pricesView(prices)
            }
            EmptyView()
                .hidden()
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
                ComicsView(
                    store: Store(initialState: ComicsReducer.State(.mock)) {
                        ComicsReducer()
                    }
                )
            }
        }
    }
}
