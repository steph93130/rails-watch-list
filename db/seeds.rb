# db/seeds.rb

require "open-uri"
require "json"

puts "Cleaning database..."

Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Fetching top rated movies from Le Wagon TMDB proxy..."

url = "https://tmdb.lewagon.com/movie/top_rated"

serialized_movies = URI.open(url).read
movies = JSON.parse(serialized_movies)

movies["results"].each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "#{Movie.count} movies created!"
