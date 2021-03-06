module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Great Games Club"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    fa = (column == sort_column) ? "<i class='fa fa-sort-#{sort_direction}'></i>" : nil

    link_to "#{title} #{fa}".html_safe, :sort => column, :direction => direction
  end
end
