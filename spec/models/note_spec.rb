require 'rails_helper'

RSpec.describe Note, type: :model do
  describe('search message for a term') do
    before do
      @user = User.create(
        email: 'fff@yahoo.co.jp',
        password: 'password',
        first_name: 'eiji',
        last_name: 'kurita'
      )

      @project = @user.projects.create(name: 'project')

      @note1 = @project.notes.create(message: 'message1', user: @user)
      @note2 = @project.notes.create(message: 'message2', user: @user)
      @note3 = @project.notes.create(message: 'fffffff', user: @user)
    end

    context('when a match is found') do
      it('returns notes that match the search term') do
        expect(Note.search('message')).to include(@note1, @note2)
        expect(Note.search('message')).not_to include(@note3) 
      end
    end

    context('when a match is not found') do
      it('returns an empty collection when no results are found') do
        expect(Note.search('aaaaaa')).to eq([])
      end
    end
  end
end
