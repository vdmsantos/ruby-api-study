require 'swagger_helper'

RSpec.describe 'Users API' do
  path '/users' do
    get 'Retrieves all users' do
      tags 'Users'
      response '200', 'users found' do
        run_test!
      end
      post 'Creates a user' do
        tags 'Users'
        consumes 'application/json'
        parameter name: :user, in: :body, required: true, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string }
          },
          required: [ 'name', 'email' ]
        }

        # response '201', 'user created' do
        #   let(:user) { { name: 'João', email: 'joao2@example.com' } }
        #   run_test!
        # end

        response '422', 'invalid request' do
          let(:user) { { name: '' } }
          run_test!
        end
      end
    end

    path '/users/{id}' do
      get 'Retrieves a user' do
        tags 'Users'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string, description: 'User ID'

        response '200', 'user found' do
          let(:id) { User.create(name: 'João', email: 'joao2@example.com').id }
          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      put 'Updates a user' do
        tags 'Users'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string, description: 'User ID'
        parameter name: :user, in: :body, required: true, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string }
          },
          required: [ 'name', 'email' ]
        }

        # response '200', 'user updated' do
        #   let(:id) { User.create(name: 'João', email: 'joao@example.com').id }
        #   let(:user) { { name: 'João Atualizado', email: 'joaoatualizado@example.com' } }
        #   run_test!
        # end

        # response '422', 'invalid request' do
        #   let(:id) { User.create(name: 'João', email: 'joao@example.com').id }
        #   let(:user) { { name: '' } }
        #   run_test!
        # end
      end

      delete 'Deletes a user' do
        tags 'Users'
        parameter name: :id, in: :path, type: :string, description: 'User ID'

        # response '204', 'user deleted' do
        #   let(:id) { User.create(name: 'João', email: 'joao@example.com').id }
        #   run_test!
        #   run_test!
        # end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end
end
