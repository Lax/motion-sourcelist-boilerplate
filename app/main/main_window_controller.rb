class MainWindowController < NSWindowController
  SideBarIdentifier = 'SideBarIdentifier'

  attr_accessor :controller

  def layout
    @layout ||= MainWindowLayout.new
  end

  def init
    super.tap do
      self.window = layout.window

      toolbar = NSToolbar.alloc.initWithIdentifier "MyToolbar"

      toolbar.setAllowsUserCustomization true
      toolbar.setAutosavesConfiguration true
      toolbar.setDisplayMode NSToolbarDisplayModeIconAndLabel

      toolbar.setDelegate self

      self.window.setToolbar toolbar

    end

    @sourceListItems = []

    build_navigation

    @left_view = @layout.get(:left_view)
    @content_label = @layout.get(:content_label)
    @splitView = @layout.get(:split_view)
    @splitView.adjustSubviews
    @splitView.setPosition(200.0, ofDividerAtIndex:0)

    @outline_view = @layout.get(:outline_view)
    @outline_view.outlineTableColumn = @layout.outline_view_column
    @outline_view.delegate = self
    @outline_view.dataSource = self

    @outline_view.reloadData

  end

  # this is the handler the above snippet refers to
  def mainSplitViewWillResizeSubviewsHandler(object)
    @lastSplitViewSubViewLeftWidth = @left_view.frame.size.width
  end

  # wire this to the UI control you wish to use to toggle the
  # expanded/collapsed state of splitViewSubViewLeft
  def toggleSidebar(sender)

    frame = @left_view.frame

    if frame.size.width == 0.0
      @splitView.setPosition(200.0, ofDividerAtIndex:0)
    else
      @splitView.setPosition(0.0, ofDividerAtIndex:0)
    end

  end

  def toolbarAllowedItemIdentifiers(toolbar)
    [SideBarIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarSpaceItemIdentifier, NSToolbarSeparatorItemIdentifier]
  end

  def toolbarDefaultItemIdentifiers(toolbar)
    [SideBarIdentifier]
  end

  def toolbar(toolbar, itemForItemIdentifier:identifier, willBeInsertedIntoToolbar:flag)
    if identifier == SideBarIdentifier
      image = NSImage.imageNamed('sidebar')
      image.setTemplate(true)

      item = NSToolbarItem.alloc.initWithItemIdentifier identifier
      item.label = "Toggle Sidebar"
      item.image = image
      item.target = self
      item.action = :"toggleSidebar:"
      item
    end
  end


  def build_navigation

    children = []

    children << makeItem("Photos", 'photos', 3)
    children << makeItem("Events", 'events', 338)
    children << makeItem("People", 'people', 1244)
    children << makeItem("Places", 'places', 30)

    @displayItem = {
      "Title" => 'LIBRARY',
      "Children" => children
    }

    @sourceListItems << @displayItem

    children = []

    children << makeItem("New Album", 'album', 0)
    children << makeItem("Trip to Amsterdam", 'album', 19)
    children << makeItem("New Album", 'album', 0)
    children << makeItem("New Album", 'album', 0)

    @displayItem = {
      "Title" => 'ALBUMS',
      "Children" => children
    }

    @sourceListItems << @displayItem
  end


  def makeItem title, image_title, count
    image = NSImage.imageNamed(image_title)
    image.setTemplate(true)

    child = {
      "Title"=> title,
      "Icon" => image,
      "Count" => count
    }

    child
  end

  def sourceList(sourceList, numberOfChildrenOfItem:item)
    item.nil? ? @sourceListItems.count : item["Children"].length
  end

  def sourceList(sourceList,child:index, ofItem:item)
    if !item
      return @sourceListItems[index]
    else
      item["Children"][index]
    end
  end

  def sourceList(sourceList, isItemExpandable:item)
    item.nil? ? false : (item["Children"].nil? ? false : item["Children"].length != 0)
  end

  #pragma mark - PXSourceList Delegate

  def sourceList(sourceList,isGroupAlwaysExpanded:group)
    true
  end

  def sourceList(sourceList, heightOfRowByItem:item)
    26
  end

  def sourceList(sourceList, viewForItem:item)

    layout = MKSourcelistTableCellView.new
    layout.is_header = true if sourceList.levelForItem(item) == 0
    layout.build

    cell = layout.get(:root)
    text_field = layout.get(:text_field)
    image_view = layout.get(:image_view)
    badge_view = layout.get(:badge_view)

    unless sourceList.levelForItem(item) == 0
      image_view.setImage item["Icon"] if image_view
      badge_view.badgeValue = item['Count']
      badge_view.hidden = true if item['Count'] == 0
    end

    text_field.setStringValue item["Title"]

    cell
  end

  def sourceListSelectionDidChange(notification)

    selectedItem = @outline_view.itemAtRow(@outline_view.selectedRow)

    if selectedItem
      @content_label.setStringValue selectedItem['Title']
    else
      @content_label.setStringValue "Welcome... please select a menu item."
    end
  end


end
