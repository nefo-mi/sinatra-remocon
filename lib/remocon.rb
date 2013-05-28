# -*- coding: utf-8 -*-
require 'serialport'
require 'yaml'

class Remocon
  def initialize( port, baudrate, databit, stopbit, paritycheck )
    #環境にあわせて指定する。
    @sp = SerialPort.new(port, baudrate, databit, stopbit, paritycheck)
    @sp.read_timeout = 1000

    #ファイルから読み込む
    signal_path = File.expand_path(File.dirname(__FILE__) + '/signal.yml')
    @signal  = YAML.load_file(signal_path)

    #COMPORT接続後数秒はコマンドを受け付けないからsleepする
    puts 'initialize serialport...'
    sleep 3
  end

  # 学習したリモコンのパターンを送信する。
  def send_signal key
    if @signal.key? key
      serial_write adjust(@signal[key])
    else
      false
    end
  end

  # リモコンのパターンを取得する。
  def signals
    @signal.keys
  end

  private 
  # 信号の補正(ボード2,3,4,5用)
  def adjust(a)
    for n in 0..a.length-1
      if (n & 1) == 0
        a[n] -= 4
      else
        a[n] += 4
      end
    end
    a
  end

  def serial_write operation
    command = "WTBL " + operation.join(' ') + " 0"

    # 念のためコンソールへ出力
    #puts command

    # テーブル書込
    @sp.puts command

    # 赤外LEDから送信する
    @sp.puts "IRTX"

    true
  end
end
