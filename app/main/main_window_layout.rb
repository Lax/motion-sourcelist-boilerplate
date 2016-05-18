class MainWindowLayout < MK::WindowLayout

  MAIN_WINDOW_IDENTIFIER = 'MAIN_WINDOW'

  attr_accessor :outline_view_column

  def layout
    frame [[100, 100], [480, 360]], 'WindowLayout'

    add NSSplitView, :split_view do

      divider_style NSSplitViewDividerStyleThin
      vertical true

      constraints do
        top.equals(:superview, :top)
        bottom.equals(:superview, :bottom)
        left.equals(:superview, :left)
        right.equals(:superview, :right)
      end

      add NSView, :left_view do
        background_color NSColor.blueColor
        constraints do
          min_width 100
          max_width 300
          top.equals(:scroll_view_left, :top)
        end

        add NSScrollView, :scroll_view_left do
          has_vertical_scroller true
          constraints do
            width 300
            min_height 200
            top.equals(:superview, :top)
            bottom.equals(:superview ,:bottom).minus 2
          end

          set_autoresizes_subviews true

          @outline_view_column = NSTableColumn.alloc.initWithIdentifier 'header'
          @outline_view = PXSourceList.alloc.initWithFrame([[0, 0], [0, 0]])
          document_view add @outline_view, :outline_view
        end
      end

      add NSView, :right_view do
        constraints do
          min_width 100
          min_height 100
        end

        add NSView, :right_view_content do
          constraints do
            top.equals(:right_view, :top).plus 5
            bottom.equals(:right_view, :bottom).minus 5
            left.equals(:right_view, :left).plus 5
            right.equals(:right_view, :right).minus 5
          end
        end
      end
    end
  end

  def outline_view_style

    focus_ring_type NSFocusRingTypeNone
    parent_bounds = v.superview.bounds
    frame parent_bounds

    header_view nil

    selection_highlight_style NSTableViewSelectionHighlightStyleSourceList

    add_column @outline_view_column do
      editable false
      width parent_bounds.size.width
    end
  end

end

