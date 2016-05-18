class MMSourcelistTableCellView < NSTableCellView
  #attr_accessor :imageView
  #attr_accessor :textField
  #attr_accessor :badgeField

  def initWithFrame frame
    super frame

    #@badgeField = NSTextField.alloc.initWithFrame(CGRectZero)

    setAutoresizingMask NSViewWidthSizable

    @imageView = NSImageView.alloc.initWithFrame(NSMakeRect(0, 6, 16, 20))
    @imageView.setImageScaling(NSImageScaleProportionallyUpOrDown)
    @imageView.setImageAlignment(NSImageAlignCenter)

    @textField = NSTextField.alloc.initWithFrame(NSMakeRect(21, 6, 200, 20))
    @textField.setBordered false
    @textField.setDrawsBackground false

    @badgeView = PXSourceListBadgeView.alloc.initWithFrame(NSMakeRect(164, 2, 22, 14))

    addSubview @imageView
    addSubview @textField
    addSubview @badgeView

    self
  end

  def preflight
  end

  def setTitle title
    @textField.stringValue = title
  end

  def setTextField textfield
    @textField = textfield
  end

  def textField
    @textField
  end

  def setImageView imageview
    @imageView = imageView
  end

  def imageView
    @imageView
  end

  def setBadgeView badgeView
    @badgeView = badgeView
  end

  def badgeView
    @badgeView
  end


end
