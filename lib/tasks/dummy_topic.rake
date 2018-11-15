# frozen_string_literal: true

namespace :dummy_topic do
  desc 'Populate topics'
  task populate: :environment do
    next unless is_topic_empty?

    Topic.create name: 'Kejiwaan', note: 'Materi mengenai kejiwaan', validation_date: DateTime.now
    Topic.create name: 'Psikologi', note: 'Materi mengenai psikologi', validation_date: 10.days.ago
    # Topic.create name: 'Dentist', note: 'Materi mengenai gigi', status: true
    # Topic.create name: 'Hormon', note: 'Materi mengenai hormon', status: true
    # Topic.create name: 'Sample Topic 1', note: "#{Faker::Lorem.sentence}", status: true
    # Topic.create name: 'Sample Topic 2', note: "#{Faker::Lorem.sentence}", status: true
  end

  desc 'Populate topics'
  task danger_clean_all: :environment do
    Topic.delete_all
  end

  def is_topic_empty?
    if Topic.count > 0
      Rails.logger.error 'Topic is already exist'
      return false
    end
    true
  end
end

