require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { build(:user) }
  let(:mail) { UserMailer.welcome_email(user) }

  it('メールをユーザーにを送信する') do
    expect(mail.to).to eq([user.email])
  end

  it('サポートからメールを送信する') do
    expect(mail.from).to eq(['support@example.com'])
  end

  it('正しい件名でメールを送信する') do
    expect(mail.subject).to eq('Welcome to Projects!')
  end

  it('ユーザーのファーストネームが本文に含まれている') do
    expect(mail.body).to match(user.first_name)
  end
end
