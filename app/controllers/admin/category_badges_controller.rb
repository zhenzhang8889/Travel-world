class Admin::CategoryBadgesController < Admin::BaseController
  # GET /category_badges
  # GET /category_badges.json
  def index
    @category_badges = CategoryBadge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_badges }
    end
  end

  # GET /category_badges/new
  # GET /category_badges/new.json
  def new
    @category_badge = CategoryBadge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_badge }
    end
  end

  # GET /category_badges/1/edit
  def edit
    @category_badge = CategoryBadge.find(params[:id])
  end

  # POST /category_badges
  # POST /category_badges.json
  def create
    @category_badge = CategoryBadge.new(params[:category_badge])

    respond_to do |format|
      if @category_badge.save
        format.html { redirect_to admin_category_badges_path, notice: 'Category badge was successfully created.' }
        format.json { render json: @category_badge, status: :created, location: @category_badge }
      else
        format.html { render action: "new" }
        format.json { render json: @category_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category_badges/1
  # PUT /category_badges/1.json
  def update
    @category_badge = CategoryBadge.find(params[:id])

    respond_to do |format|
      if @category_badge.update_attributes(params[:category_badge])
        format.html { redirect_to admin_category_badges_path, notice: 'Category badge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_badges/1
  # DELETE /category_badges/1.json
  def destroy
    @category_badge = CategoryBadge.find(params[:id])
    @category_badge.destroy

    respond_to do |format|
      format.html { redirect_to admin_category_badges_path }
      format.json { head :no_content }
    end
  end
end
