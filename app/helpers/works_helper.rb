module WorksHelper
  def get_resized_jpg_path(fullsize_path)

    replacer_array = {
      "/workrepresentations/" => "/workrepresentations/540/",
      ".jpg" => "_540.jpg",
      ".png" => "_540.png"
    }

    replacer_array.each do |find, replace|
      fullsize_path.sub! find, replace
    end
    
    return fullsize_path
  end
end
