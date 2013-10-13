class WorksController < ApplicationController
  before_filter :authorize
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  # GET /works
  def index
    @works = Work.all
  end

  # GET /works/tree
  def tree
    #@works = Work.all
    rootWork = Work.find_by_parent_id(nil)
    @treehtml = generate_nested_list(rootWork)
    #@tree = rootWork.descendents()
    #@tree = ActsAsSaneTree::nodes_and_descendents(rootWork)
  end
  
  def generate_nested_list (node)
    ghtml = '<ul>'    
    unless node.children.empty?
        node.children.each do |childnode|
            ghtml << '<li>'
            ghtml << '<a href="/works/%s" class="%s">'%[childnode.id, childnode.medium] + childnode.title + '</a>'
            ghtml << generate_nested_list(childnode)
            ghtml << '</li>'
        end
    end
    ghtml << '</ul>'
    ghtml
  end
  
  # GET /works/1
  def show
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
