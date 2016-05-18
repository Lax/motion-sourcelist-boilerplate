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
    return true
  end

  def sourceList(sourceList, viewForItem:item)

    cell = MMSourcelistTableCellView.alloc.initWithFrame(NSMakeRect(0, 1, 189, 24))

    if sourceList.levelForItem(item) == 0

      cell.textField.font = NSFont.boldSystemFontOfSize 12
      cell.textField.textColor = NSColor.grayColor
      cell.textField.frame = NSMakeRect(0, 2, 189, 18)
      cell.badgeView.hidden = true
    else

      photosImage = NSImage.imageNamed("photos")
      photosImage.setTemplate(true)

      cell.textField.font = NSFont.systemFontOfSize 13
      cell.imageView.setImage item["Icon"]

      cell.badgeView.badgeValue = item['Count']
    end

    cell.textField.setStringValue item["Title"]

    cell
  end

end
