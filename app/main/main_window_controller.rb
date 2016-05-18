class MainWindowController < NSWindowController

  def layout
    @layout ||= MainWindowLayout.new
  end

  def init
    super.tap do
      self.window = layout.window
    end

    @sourceListItems = []

    build_navigation

    @outline_view = @layout.get(:outline_view)
    @outline_view.outlineTableColumn = @layout.outline_view_column
    @outline_view.delegate = self
    @outline_view.dataSource = self

    @outline_view.reloadData
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
    end

    text_field.setStringValue item["Title"]

    cell
  end

end
