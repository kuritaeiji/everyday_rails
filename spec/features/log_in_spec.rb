require 'rails_helper'

RSpec.feature "LogIns", type: :feature do
  let(:user) { create(:user) }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  scenario('log in') do
    visit(root_path)
    click_on('Sign In')

    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')

    expect {
      GeocodeUserJob.perform_later(user)
    }.to have_enqueued_job.with(user)
  end

  scenario('ログインするとメールが送信される') do
    perform_enqueued_jobs do
      expect { log_in(user) }.to change(User, :count).by(1)
    end

    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['support@example.com'])
      expect(mail.subject).to eq('Welcome to Projects!')
      expect(mail.body).to match(user.first_name)
    end
  end
end
