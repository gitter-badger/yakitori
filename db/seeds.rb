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

SaleCategory.create(:name => '画像テンプレート', :label => 'B', :last_id => 'B00162')
SaleCategory.create(:name => 'ページテンプレート', :label => 'P', :last_id => 'P00052')
SaleCategory.create(:name => 'お店テンプレート', :label => 'S', :last_id => 'S00011')
SaleCategory.create(:name => 'お買い得セット', :label => 'SET', :last_id => 'SET00013')
SaleCategory.create(:name => '広告画像セット', :label => 'ADSET', :last_id => 'ADSET00003')

Genre.create(:id_label => 1, :name => 'ページ', :pay_label => '1020', :free_label => 'F10034', :extension => '.sklp')
Genre.create(:id_label => 2, :name => 'バナー', :pay_label => '204y', :free_label => 'F20088', :extension => '.skbn')
Genre.create(:id_label => 2, :name => '看板', :pay_label => '300b', :free_label => 'F30013', :extension => '.zip')
Genre.create(:id_label => 2, :name => 'お店', :pay_label => '400b', :free_label => 'F40000', :extension => '.zip')
Genre.create(:id_label => 2, :name => 'スマホトップ', :pay_label => '500b', :free_label => 'F50013', :extension => '.zip')