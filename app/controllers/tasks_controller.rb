class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action { request.format = :json }
  before_action :set_task, only: [:show, :edit, :update, :destroy, :start, :finish]

  def start
    return head 404 if @task.nil?
    @task.start
    render :show
  end

  def finish
    return head 404 if @task.nil?
    @task.finish
    render :show
  end

  # GET /tasks
  # GET /tasks.json
  def index
    user_id = task_params[:user_id]

    if user_id.present?
      @tasks = Task.where user_id: user_id
    else
      @tasks = Task.all
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find_by id: params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.permit(:title, :user_id)
    end
end
