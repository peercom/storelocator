class StoresController < ApplicationController
  
  before_filter :authenticate_admin!, :except => [:index, :show]
  # GET /stores
  # GET /stores.json
  def index
    search = params[:search] unless params[:search].nil?
    @stores = Store.search(search)
    @json = Store.search(search).to_gmaps4rails do |store, marker|
      marker.infowindow render_to_string(:partial => "/stores/infowindow", :locals => { :store => store})
      marker.title "#{store.name}"
      marker.json ({ :zip => store.zip, :city => store.city })
      marker.picture({:picture => "/assets/marker.png",
                          :width => 32,
                          :height => 37})    
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        render json: @stores 
      }
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id])
    @json = @store.to_gmaps4rails do |store, marker|
      marker.infowindow render_to_string(:partial => "/stores/infowindow", :locals => { :store => store})
      marker.title "#{store.name}"
      marker.json ({ :zip => store.zip, :city => store.city })
      marker.picture({:picture => "/assets/marker.png",
                          :width => 32,
                          :height => 37})    
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.json
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(params[:store])
    @store.tenant = Tenant.current
    
    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render json: @store, status: :created, location: @store }
      else
        format.html { render "new" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.json
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end
  
end
