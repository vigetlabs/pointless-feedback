require 'test_helper'

module PointlessFeedback
  class MessagesControllerTest < ActionController::TestCase
    describe "getting new" do
      setup { get :new, :use_route => :pointless_feedback }

      it { assert_response :success }
      it { assert_template :new }
      it { assigns(:message).must_be_instance_of Message }
    end

    describe "posting to create" do
      setup do
        @valid_params = {
          :message => {
            :name          => 'Some Guy',
            :email_address => 'some_guy@web.com',
            :topic         => 'Pls Halp',
            :description   => 'Yo website bork'
          },
          :use_route => :pointless_feedback
        }
      end

      describe "with invalid params" do
        setup do
          post :create, @valid_params.merge(:message => { :name => ''})
        end

        it { assert_response :success }
        it { assert_template :new }

        it { assigns(:message).must_be :invalid? }
      end

      describe "with valid params" do
        setup do
          post :create, @valid_params
        end

        it { assert_response :redirect }
        it { assert_redirected_to '/' }
        it { flash[:notice].must_equal 'Thanks for your feedback!' }
      end
    end
  end
end
