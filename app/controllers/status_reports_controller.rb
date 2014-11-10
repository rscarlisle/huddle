#---
# Excerpted from "Rails Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest for more book information.
#---
class StatusReportsController < ApplicationController
  # GET /status_reports
  # GET /status_reports.xml
  def index
    @status_reports = StatusReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @status_reports }
    end
  end

  # GET /status_reports/1
  # GET /status_reports/1.xml
  def show
    @status_report = StatusReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status_report }
    end
  end

  # GET /status_reports/new
  # GET /status_reports/new.xml
  def new
    @status_report = StatusReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status_report }
    end
  end

  # GET /status_reports/1/edit
  def edit
    @status_report = StatusReport.find(params[:id])
  end

  # POST /status_reports
  # POST /status_reports.xml
  def create
    redirect_if_not_current_user(params[:status_report][:user_id]) and return 
    params[:status_report].merge!(:user_id => current_user.id,
        :project_id => current_project.id)
    @status_report = StatusReport.new(params[:status_report])
    respond_to do |format|
      if @status_report.save
        flash[:notice] = 'StatusReport was successfully created.'
        format.html { redirect_to(@status_report) }
        format.xml  { render :xml => @status_report, :status => :created, 
            :location => @status_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status_report.errors, 
            :status => :unprocessable_entity }
      end
    end
  end

  # PUT /status_reports/1
  # PUT /status_reports/1.xml
  def update
    @status_report = StatusReport.find(params[:id])

    respond_to do |format|
      if @status_report.update_attributes(params[:status_report])
        flash[:notice] = 'StatusReport was successfully updated.'
        format.html { redirect_to(@status_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /status_reports/1
  # DELETE /status_reports/1.xml
  def destroy
    @status_report = StatusReport.find(params[:id])
    @status_report.destroy

    respond_to do |format|
      format.html { redirect_to(status_reports_url) }
      format.xml  { head :ok }
    end
  end
end
