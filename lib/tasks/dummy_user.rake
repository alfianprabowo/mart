# frozen_string_literal: true

namespace :dummy_user do
  desc 'Initialize user superadmin'
  task :init_superadmin, [:password] => :environment do |task, args|
    next if is_password_blank? args

    admin = User.find_by email: 'superadmin@wellcode.io'
    if admin.present?
      Rails.logger.info 'User superadmin is already initialized. Exit'
      next
    end

    superadmin = User.new(
      email: 'superadmin@wellcode.io',
      name: 'Super Admin (generated user)',
      password: args.password,
      level: User::SUPER_ADMIN,
      nik: Faker::IDNumber.valid
    )
    superadmin.save!
    Rails.logger.info "Success create superadmin user: id #{superadmin.id}"
  end

  desc 'Initialize user admin'
  task :init_admin, [:password] => :environment do |task, args|
    next if is_password_blank? args

    admin = User.find_by email: 'admin@wellcode.io'
    if admin.present?
      Rails.logger.info 'User admin is already initialized. Exit'
      next
    end

    admin = User.new(
      email: 'admin@wellcode.io',
      name: 'Admin (generated user)',
      password: args.password,
      level: User::ADMIN,
      nik: Faker::IDNumber.valid
    )
    admin.save!
    Rails.logger.info "Success create admin user: id #{admin.id}"
  end

  desc 'Initialize user creator'
  task :init_creator, [:password] => :environment do |task, args|
    next if is_password_blank? args

    creator = User.find_by email: 'creator@wellcode.io'
    if creator.present?
      Rails.logger.info 'User creator is already initialized. Exit'
      next
    end

    creator = User.new(
      email: 'creator@wellcode.io',
      name: 'Creator (generated user)',
      password: args.password,
      level: User::CREATOR,
      nik: Faker::IDNumber.valid
    )
    creator.save!
    Rails.logger.info "Success create creator user: id #{creator.id}"
  end

  desc 'Initialize user validator'
  task :init_validator, [:password] => :environment do |task, args|
    next if is_password_blank? args

    validator = User.find_by email: 'validator@wellcode.io'
    if validator.present?
      Rails.logger.info 'User validator is already initialized. Exit'
      next
    end

    validator = User.new(
      email: 'validator@wellcode.io',
      name: 'Validator (generated user)',
      password: args.password,
      level: User::VALIDATOR,
      nik: Faker::IDNumber.valid
    )
    validator.save!
    Rails.logger.info "Success create validator user: id #{validator.id}"
  end

  desc 'Initialize user instructor'
  task :init_instructor, [:password] => :environment do |task, args|
    next if is_password_blank? args

    instructor = User.find_by email: 'instructor@wellcode.io'
    if instructor.present?
      Rails.logger.info 'User instructor is already initialized. Exit'
      next
    end

    instructor = User.new(
      email: 'instructor@wellcode.io',
      name: 'Instructor (generated user)',
      password: args.password,
      level: User::INSTRUCTOR,
      nik: Faker::IDNumber.valid
    )
    instructor.save!
    Rails.logger.info "Success create instructor user: id #{instructor.id}"
  end

  desc 'Initialize user institution'
  task :init_institution, [:password] => :environment do |task, args|
    next if is_password_blank? args

    institution = User.find_by email: 'institution@wellcode.io'
    if institution.present?
      Rails.logger.info 'User institution is already initialized. Exit'
      next
    end

    institution = User.new(
      email: 'institution@wellcode.io',
      name: 'Institution (generated user)',
      password: args.password,
      level: User::INSTITUTION,
      nik: Faker::IDNumber.valid
    )
    institution.save!
    Rails.logger.info "Success create institution user: id #{institution.id}"
  end

  desc 'Init example participant from CSV in fixtures'
  task :init_csv, [:password] => :environment do |task, args|
    next if is_password_blank? args

    user_1 = User.find_by nik: '2013730068'
    if user_1.present?
      Rails.logger.info 'User user1 is already initialized. Exit'
      next
    end

    nik = 2013730001
    60.times do
      user = User.new(
        email: Faker::Internet.email,
        nik: nik,
        name: 'User'+ Faker::FunnyName.name + ' (generated user)',
        password: args.password,
        level: User::PARTICIPANT,
      )
      user.save!
      nik += 1
      Rails.logger.info "Success create user user: id #{user.id}"
    end
  end

  def is_password_blank? args
    if args.password.blank?
      Rails.logger.info 'Argument password couldn\'t be blank. Exit'
      return true
    end
    false
  end
end
