class WorksController < ApplicationController
  before_filter :authorize
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  # GET /works
  def index
    @works = Work.all
  end

  # GET /works/tree
  def tree
    rootWork = Work.find_by_parent_id(nil)
    @treehtml = '<ul>' + generate_nested_list(rootWork) + '</ul>'
  end
  
  # GET /works/jsontree
  def jsontree
    rootWork = Work.all#Work.find_by_parent_id(nil)
    @treehtml = rootWork
  end  
  
  def generate_nested_list (node)
    ghtml = '<li><a href="/works/%s" class="%s">'%[node.id, node.medium] + node.title + '</a>'
    unless node.children.empty?
      ghtml << '<ul>'
      node.children.each do |childnode|
        ghtml << generate_nested_list(childnode)
      end
      ghtml << '</ul>'
    end
    ghtml << '</li>'
    ghtml
  end
  
  # GET /works/1
  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)  
  end
  
  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to @work, notice: 'Work was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /works/1
  def update
    if @work.update(work_params)
      redirect_to @work, notice: 'Work was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /works/1
  def destroy
    @work.destroy
    redirect_to works_url, notice: 'Work was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def work_params
      params.require(:work).permit(:title, :parent_id, :artist_id, :medium)
    end
end
