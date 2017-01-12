require_dependency "erp/backend/backend_controller"

module Erp
  module Industries
    module Backend
      class IndustriesController < Erp::Backend::BackendController
        before_action :set_industry, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_industries, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /industries
        def index
        end
    
        # POST /industries/list
        def list
          @industries = Industry.search(params).paginate(:page => params[:page], :per_page => 10)
          
          render layout: nil
        end
    
        # GET /industries/new
        def new
          @industry = Industry.new
        end
    
        # GET /industries/1/edit
        def edit
        end
    
        # POST /industries
        def create
          @industry = Industry.new(industry_params)
          @industry.creator = current_user
    
          if @industry.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @industry.name,
                value: @industry.id
              }
            else
              redirect_to erp_industries.edit_backend_industry_path(@industry), notice: t('.success')
            end
          else
            render :new        
          end
        end
    
        # PATCH/PUT /industries/1
        def update
          if @industry.update(industry_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @industry.name,
                value: @industry.id
              }              
            else
              redirect_to erp_industries.edit_backend_industry_path(@industry), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /industries/1
        def destroy
          @industry.destroy

          respond_to do |format|
            format.html { redirect_to erp_industries.backend_industries_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @industry.archive
          respond_to do |format|
            format.html { redirect_to erp_industries.backend_industries_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @industry.unarchive
          respond_to do |format|
            format.html { redirect_to erp_industries.backend_industries_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /industries/delete_all?ids=1,2,3
        def delete_all         
          @industries.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /industries/archive_all?ids=1,2,3
        def archive_all         
          @industries.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /industries/unarchive_all?ids=1,2,3
        def unarchive_all
          @industries.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Industry.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_industry
            @industry = Industry.find(params[:id])
          end
          
          def set_industries
            @industries = Industry.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def industry_params
            params.fetch(:industry, {}).permit(:name, :description)
          end
      end
    end
  end
end
