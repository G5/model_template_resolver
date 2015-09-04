require 'rails_helper'

RSpec.describe ModelTemplateResolver do

  describe ".new" do
    let(:model) { double }
    let(:resolver) { double }

    it "returns an instance of ModelTemplateResolver::Resolver" do
      expect(ModelTemplateResolver::Resolver).
        to receive(:new).
        with(template: "a", view_paths: [], model: model).
        and_return(resolver)

      expect(described_class.new(template: "a", view_paths: [], model: model)).
        to eq resolver
    end
  end

end
