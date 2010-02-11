class PlayersController < ApplicationController
  acts_as_iphone_controller
  
  # safe_helper :application
  # GET /players
  # GET /players.xml
  def index
    @players = Player.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
      format.iphone
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])
    @statistics = Statistic.create_detailed_statistics_for(@player)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
      format.iphone
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        flash[:notice] = 'Registration successfull.'
        format.html { redirect_to(@player) } #{ redirect_to(root_url) }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    # @player = current_player
    @player = Player.find(params[:id])
  
    respond_to do |format|
      if @player.update_attributes(params[:player])
        flash[:notice] = 'Player profile was successfully updated.'
        format.html { redirect_to(@player) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  # def destroy
  #   @player = Player.find(params[:id])
  #   @player.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(players_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
