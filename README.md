## README ##

Initial Setup of the project...


```shell
rails new snap_receipts -d postgresql -T
```

```shell
rails g model report title:string description:text
```

```shell
bin/rake db:create db:migrate
```

```shell
rails generate controller reports index new create show edit update destroy
```

```shell
rails g controller home index
```

```ruby
Rails.application.routes.draw do
  resources :reports

  root 'home#index'
end
```

```shell
rails g model receipt business_name:string sub_total:decimal tax_total:decimal total:decimal tax_type:string report:references
```

Add in `precision: 8, scale: 2` to decimal

```ruby
class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :business_name
      t.decimal :sub_total, precision: 8, scale: 2
      t.decimal :tax_total, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.string :tax_type
      t.references :report, index: true

      t.timestamps null: false
    end
    add_foreign_key :receipts, :reports
  end
end
```

```shell
bin/rake db:migrate
```

```ruby
class Receipt < ActiveRecord::Base
  belongs_to :report
end
```

```ruby
class Report < ActiveRecord::Base
  has_many :receipts
end
```

```shell
rails generate controller receipts index new create show edit update destroy
```

Nest the resources in the routes.rb
```ruby
  resources :reports do
    resources :receipts
  end
```

Create CRUD for Report
```
Instantiate instance variable and define CRUD actions in the Reports Controller
```

Implement Bootstrap Gem
```html
Follow the documentation
https://github.com/twbs/bootstrap-sass
```

Added font-awesome Gem
```css
https://github.com/bokmann/font-awesome-rails

gem "font-awesome-rails"

@import "font-awesome";
```

Create CRUD for Receipts
```
Instantiate instance variable and define CRUD actions in the Reports Controller
```

Install CarrierWave
```ruby
gem 'carrierwave'
```
```shell
rails generate uploader Image

rails g migration add_image_to_receipts image:string

rake db:migrate
```

```ruby
Receipt.rb
  mount_uploader :image, ImageUploader



















