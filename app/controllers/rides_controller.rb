class RidesController < ApplicationController
  include RidesHelper

  before_filter :authenticate_user!, :except => [:index, :show, :search, :search_rides, :new, :hook_on, :look_to_hook_on]
  before_filter :seat_available?, :only => [:hook_on]
  # GET /rides
  # GET /rides.json
  def index
    @rides = Ride.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rides }
    end
  end

  # GET /rides/1
  # GET /rides/1.json
  def show
    @ride = Ride.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ride }
    end
  end

  # GET /rides/new
  # GET /rides/new.json
  def new
    session[:return_to] = request.referer
    @ride = Ride.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ride }
    end
  end

  # GET /rides/1/edit
  def edit
    @ride = Ride.find(params[:id])
  end

  # POST /rides
  # POST /rides.json
  def create
    @ride = current_user.rides.build(params[:ride])

    respond_to do |format|
      if @ride.save
        @ride.sources.create(:address => params[:ride][:source])
        @ride.destinations.create(:address => params[:ride][:destination])
        notice = post_to_facebook(params[:ride]) if params[:post_to_facebook]
        format.html { redirect_to @ride, :notice => "Ride was successfully created. #{notice}" }
        format.json { render :json => @ride, :status => :created, :location => @ride }
      else
        format.html { render :action => "new" }
        format.json { render :json => @ride.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rides/1
  # PUT /rides/1.json
  def update
    @ride = Ride.find(params[:id])

    respond_to do |format|
      if @ride.update_attributes(params[:ride])
        format.html { redirect_to @ride, :notice => 'Ride was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @ride.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1
  # DELETE /rides/1.json
  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy

    respond_to do |format|
      format.html { redirect_to rides_url }
      format.json { head :no_content }
    end
  end

  def search
    @search = Ride.search(params[:search])
  end

  def search_rides
    params[:search].delete_if {|k, v| v.empty?}
    @search = Ride.search(params[:search])
    @rides = @search.relation
    respond_to do |format|
      format.html {render :action => 'index'}
      format.json { render :json => @rides }
    end
  end

  def look_to_hook_on
    @ride = Ride.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ride }
    end
  end

  def hook_on
    @ride = Ride.find(params[:id])
    @ride.riders.create({:name => params[:name], :phone => params[:phone], :address => params[:address]})
    @ride.update_attribute(:seats, @ride.seats-1 )
    respond_to do |format|
      format.html { render :text => "Name: #{@ride.user.name}, Contact Number: #{@ride.user.phone}", :layout => true }
      format.json { head :no_content }
    end
  end

  private

  def seat_available?
    @ride = Ride.find(params[:id])
    unless @ride.seat_available?
      respond_to do |format|
        format.html { redirect_to root_url, :notice => "Sorry! Seats not available", :status => 404 }
        format.json { head :no_content }
      end
    end
  end
end
