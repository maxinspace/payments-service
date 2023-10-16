require 'rails_helper'

describe JsonWebToken do
  describe '.encode' do
    subject(:encode) { described_class.encode(payload) }

    let(:payload) { { user_id: 1 } }

    it 'returns a JWT' do
      expect(encode).to be_a(String)
    end
  end

  describe '.decode' do
    subject(:decode) { described_class.decode(token) }

    let(:token) { described_class.encode(payload) }
    let(:payload) { { user_id: 1 } }

    it 'returns a payload' do
      expect(decode[:exp]).to eq(payload[:exp])
      expect(decode[:user_id]).to eq(payload[:user_id])
    end
  end
end