# Handles CRUD operations for Metum objects
# @see Metum
class MetaController < ApplicationController
  before_action :set_metum, only: %i[show edit update destroy]
  before_action :authorize_general_access, only: %i[new index create]
  before_action :authorize_unit_access,    only: %i[show edit update destroy]

  helper_method :list_of_meta, :metum

  # GET /meta
  def index
  end

  # GET /meta/1
  def show
  end

  # GET /meta/new
  def new
    self.metum = current_organization.meta.new
  end

  # GET /meta/1/edit
  def edit
  end

  # POST /meta
  def create
    self.metum = current_organization.meta.new(metum_params)

    if metum.save
      logger.info "Created #{metum}"
      redirect_to [current_organization, metum], notice: 'Metum was successfully created.'
    else
      logger.warn "Unable to create Metum: '#{metum.error_sentence}'"
      render :new
    end
  end

  # PATCH /meta/1
  def update
    if metum.update(metum_params)
      redirect_to [current_organization, metum], notice: 'Metum was successfully updated.'
    else
      logger.warn "Unable to update #{metum}: '#{metum.error_sentence}'"
      render :edit
    end
  end

  private

  attr_accessor :metum

  def list_of_meta
    current_organization.meta
  end

  def set_metum
    self.metum = current_organization.meta.find(params[:id])
  end

  def metum_params
    params.require(:metum).permit(:title, :instructions)
  end

  def authorize_general_access
    authorize Metum
  end

  def authorize_unit_access
    authorize(metum)
  end
end
