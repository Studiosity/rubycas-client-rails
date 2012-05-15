require 'cerebro/role'
module Cerebro
  class User < ActiveResource::Base
    self.site = "http://localhost/cerebro"

    def roles
      # TODO - Cache this to prevent needing to round trip to cerebro everytime
      Cerebro::Role.find(:all, :params => {:user_id => self.id})
    end

    def mentor?
      has_role?(:mentor)
    end
    
    def tutor?
      has_role?(:tutor)
    end
    
    def admin?
      has_role?(:admin)
    end

    def full_name
      names.join(' ')
    end

    def first_name_last_initial
      self.first_name + " " + self.last_name[0]
    end

    def reverse_full_name
      names.reverse.join(', ')
    end


    private

    def has_role?(role)
      self.roles.collect{|r| r.name.downcase.to_sym}.include?(role)
    end

    def names
     [self.first_name, self.last_name].compact
    end
  end
end
