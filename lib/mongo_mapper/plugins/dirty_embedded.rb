module MongoMapper
  module Plugins
    module DirtyEmbedded
      
      extend ActiveSupport::Concern



      # ----------------------------------------------------------------------
      module ClassMethods    
      end



      # ----------------------------------------------------------------------
      module InstanceMethods
        
        # don't understand why this is need
        # remove changed_attribute if it has the same value like the current attribute value
        def changed_attributes
          super.delete_if{|k,v| v == __send__(k)}
        end
                
        protected
        
        # overwrite default, to also include all attributes
        def attribute_method?(attr)
          super || attributes.keys.include?(attr)
        end
                
      end
      
      
      
      # ----------------------------------------------------------------------
      included do
      end

    end
  end
end
