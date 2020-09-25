class Quantifiable

  module InstanceMethods
#Takes sum of items in list
    def total_amount
      self.items.collect {|item| item.amount}.sum
    end
#Sort items in list by date
    def items_sort_by_date
      self.items.sort_by {|item| item[:date]}.reverse
    end
  end

end