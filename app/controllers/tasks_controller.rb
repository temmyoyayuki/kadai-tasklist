class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show, :new, :edit, :destroy]
  before_action :ensure_correct_user, only: [:show, :edit]
  
    def index
        if logged_in?
            @user = current_user
            @task = current_user.tasks.build
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
        end
    end  
    
    def show
         
    end    
    
    def new
        @task = current_user.tasks.build
    end    
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save(task_params)
            flash[:success] = 'タスクが正常に作成されました'
            redirect_to @task
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = 'タスクの作成に失敗しました'
            render :new
        end    
    end    
    
    def edit
         
    end    
    
    def update
        if @task.update(task_params)
            flash[:success] = 'タスクが正常に作成されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクの作成に失敗しました'
            render :edit
        end    
    end    
    
    def destroy
        @task.destroy
        
        flash[:success] = 'タスクは正常に削除されました'
        redirect_to root_path
    end    

    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end    
    
    def ensure_correct_user
        @task = Task.find_by(params[:id])
        if current_user.id != @task.user_id
           flash[:danger] = 'ページを表示できません'    
           redirect_to login_path
        end   
    end
end
