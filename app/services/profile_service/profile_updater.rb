module ProfileService
  class ProfileUpdater < ApplicationService
    attr_reader :profile, :permitted_params
    def initialize(profile, permitted_params)
      @profile = profile
      @permitted_params = permitted_params
    end

    def execute
      @profile.update(@permitted_params)
    end
  end
end