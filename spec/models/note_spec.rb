require 'rails_helper'

RSpec.describe Note, type: :model do
  describe('search message for a term') do
    let(:project) { create(:project) }
    let!(:note1) { create(:note, message: 'message1', project: project) }
    let!(:note2) { create(:note, message: 'message2', project: project) }
    let!(:note3) { create(:note, message: 'ffffffff', project: project) }

    context('when a match is found') do
      it('returns notes that match the search term') do
        expect(Note.search('message')).to include(note1, note2)
        expect(Note.search('message')).not_to include(note3) 
      end
    end

    context('when a match is not found') do
      it('returns an empty collection when no results are found') do
        expect(Note.search('aaaaaa')).to eq([])
      end
    end
  end

  it('delegate(:name, to: :user, prefix: true)') do
    user_double = instance_double(User, name: 'kurita eiji')
    note = Note.new
    allow(note).to receive(:user).and_return(user_double)
    expect(note.user_name).to eq('kurita eiji')
  end
end
