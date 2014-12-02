TelephoneGame::Application.routes.draw do

  get "application/index"
  get "works/tree"
  get "works/jsontree"
  get "works/by_medium"
  get "pages/map_concept"
  get "pages/about"
  resources :works
  resources :artists
  resources :curated_tours do
    resources :curated_tour_stops 
  end   
  # You can have the root of your site routed with "root"
  root 'application#index'

  # Admin Interface
  namespace :admin do
    # Directs /admin/artists/* to Admin::ArtistsController
    # (app/controllers/admin/artist_controller.rb)
    resources :works
    resources :work_representations
    resources :artists
    resources :curated_tour_stops
    resources :curated_tours
    get "data/import_spreadsheet"
    get "data/import_bios"    
    get "data/import_work_representations"
    get "data/populate_tour"
    get "works/tree"
    get "works/jsontree"
    get "application/index"
    root 'application#index'
  end
  
end
