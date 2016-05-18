class MKSourcelistTableCellView < MK::Layout

  attr_accessor :is_header

  def layout
    root(NSTableCellView, :root) do

      unless @is_header
        add NSImageView, :image_view do
          setImageScaling(NSImageScaleProportionallyUpOrDown)
          setImageAlignment(NSImageAlignCenter)

          constraints do
            left.equals(:superview, :left)
            top.equals(:superview, :top).plus 1
            width 20
            height 17
          end
        end

        @badgeView = PXSourceListBadgeView.alloc.initWithFrame(CGRectZero)
        add @badgeView, :badge_view do
          constraints do
            right.equals(:superview, :right).minus 5
            top.equals(:superview, :top).plus 6
            min_width 20
          end
        end
      end

      add NSTextField, :text_field do

        if @is_header
          left_margin = 3
          font NSFont.boldSystemFontOfSize(11)
          text_color NSColor.grayColor
        else
          left_margin = 27
          font NSFont.systemFontOfSize(13)
        end

        setBordered false
        setDrawsBackground false
        constraints do
          left.equals(:superview, :left).plus left_margin
          top.equals(:superview, :top).plus 4
          width 200
          height 17
        end
      end

    end
  end
end
