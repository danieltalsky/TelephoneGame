class PagesController < ApplicationController
  caches_action :about, :links, :sponsors, :essays, :essay_lindsey_allgood, :essay_nathan_langston, :essay_peter_crack
end
