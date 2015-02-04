module WorksHelper
  
  def get_resized_jpg_path(fullsize_path)
    return_path = fullsize_path
    replacer_array = {
      "/workrepresentations/" => "/workrepresentations/540/",
      ".jpg" => "_540.jpg",
      ".png" => "_540.jpg"
    }
    replacer_array.each do |find, replace|
      return_path = return_path.sub find, replace
    end    
    return return_path
  end
  
  def get_fullsized_jpg_path(fullsize_path)
    return_path = fullsize_path
    replacer_array = {
      "/workrepresentations/" => "/workrepresentations/960/",
      ".jpg" => "_960x620.jpg",
      ".png" => "_960x620.jpg"
    }
    replacer_array.each do |find, replace|
      return_path = return_path.sub find, replace
    end    
    return return_path
  end  
  
  def get_coordinates_for_work_id(work_id)
    return [work_id + work_id, work_id + work_id]
  end
  
end
