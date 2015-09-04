module ModelTemplateResolver
  class Resolver

    def initialize(opts={})
      @lookup_context = opts.fetch(:lookup_context)
      @template = opts[:template] || opts[:partial]
      @is_partial = opts.has_key?(:partial)
      @model = opts.fetch(:model)
    end

    def path
      if !(@model.class < ActiveRecord::Base)
        fail ArgumentError, "model given is not an ActiveRecord::Base model"
      end

      resources_names = @model.class.ancestors.select do |klass|
        klass < ActiveRecord::Base
      end.map { |klass| klass.name.underscore.pluralize }

      template = @lookup_context.find(@template, resources_names, @is_partial)
      template ? template.virtual_path.gsub("/_", "/") : nil
    end

  end
end
