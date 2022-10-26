class TdasController < ApplicationController
  def index
    @tdas = Tda.all
  end

  def show
    @tda = Tda.find(params[:id])
  end

  def new
    @tda = Tda.new
  end
  def create
    #byebug
    @tda = Tda.new(tda_params)
    if @tda.save
      redirect_to @tda
    else
      render 'new'
    end
  end
  def edit
    @tda = Tda.find(params[:id])
  end
  def update
    @tda = Tda.find(params[:id])

    if @tda.update(tda_params)
      redirect_to @tda
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tda = Tda.find(params[:id])
    @tda.destroy

    redirect_to tdas_path
  end

  def tda_params
    params.require(:tda).permit(:name, :minute)
  end

end
