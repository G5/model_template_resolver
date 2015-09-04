require 'rails_helper'

module ModelTemplateResolver
  RSpec.describe Resolver do

    let(:lookup_context) do
      ActionView::LookupContext.new(view_paths,
        details: {
          locale: [:en],
          formats: [:html],
          variants: [],
          handlers: [:erb, :builder, :raw, :ruby],
        },
      )
    end

    let(:view_paths) do
      ActionView::PathSet.new([Rails.root.join("app", "views")])
    end

    describe "#path" do
      context "given a base model" do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            template: "template_in_both",
            model: Animal.new,
          )
        end

        it "returns the path to the base template" do
          expect(resolver.path).to eq "animals/template_in_both"
        end
      end

      context "given an STI model", "template exists in sub class dir" do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            template: "template_in_both",
            model: Cat.new,
          )
        end

        it "returns the path to the template" do
          expect(resolver.path).to eq "cats/template_in_both"
        end
      end

      context "given an STI model", "template does not exist in sub dir" do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            template: "template_in_base",
            model: Cat.new,
          )
        end

        it "returns the path to the template" do
          expect(resolver.path).to eq "animals/template_in_base"
        end
      end

      context "given an STI model", "partial exists in sub class dir" do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            partial: "partial_in_siamese_cats",
            model: SiameseCat.new,
          )
        end

        it "returns the path to the partial" do
          expect(resolver.path).to eq "siamese_cats/partial_in_siamese_cats"
        end
      end

      context "given an STI model", "partial does not exist in sub dir" do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            partial: "partial_in_base",
            model: Cat.new,
          )
        end

        it "returns the path to the partial" do
          expect(resolver.path).to eq "animals/partial_in_base"
        end
      end

      context(
        "given a deeply inherited STI model",
        "partial exists in parent",
      ) do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            partial: "partial_in_cats",
            model: SiameseCat.new,
          )
        end

        it "returns the path to the partial" do
          expect(resolver.path).to eq "cats/partial_in_cats"
        end
      end

      context(
        "given a deeply inherited STI model",
        "partial does not exist in sub any dir",
      ) do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            partial: "partial_in_base",
            model: SiameseCat.new,
          )
        end

        it "returns the path to the partial" do
          expect(resolver.path).to eq "animals/partial_in_base"
        end
      end

      context "given a model that is not an active record base instance" do
        let(:resolver) do
          described_class.new(
            lookup_context: lookup_context,
            template: "non_existent",
            model: Object.new,
          )
        end

        it "raises an error" do
          expect { resolver.path }.to raise_error(
            ArgumentError,
            "model given is not an ActiveRecord::Base model"
          )
        end
      end
    end

  end
end
