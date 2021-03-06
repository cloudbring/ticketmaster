require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Projects" do
  before(:each) do
    @ticketmaster = TicketMaster.new(:dummy, {})
    @project_class = TicketMaster::Provider::Dummy::Project
  end

  describe "with a connection to a provider" do
    it "should return an array" do
      @ticketmaster.projects.should be_an_instance_of(Array)
    end

    it "should return a project as first element" do
      @ticketmaster.projects.first.should be_an_instance_of(@project_class)
    end

    it "should return a project as last element" do
      @ticketmaster.projects.last.should be_an_instance_of(@project_class)
    end
    
    it "should return a Project by name from collection" do
      @ticketmaster.project(:name => "Whack whack what?").should be_an_instance_of(@project_class)
    end
    
    it "should have a project description for first project" do
      @ticketmaster.projects.first.description.should == "Mock!-ing Bird"
    end
    
    it "should have a project name for first project" do
      @ticketmaster.projects(:name => "Whack whack what?").first.name.should == "Whack whack what?"
    end
    
    describe "when searching by ID" do
      before do
        @project = @ticketmaster.projects(555)
      end

      it "should return an array" do
        @project.should be_an_instance_of(@project_class)
      end
      
      it "should return Project with the correct ID" do
        @project.id.should == 555
      end
    end

    describe "when searching with an array of IDs" do
      before do
        @projects = @ticketmaster.projects([555])
      end

      it "should return an array" do
        @projects.should be_an_instance_of(Array)
      end
      
      it "should return a Project as first element" do
        @projects.first.should be_an_instance_of(@project_class)
      end
      
      it "should return Project with the correct ID" do
        @projects.first.id.should == 555
      end
    end
    
    describe "when searching by hash" do
      before do
        @projects = @ticketmaster.projects(:id => 555)
      end

      it "should return an array" do
        @projects.should be_an_instance_of(Array)
      end
      
      it "should return a Project as first element" do
        @projects.first.should be_an_instance_of(@project_class)
      end
      
      it "should return Project with the correct ID" do
        @projects.first.id.should == 555
      end
    end
  end
  
  describe "for a specific project" do
    it "should return the first project by default" do
      @ticketmaster.project.should == @project_class
    end
    
    describe "with no params" do
      it "should return first Project" do
        @ticketmaster.project.first.description.should == "Mock!-ing Bird"
      end
      
      it "should return last project" do
        @ticketmaster.project.last.description.should == "Mock!-ing Bird"
      end
    end
    
    describe "when searching by hash" do
      it "should return first Project" do
        @ticketmaster.project.find(:first, :description => "Shocking Dirb").should be_an_instance_of(@project_class)
      end

      it "should return first Project with correct description" do
        @ticketmaster.project.find(:first, :description => "Shocking Dirb").description.should == "Shocking Dirb"
      end
      
      it "should return last Project" do
        @ticketmaster.project.find(:last, :description => "Shocking Dirb").should be_an_instance_of(@project_class)
      end

      it "should return last Project with correct description" do
        @ticketmaster.project.find(:last, :description => "Shocking Dirb").description.should == "Shocking Dirb"
      end      
    end    
  end
  
  describe "declaring a new project" do
    it "should return the correct class" do
      @ticketmaster.project.new(default_info).should be_an_instance_of(@project_class)
    end
    
    it "should have the correct name" do
      @ticketmaster.project.new(default_info).name.should == "Tiket Name  c"
    end
    
    it "should be able to be saved" do
      @ticketmaster.project.new(default_info).save.should be_true
    end
  end
  
  describe "creating a new project" do
    it "should return the correct class" do
      @ticketmaster.project.create(default_info).should be_an_instance_of(@project_class)
    end
    
    it "should have the correct name" do
      @ticketmaster.project.create(default_info).name.should == "Tiket Name  c"
    end
  end
  
  def default_info
    {:id => 777, :name => "Tiket Name  c", :description => "that c thinks the k is trying to steal it's identity"}
  end
end
