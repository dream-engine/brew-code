//
//  BeerListView.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 22/07/23.
//

import SwiftUI

struct BeerListView: View {
    
    @ObservedObject var viewModel = BeerListViewModel2()
    
    @State var selectedSegmentIndex: Int = 0
    @State var showAllFilters: Bool = false
    
    var body: some View {
        
        VStack {
            HStack{}.frame(height: 60)
            segmentHeaderView
            pagedListView
        }
        .background(Color.gray)
        .onAppear {
            self.viewModel.fetchBeers()
        }.ignoresSafeArea()
        
    }
}

extension BeerListView {
    
    // MARK: Page List View
    var pagedListView: some View {
        TabView(selection: self.$selectedSegmentIndex) {
            ForEach(0..<self.viewModel.filterSet.count, id: \.self) { hopIndex in
                ScrollView {
                    VStack {
                        let cellModels = self.viewModel.filteredBeers(forHop: self.viewModel.filterSet[hopIndex])
                        ForEach(0..<cellModels.count, id: \.self) { cellModelIndex in
                            BeerListCellView(cellModel: cellModels[cellModelIndex])
                                .frame(height: 150)
                        }
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut, value: self.selectedSegmentIndex)
        .transition(.slide)
    }
    
    // MARK: Segmented Header View
    var segmentHeaderView: some View {
        
        HStack(spacing: 0) {
            // Menu Button
            Button {
                self.showAllFilters = true
            } label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .padding(.horizontal, 10)
                    .frame(width: 44, height: 18)
                    .foregroundColor(.black)
                
            }
            .sheet(isPresented: self.$showAllFilters) {
                self.allFiltersView
                    .presentationDetents([.height(UIScreen.main.bounds.size.height*0.7)])
                    .presentationDragIndicator(.automatic)
                    .ignoresSafeArea()
            }
            // Segment Selection
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<self.viewModel.filterSet.count, id: \.self) { hopIndex in
                            Button {
                                self.selectedSegmentIndex = hopIndex
                                
                            } label: {
                                VStack {
                                    Text(self.viewModel.filterSet[hopIndex].uppercased())
                                        .font(.subheadline).fontWeight(.bold)
                                        .foregroundColor(
                                            self.selectedSegmentIndex == hopIndex
                                            ? .gray
                                            : .black
                                        )
                                        .padding(.horizontal, 13)
                                        .padding(.vertical, 2)
                                }.frame(height: 32)
                                    .background(
                                        self.selectedSegmentIndex == hopIndex
                                        ? Color.black
                                        : Color.clear
                                    )
                                    .cornerRadius(16)
                            }
                            
                        }
                    }.frame(height: 50)
                }.onChange(of: self.selectedSegmentIndex) { newValue in
                    withAnimation {
                        scrollView.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }
    
    // MARK: All Filters View
    var allFiltersView: some View {
        VStack {
            
            VStack {
                HStack {
                    Text("Label Quick Selection")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    
                    // Close Button
                    Button {
                        self.showAllFilters = false
                    } label: {
                        VStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 16, height: 16)
                        }.frame(width: 44, height: 44)
                        
                    }
                    
                }
                
                Spacer()
                
                // Dynmaic width text views in bottom sheet
                DynamicSizeWrappedLayout(
                    items: self.viewModel.filterSet.filter({ $0 != "All"}),
                    didSelectIndex: { index in
                        self.selectedSegmentIndex = index
                        self.showAllFilters = false
                    }
                )
            }
            .padding(20)
        }.background(Color.clear)
    }
    
}

struct BeerListView_Previews: PreviewProvider {
    static var previews: some View {
        BeerListView()
    }
}

// MARK: Dynamic Size Wrapper
struct DynamicSizeWrappedLayout: View {
    var items: [String]
    var didSelectIndex: (_ index: Int) -> Void
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(0..<self.items.count, id: \.self) { index in
                self.item(for: self.items[index])
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if index == self.items.count-1 {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if index == self.items.count-1 {
                            height = 0 // last item
                        }
                        return result
                    })
                    .onTapGesture {
                        self.didSelectIndex(index+1)
                    }
                
            }
        }
    }
    
    func item(for text: String) -> some View {
        VStack {
            Text(text)
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            
        }
        .frame(height: 35)
        .background(Color.black.opacity(0.05))
        .cornerRadius(20)
    }
}

struct TestWrappedLayout_Previews: PreviewProvider {
    static var previews: some View {
        DynamicSizeWrappedLayout(items: ["Apple", "Banana"], didSelectIndex: {_ in })
    }
}
