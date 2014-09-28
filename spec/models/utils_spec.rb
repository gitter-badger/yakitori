require 'rails_helper'

RSpec.describe Utils, :type => :model do
  # context 'SketchPageのエクスポートデータを' do
  #   describe '.unzipすると' do
  #     before do
  #       @dist_path = File.join(Rails.root, 'var', 'test', 'output', 'result').to_s
  #
  #       Utils.unzip(File.join(Rails.root, 'var', 'test', 'input', '新規ページ.sklp').to_s,
  #         @dist_path, UNZIP_PASS)
  #     end
  #     it 'dest直下に解凍される' do
  #       File.exist?(@dist_path).should be true
  #       File.exist?(File.join(@dist_path, 'meta.xml')).should be true
  #       File.exist?(File.join(@dist_path, 'lp.xml')).should be true
  #     end
  #   end
  # end

  context 'WindowsでつくったZipデータ' do
    describe '#zip' do
      it 'zipができる'
    end
  end

  context 'MacでつくったZipデータ' do
    describe '#zip' do
      it 'zipができる'
    end
  end

  context 'すでに存在するディレクトリを' do
    describe '.clean_upすると' do
      before do
        @target_dir = File.join(Rails.root, 'var', 'tmp', 'test', 'dir')
        @file = File.join(@target_dir, 'file.txt')
        FileUtils.mkdir_p(@target_dir)
        FileUtils.touch(@file)
        Utils.clean_up(@target_dir)
      end
      it 'ディレクトリが空になる' do
        File.exist?(@target_dir).should be true
        File.exist?(@file).should be false
      end
    end
  end

  context 'すでに存在するファイルを' do
    describe '.clean_upすると' do
      before do
        @dir = File.join(Rails.root, 'var', 'tmp', 'test', 'dir')
        @target_file = File.join(@dir, 'delete.txt')
        @another_file = File.join(@dir, 'remain.txt')
        FileUtils.mkdir_p(@dir)
        FileUtils.touch(@target_file)
        FileUtils.touch(@another_file)
        Utils.clean_up(@target_file)
      end
      it 'ファイルが削除される' do
        File.exist?(@dir).should be true
        File.exist?(@target_file).should be false
        File.exist?(@another_file).should be true
      end
    end
  end

  context '存在しないディレクトリを' do
    describe '.clean_upすると' do
      before do
        @no_exist_dir = File.join(Rails.root, 'var', 'tmp', 'test', 'dir')
        @target_dir = File.join(@no_exist_dir, 'exist_dir')

        FileUtils.remove_dir(@no_exist_dir)
        Utils.clean_up(@target_dir)
      end
      it '必要なディレクトリがすべて作成される' do
        File.exist?(@no_exist_dir).should be true
        File.exist?(@target_dir).should be true
      end
    end
  end

  context '存在しないファイルを' do
    describe '.clean_upすると' do
      before do
        @no_exist_dir = File.join(Rails.root, 'var', 'tmp', 'test', 'dir')
        @target_file = File.join(@no_exist_dir, 'target.txt')

        FileUtils.remove_dir(@no_exist_dir)
        Utils.clean_up(@target_file)
      end
      it '必要なディレクトリがすべて作成される' do
        File.exist?(@no_exist_dir).should be true
        File.exist?(@target_file).should be false
      end
    end
  end

  context '存在しないかつ、トッド(.)が名前に含まれるエントリを' do
    describe '.clean_upすると' do
      before do
        @no_exist_entry = File.join(Rails.root, 'var', 'tmp', 'test', 'dir.dir')

        FileUtils.remove_dir(@no_exist_entry)
        Utils.clean_up(@no_exist_entry)
      end
      it 'ファイルが作られてしまう' do
        pending '仕様未確認' do
          File.exist?(@no_exist_entry).should be true
          File.directory?(@no_exist_entry).should be false
          File.file(@no_exist_entry).should be true
        end
      end
    end
  end

  context '存在しないかつ、トッド(.)が名前に含まれないエントリを' do
    describe '.clean_upすると' do
      before do
        @no_exist_entry = File.join(Rails.root, 'var', 'tmp', 'test', 'file')

        FileUtils.remove_dir(@no_exist_entry)
        Utils.clean_up(@no_exist_entry)
      end
      it 'ディレクトリが作られてしまう' do
        pending '仕様未確認' do
          File.exist?(@no_exist_entry).should be true
          File.directory?(@no_exist_entry).should be true
          File.file(@no_exist_entry).should be false
        end
      end
    end
  end
end
