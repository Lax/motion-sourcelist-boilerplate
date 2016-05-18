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

    6.times do
      photosImage = NSImage.imageNamed("photos")
      photosImage.setTemplate(true)

      child = {
        "Title"=> 'title',
        "Icon" => photosImage,
        "Count" => 1
      }
        children << child

    end

    @displayItem = {
      "Title" => 'Cocoa Elements',
      "Children" => children
    }

    @sourceListItems << @displayItem
    @sourceListItems << @displayItem

  end

  def sourceList(sourceList, numberOfChildrenOfItem:item)
    item.nil? ? @sourceListItems.count : item["Children"].length
  end

  def sourceList(sourceList,child:index, ofItem:item)
#    item.nil? ? @displayItem : item["Children"][index]
    if !item
      return @sourceListItems[index]
    else
      item["Children"][index]

    end

    # p "sourceList(aSourceList,child:index, ofItem:item) "
    # p item

#    return item.children.objectAtIndex(index)

  end

  def sourceList(sourceList, isItemExpandable:item)
    item.nil? ? false : (item["Children"].nil? ? false : item["Children"].length != 0)
  end

  #pragma mark - PXSourceList Delegate

  def sourceList(sourceList,isGroupAlwaysExpanded:group)
    return true
  end

  def sourceList(sourceList, viewForItem:item)

    photosImage = NSImage.imageNamed("photos")
    photosImage.setTemplate(true)
    p item

    cell = MMSourcelistTableCellView.alloc.initWithFrame(NSMakeRect(0, 1, 189, 14))
    cell.textField = NSTextField.alloc.initWithFrame(NSMakeRect(25, 0, 130, 17))
    cell.imageView = NSImageView.alloc.initWithFrame(NSMakeRect(3, 0, 17, 17))

    cell.textField.stringValue = item["Title"]
    cell.imageView.setImage photosImage

    cell
  end

end
