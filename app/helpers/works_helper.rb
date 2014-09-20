module WorksHelper
  def get_resized_jpg_path(fullsize_path)

    replacer_array = {
      "/workrepresentations/" => "/workrepresentations/r/",
      ".jpg" => "_w600.jpg",
      ".png" => "_w600.jpg"
    }

    replacer_array.each do |find, replace|
      fullsize_path.sub! find, replace
    end
    
    return fullsize_path
  end
end
