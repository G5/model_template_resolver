# TemplateResolver

Resolve a template (full template or partial) without the help of a controller.

Currently, this gem *may* support locales, formats, and handlers. The tests cover only one locale, format, and handler.

## Description

When Rails is asked to render the `form` partial, Rails will look for `_form` (let's not consider the locale, format, etc for this example) in directories based on the heirarchy of the controller that is rendering the content.

Here's an example in code.

Given these models:

```ruby
class Animal < ActiveRecord::Base; end
class Cat < Animal; end
class SiameseCat < Cat; end
```

And given these controllers:

```ruby
class ApplicationController < ActionController::Base; end
class AnimalsController < ApplicationController; end
class CatsController < AnimalsController; end
class SiameseCatsController < CatsController; end
```

When `SiameseCatsController`'s `edit.html.erb` renders a partial `form`, Rails will look in the following places, until it finds a match:

1. `app/views/siamese_cats/_form.html.erb`
2. `app/views/cats/_form.html.erb`
3. `app/views/animals/_form.html.erb`

If Rails is asked to render the partial `cats/form`, it won't go through the heirarchy above. It will look directly at `app/views/cats/_form.html.erb`. `ModelTemplateResolver` returns a path that already includes what file to look at. Here's how you might use `ModelTemplateResolver`:

```ruby
class AnimalsController < ApplicationController
  def edit
    @animal = Animal.find(params[:id])
  end

  def model_partial_for(name)
    resolver = ModelTemplateResolver.new(model: @animal, partial: name, lookup_context: lookup_context)
    resolver.path
  end
  helper_method :model_template_for
end
```

In `animals/edit.html.erb`:

```erb
<%= render partial: model_partial_for("form") %>
```

The partial, following the heirarchy of the model, will be returned by `ModelTemplateResolver`.

## MIT LICENSE

Copyright 2015 G5

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
