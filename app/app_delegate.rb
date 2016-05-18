class AppDelegate
  attr :main_menu_layout

  def applicationDidFinishLaunching(notification)
    @main_menu_layout = MainMenu.new
    NSApp.mainMenu = @main_menu_layout.menu

    toolbar = NSToolbar.alloc.initWithIdentifier "MyToolbar"

    toolbar.setAllowsUserCustomization true
    toolbar.setAutosavesConfiguration true
    toolbar.setDisplayMode NSToolbarDisplayModeIconAndLabel

    toolbar.setDelegate self

    appName =NSBundle.mainBundle.infoDictionary.objectForKey "CFBundleDisplayName"

    @main_controller = MainWindowController.alloc.init
    @main_controller.window.setToolbar toolbar
    @main_controller.window.setTitle appName
    #    @main_controller.showWindow(self)
    @main_controller.window.orderFrontRegardless
  end

  SearchPhotoIdentifier = 'SearchPhotoIdentifier'
  SideBarIdentifier = 'SideBarIdentifier'

  def toolbarAllowedItemIdentifiers(toolbar)
    #[SearchPhotoIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarSpaceItemIdentifier, NSToolbarSeparatorItemIdentifier, SideBarIdentifier]
    [SideBarIdentifier]
  end

  def toolbarDefaultItemIdentifiers(toolbar)
#    [SideBarIdentifier, NSToolbarFlexibleSpaceItemIdentifier, SearchPhotoIdentifier]
    [SideBarIdentifier]
  end

  def toolbar(toolbar, itemForItemIdentifier:identifier, willBeInsertedIntoToolbar:flag)

    if identifier == SearchPhotoIdentifier
      item = NSToolbarItem.alloc.initWithItemIdentifier(identifier)
      item.label = 'Search Flickr'
      view = NSSearchField.alloc.initWithFrame(NSZeroRect)
      view.target = self
      view.action = :"toolbarSearch:"
      view.frame = [[0, 0], [200, 0]]
      item.view = view
      item

    elsif identifier == SideBarIdentifier
      image = NSImage.imageNamed('photos')
      image.setTemplate(true)

      item = NSToolbarItem.alloc.initWithItemIdentifier identifier
      item.label = "Toggle Sidebar"
      item.image = image
      item.target = self
      item.action = :"toggleSidebar:"
      item
    end
  end

  def toggleSidebar(sender)
    p 'toggle Sidebar'

  end

  def toolbarSearch(sender)
    p 'hallo'
    p sender.stringValue.strip
  end

end
