require 'test_helper'



# ---------------------------------------------------------------------------
# CLASS SETUP

class Doc
  include MongoMapper::Document
  plugin MongoMapper::Plugins::DirtyEmbedded
  key :title, String
  many :e_docs
end

class EDoc
  include MongoMapper::EmbeddedDocument
  plugin MongoMapper::Plugins::Dirty
  key :title, String
  embedded_in :doc
end


# ---------------------------------------------------------------------------
# TESTS

class DirtyEmbeddedTest < ActiveSupport::TestCase
  
  context "doc" do
    
    setup do
      @doc = Doc.new
      @edoc = EDoc.new
    end
    
    should "have required methods" do
      assert_respond_to @doc, :e_docs_changed?
      assert_respond_to @doc, :e_docs_change
      assert_respond_to @doc, :e_docs_was
      assert_respond_to @doc, :e_docs_will_change!
    end
    
    # --------------------------------------------------
    
    context "adding an edoc" do
      
      setup do
        @doc.e_docs_will_change! # TODO: this needs to be moved to the association proxy
        @doc.e_docs << @edoc
      end
    
      should "have embedded document" do
        assert @doc.e_docs.present?
      end
        
      should "change" do
        assert @doc.changed?
      end
    
      should "track changes" do
        assert @doc.changes, {:e_docs => [[], [@edoc]]}
      end
    
      should "track e_docs changed?" do
        assert @doc.e_docs_changed?
      end
    
      should "track e_docs change" do
        assert @doc.e_docs_change, [[], [@edoc]]
      end
      
      # --------------------------------------------------
      
      context "removing an edoc" do
        
        setup do
          @doc.e_docs.delete( @edoc )
        end
        
        should "not change" do
          assert !@doc.changed?
        end
        
        should "have no changes" do
          assert @doc.changes, {}
        end
        
        should "have e_docs not changed?" do
          assert !@doc.e_docs_changed?
        end
        
        should "have no e_docs change" do
          assert_nil @doc.e_docs_change
        end
        
      end

      # --------------------------------------------------
      
      context "after save" do

        setup do
          @doc.save
        end
        
        should "not change" do
          assert !@doc.changed?
        end
                
        should "have no changes" do
          assert @doc.changes, {}
        end
        
        should "have e_docs not changed?" do
          assert !@doc.e_docs_changed?
        end
        
        should "have no e_docs change" do
          assert_nil @doc.e_docs_change
        end
        
        # --------------------------------------------------
        
        context "after removal" do
          
          setup do
            @doc.e_docs_will_change! # TODO: this needs to be moved to the association proxy
            @doc.e_docs.delete( @edoc )
          end
          
          should "change" do
            assert @doc.changed?
          end

          should "track changes" do
            assert @doc.changes, {:e_docs => [[@edoc], []]}
          end

          should "track e_docs changed?" do
            assert @doc.e_docs_changed?
          end

          should "track e_docs change" do
            assert @doc.e_docs_change, [[@edoc], []]
          end
          
        end
        
      end

    end
        
  end
  
end
