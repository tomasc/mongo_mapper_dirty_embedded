require 'test_helper'



# ---------------------------------------------------------------------------
# CLASS SETUP

class Doc
  include MongoMapper::Document
  many :e_docs
end

class EDoc
  include MongoMapper::EmbeddedDocument
  embedded_in :doc
end


# ---------------------------------------------------------------------------
# TESTS

class DirtyEmbeddedTest < ActiveSupport::TestCase
  
  context "by default" do
    
    setup do
      @doc = Doc.new
      @doc.e_docs << EDoc.new
    end
    
    should "have embedded document" do
      assert @doc.e_docs.present?
    end
    
  end
  
end
