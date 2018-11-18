require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    store: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    level: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    encrypted_password: Field::String,
    confirmation_token: Field::String,
    remember_token: Field::String,
    phone: Field::Number,
    address: Field::String,
    id_card: Field::Number,
    sex: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :store,
    :id,
    :name,
    :email,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :store,
    :id,
    :name,
    :email,
    :level,
    :created_at,
    :updated_at,
    :encrypted_password,
    :confirmation_token,
    :remember_token,
    :phone,
    :address,
    :id_card,
    :sex,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :store,
    :name,
    :email,
    :level,
    :encrypted_password,
    :confirmation_token,
    :remember_token,
    :phone,
    :address,
    :id_card,
    :sex,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
