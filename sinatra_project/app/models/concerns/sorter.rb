class Sorter

  module InstanceMethods

    def total_amount
      self.items.collect {|item| item.amount}.sum
    end

    def items_sort_by_date
      self.items.sort_by {|item| item[:date]}.reverse
    end
  end

end