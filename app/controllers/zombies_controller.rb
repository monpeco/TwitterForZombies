include FormatHelper

class ZombiesController < ApplicationController
  before_action :set_zombie, only: [:show, :edit, :update, :destroy]

  # GET /zombies
  # GET /zombies.json
  def index
    @zombies = Zombie.all
        logger = Logger.new("log/db_issues.log")
        logger.error "look at me"
        logger.close
        
    @find_it = find_column()

  end

  # GET /zombies/1
  # GET /zombies/1.json
  def show
    @zombie_f = Zombie.find(params[:id])
    @params_hash = params
    @env_var = ENV['IP']
    @env_space = ENV['space']
    
    respond_to do | format |
      format.html
      format.json
    end
  end

  # GET /zombies/new
  def new
    @zombie = Zombie.new
    @article = 'my personal article'
  end

  # GET /zombies/1/edit
  def edit
    @params_to_edit = params
    render  :another    #or render  'another'
  end

  # GET /zombies/1/edit
  def wannabe
    @wannabe = Zombie.where(email: nil)
    @my_flash = { a: 1, b: 2, c: 3, d: 4 }
    @my_format = FormatHelper.print_hello
    
    @current_human = Human.find(4)
    @zombie_like_human = Zombie.first
  end
  
  # POST /zombies
  # POST /zombies.json
  def create
    @zombie = Zombie.new(zombie_params)

    respond_to do |format|
      if @zombie.save
        format.html { redirect_to @zombie, notice: 'Zombie was successfully created.' }
        format.json { render :show, status: :created, location: @zombie }
      else
        format.html { render :new }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zombies/1
  # PATCH/PUT /zombies/1.json
  def update
    respond_to do |format|
      if @zombie.update(zombie_params)
        format.html { redirect_to @zombie, notice: 'Zombie was successfully updated.' }
        format.json { render :show, status: :ok, location: @zombie }
      else
        format.html { render :edit }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zombies/1
  # DELETE /zombies/1.json
  def destroy
    @zombie.destroy
    respond_to do |format|
      format.html { redirect_to zombies_url, notice: 'Zombie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def other_option
    Zombie.all.map { |g| [g.name.titleize , g.id.to_s] } 
  end

    def add_to_cookie (id=0)
        unless cookies[:scotids]
            cookies[:scotsids] = JSON.generate(["#{id}"])
        else
            cookies[:scotsids] = JSON.parse(cookies[:scotsids]) << "#{id}"
        end
        
        redirect_to :action => :wannabe
    end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zombie
      @zombie = Zombie.find(params[:id])
    end
    
    # Method that looks for a column name in all Model and return the Model name if find it
    def find_column(column_name = 'fighting')
      find_it = 'not found'
      array_model = []
      
      #find all the Model names
      array_model = ActiveRecord::Base.connection.tables.map do |model|
        model.capitalize.singularize.camelize
      end
      
      array_model.delete_if{|i|i=='SchemaMigration'} #Remove the SchemaMigration
      
      #Get the `column_names` of every Model, and check if is the name that you are searching
      array_model.each do |model|
      	tmp = eval model + ".column_names" 
      	tmp.each {|col| find_it = model if col == column_name} 
      end
      
      find_it
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zombie_params
      params.require(:zombie).permit(:name, :bio, :age)
    end
end
