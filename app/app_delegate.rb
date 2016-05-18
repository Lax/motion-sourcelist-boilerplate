class AppDelegate
  attr :main_menu_layout

  def applicationDidFinishLaunching(notification)
    @main_menu_layout = MainMenu.new
    NSApp.mainMenu = @main_menu_layout.menu

#    toolbar = NSToolbar.alloc.initWithIdentifier "MyToolbar"
#
#    toolbar.setAllowsUserCustomization true
#    toolbar.setAutosavesConfiguration true
#    toolbar.setDisplayMode NSToolbarDisplayModeIconAndLabel
#
#    toolbar.setDelegate self

    appName =NSBundle.mainBundle.infoDictionary.objectForKey "CFBundleDisplayName"

    @main_controller = MainWindowController.alloc.init
#    @main_controller.window.setToolbar toolbar
    @main_controller.window.setTitle appName

    # At this time the object is somehow replaced
    #    @main_controller.showWindow(self)
    #
    @main_controller.window.orderFrontRegardless
  end

  def toggleSidebar(sender)
    p @main_controller
    #@main_controller.toggle_toolbar
  end

#  SideBarIdentifier = 'SideBarIdentifier'
#
#  def toolbarAllowedItemIdentifiers(toolbar)
#    [SideBarIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarSpaceItemIdentifier, NSToolbarSeparatorItemIdentifier]
#  end
#
#  def toolbarDefaultItemIdentifiers(toolbar)
#    [SideBarIdentifier]
#  end
#
#  def toolbar(toolbar, itemForItemIdentifier:identifier, willBeInsertedIntoToolbar:flag)
#    if identifier == SideBarIdentifier
#      image = NSImage.imageNamed('sidebar')
#      image.setTemplate(true)
#
#      item = NSToolbarItem.alloc.initWithItemIdentifier identifier
#      item.label = "Toggle Sidebar"
#      item.image = image
#      item.target = self
#      item.action = :"toggleSidebar:"
#      item
#    end
#  end


end
