# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Price.create(:value => 30000)
Price.create(:value => 10000)
Price.create(:value => 3000)
Price.create(:value => 1500)

SaleCategory.create(:name => '画像テンプレート', :label => 'B')
SaleCategory.create(:name => 'ページテンプレート', :label => 'P')
SaleCategory.create(:name => 'お店テンプレート', :label => 'S')
SaleCategory.create(:name => 'お買い得セット', :label => 'SET')
SaleCategory.create(:name => '広告画像セット', :label => 'ADSET')

Genre.create(:id_label => 1, :name => 'ページ', :pay_label => '1000', :free_label => 'F10000', :extension => '.sklp')
Genre.create(:id_label => 2, :name => 'バナー', :pay_label => '2000', :free_label => 'F20000', :extension => '.skbn')