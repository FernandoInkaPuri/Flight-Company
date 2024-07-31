class Search < ActiveRecord::Base

  def self.most_popular_destinations
    Search.group(:route_destiny).count.sort_by {|key, value| value }.reverse
  end

  def self.save_search(route_origin, route_destiny, departure_date, return_date)
    Search.create(
      route_origin: route_origin,
      route_destiny: route_destiny,
      departure_date: departure_date,
      return_date: return_date)
  end
end
