class MMSourcelistTableCellView < NSTableCellView
  #attr_accessor :imageView
  #attr_accessor :textField
  #attr_accessor :badgeField

  def initWithFrame frame
    super frame

    #@badgeField = NSTextField.alloc.initWithFrame(CGRectZero)

    setAutoresizingMask NSViewWidthSizable

    @imageView = NSImageView.alloc.initWithFrame(NSMakeRect(0, 6, 16, 16))
    @imageView.setImageScaling(NSImageScaleProportionallyUpOrDown)
    @imageView.setImageAlignment(NSImageAlignCenter)

    @textField = NSTextField.alloc.initWithFrame(NSMakeRect(21, 6, 200, 16))
    @textField.setBordered false
    @textField.setDrawsBackground true
    @textField.stringValue = "hallo"

    addSubview @imageView
    addSubview @textField

    self

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


end
