class ZombiesController < ApplicationController
  before_action :set_zombie, only: [:show, :edit, :update, :destroy]

  # GET /zombies
  # GET /zombies.json
  def index
    @zombies = Zombie.all
        logger = Logger.new("log/db_issues.log")
        logger.error "look at me"
        logger.close
  end

  # GET /zombies/1
  # GET /zombies/1.json
  def show
    @zombie_f = Zombie.find(params[:id])
    @params_hash = params
    
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
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zombie
      @zombie = Zombie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zombie_params
      params.require(:zombie).permit(:name, :bio, :age)
    end
end
