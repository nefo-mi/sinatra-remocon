# -*- coding: utf-8 -*-
require 'serialport'

class Remocon
  def initialize( port, baudrate, databit, stopbit, paritycheck )
    #環境にあわせて指定する。
    @sp = SerialPort.new(port, baudrate, databit, stopbit, paritycheck)
    @sp.read_timeout = 1000

    #COMPORT接続後数秒はコマンドを受け付けないからsleepする
    puts 'initialize serialport...'
    sleep 3
  end

  # 電源オンオフ
  def turnon
    turnon = adjust([900,222,60,48602,900,447,60,53,60,53,60,53,60,53,60,53,60,53,60,164,60,53,60,164,60,165,60,164,60,164,60,164,60,164,60,53,60,164,60,53,60,164,60,53,60,53,60,165,60,53,60,53,60,53,60,164,60,52,60,164,60,164,60,52,60,164,60,165,60,165,60,3972,899,222,60,1000])
    serial_write turnon
  end

  # 地デジ
  def chdeji
    deji = adjust([903,444,62,50,62,50,62,51,62,51,60,52,62,51,60,165,62,50,63,162,60,164,60,164,60,164,62,162,62,162,59,54,62,162,60,53,60,164,60,52,62,162,60,164,62,162,62,162,60,53,62,162,60,53,60,164,60,53,60,53,62,50,60,52,62,162,60,3979,899,222,62,3298,900,446,63,50,62,50,60,53,60,53,60,53,60,53,60,165,62,50,60,164,60,164,60,164,60,164,60,164,60,165,59,54,62,162,60,53,60,164,60,52,60,164,60,164,60,164,60,164,62,51,62,162,60,52,60,164,62,50,60,53,60,53,60,52,63,162,62,3976,900,222,62,1000])
    serial_write deji
  end

  # BS
  def chbs
    bs = adjust([903,444,60,52,62,50,62,50,62,50,60,53,60,52,60,164,60,53,62,162,60,164,63,162,60,164,62,162,60,164,60,53,60,164,60,53,62,50,60,164,60,165,60,165,60,164,60,164,60,53,60,164,60,164,60,52,60,53,60,53,60,53,62,50,60,164,60,3973,900,222,60,1000])
    serial_write adjust
  end

  # 消音
  def mute
    mute = adjust([902,444,60,53,60,53,60,52,63,50,60,53,62,50,60,164,62,50,60,164,60,164,60,164,60,164,60,164,60,164,62,50,60,164,60,53,60,53,60,52,63,50,60,164,60,52,62,51,60,53,62,162,60,164,60,164,60,164,62,51,60,164,60,164,60,164,62,3967,900,222,62,1000])
    serial_write mute
  end

  # 入力切替
  def chinput
    sw = adjust([900,446,60,53,60,54,59,53,60,53,60,53,60,53,62,162,62,51,60,165,60,165,60,164,60,164,60,164,60,164,60,53,62,162,62,162,62,162,60,165,62,162,60,52,60,53,60,53,60,53,62,50,60,53,60,52,62,50,62,162,63,162,60,164,60,165,62,3967,900,222,60,1000])
    serial_write sw
  end

  # チャンネル変更
#  desc 'channel', 'change chnnel to [option]'
#  option :channel, :type => :fixnum, :numeric => '-n', :desc => ''
#  def channel
#    setup
#    channel = { 
#      1 => [900,446,62,50,60,53,60,53,60,53,62,51,62,50,60,165,60,54,59,164,62,162,60,164,60,164,63,162,60,164,60,53,60,164,60,164,62,51,60,52,60,53,62,50,62,50,62,50,60,53,59,53,60,164,60,165,60,165,59,164,60,164,60,164,62,162,60,1000] , 
#      2 => [900,446,62,50,60,52,60,53,62,50,60,52,60,53,60,164,60,52,60,164,60,164,60,164,63,162,60,165,60,164,60,52,62,162,60,53,62,162,60,53,62,50,62,50,60,53,60,53,60,53,62,162,62,50,60,164,60,164,60,164,60,164,60,164,60,164,60,1000] ,
#      3 => [902,444,62,50,60,53,60,53,62,51,60,53,62,51,62,162,59,53,62,162,60,164,60,164,60,164,62,162,60,164,63,50,60,164,60,164,63,162,62,51,60,53,60,53,62,51,60,53,62,50,59,53,62,51,59,165,62,162,62,162,60,164,62,162,60,164,60,1000] ,
#      4 => [900,447,62,50,62,51,60,53,60,53,59,53,62,51,62,162,60,52,60,164,60,164,60,164,62,162,60,164,62,162,60,53,62,162,60,53,62,51,60,165,60,53,59,53,62,51,60,53,62,50,60,165,62,162,60,53,60,164,62,162,62,162,60,164,60,164,62,1000] ,
#      5 => [900,446,60,53,60,53,60,52,62,50,60,53,60,52,60,164,60,53,62,162,60,164,60,164,60,165,60,164,60,164,60,53,62,162,60,164,60,53,60,164,60,52,60,53,62,50,60,53,62,50,62,51,59,164,60,53,60,165,60,164,60,164,60,164,60,164,60,3978,900,222,60,1000],
#      6 =>  [900,447,62,50,60,53,60,53,60,53,60,52,62,50,62,162,60,52,62,162,60,164,60,164,60,164,60,164,60,164,60,53,63,162,60,53,62,162,60,165,62,51,60,52,60,53,62,50,60,52,60,164,62,50,60,52,60,164,60,164,60,164,60,164,60,164,60,1000] ,
#      7 => [900,446,60,53,60,52,63,50,60,53,60,53,62,50,60,164,60,52,60,164,62,162,60,164,60,164,60,164,62,162,60,52,60,164,60,164,60,164,60,164,60,53,60,52,60,52,60,53,62,50,60,53,60,53,60,52,62,162,62,162,60,164,60,164,60,164,60,3973,902,220,62,9582,903,219,60,1000], 
#      8 => [903,444,60,53,60,53,62,50,60,53,60,52,60,53,60,164,62,50,60,164,60,164,62,162,63,162,62,162,60,164,60,52,60,164,60,53,62,50,60,53,60,164,60,53,60,53,60,53,60,52,62,162,62,162,60,164,60,53,62,162,62,162,63,162,60,165,60,1000] ,
#      9 => [901,444,60,53,62,50,60,52,60,53,62,50,60,53,60,164,60,53,62,162,60,164,62,162,60,164,60,164,60,164,60,53,60,164,60,52,60,165,60,53,60,164,60,53,60,53,60,52,60,53,60,164,60,53,62,162,62,51,60,164,60,165,60,164,60,164,60,3975,900,222,60,9586,902,220,62,1000] ,
#     10 => [899,447,62,51,60,53,60,53,60,53,62,50,60,53,60,164,63,50,60,164,60,164,60,164,60,164,60,164,60,164,62,50,63,162,60,53,62,162,60,53,60,164,63,50,60,52,60,53,60,52,60,164,60,53,62,162,60,53,60,164,60,164,60,164,60,164,60,1000] ,
#     11 => [900,446,62,50,60,53,62,50,60,52,60,53,60,53,60,164,62,50,60,164,62,162,62,162,63,162,60,164,62,162,60,53,62,162,63,162,62,162,62,50,62,162,62,51,62,51,60,53,62,51,62,50,60,52,62,162,62,50,60,164,62,162,62,162,62,162,62,1000] ,
#     12 => [902,444,60,52,60,53,60,53,60,52,60,53,60,53,60,164,60,53,60,164,60,164,60,164,60,164,60,164,60,164,63,50,62,162,60,52,60,53,60,164,60,164,60,53,62,50,60,52,60,53,62,162,60,164,61,52,62,50,62,162,60,164,60,164,60,164,62,1000]
#    }
#    serial_write adjust(channel[options[:channel]])
#  end

  # 音量UP
  def volu
    volume_up = adjust([900,446,63,50,62,50,60,52,60,53,60,53,62,50,60,164,60,53,60,164,62,162,62,162,60,164,60,164,60,164,60,53,60,164,60,53,60,164,60,52,60,164,62,162,60,52,63,50,60,53,62,162,63,50,60,164,60,52,60,53,60,164,60,164,60,164,63,1000])
    serial_write volume_up
  end

  # 音量DOWN
  def vold
    volume_down = adjust([900,446,62,50,62,50,62,50,60,53,60,53,62,50,62,162,60,52,62,162,62,162,60,164,63,162,60,164,60,164,60,53,60,164,62,50,60,164,60,164,60,164,60,164,62,50,60,53,60,53,60,164,62,51,62,50,63,50,62,50,63,162,62,162,62,162,62,1000])
    serial_write volume_down
  end
  
  # 青ボタン
  def blue
    blue = adjust([900,446,60,53,60,53,60,53,60,53,60,52,60,52,62,162,62,51,59,164,62,162,63,162,60,164,63,162,60,164,63,50,62,162,60,164,60,164,63,50,60,53,62,162,62,162,62,162,60,53,62,50,60,53,60,164,60,164,60,53,62,50,60,52,63,162,62,3967,900,222,60,9585,900,222,60,1000])
    serial_write blue
  end

  # 赤ボタン
  def red
    red = adjust([900,446,60,52,60,52,61,52,60,52,60,52,60,52,60,164,60,52,60,164,60,164,60,164,60,164,60,164,60,164,60,52,60,164,60,52,60,52,60,164,60,53,60,164,60,164,60,164,60,53,60,164,60,164,60,52,61,164,60,52,60,52,60,52,60,164,60,3973,900,222,60,9584,900,222,60,1000])
    serial_write red
  end

  # 緑ボタン
  def green
    green = adjust([900,446,60,53,60,52,60,53,60,53,60,52,60,53,60,164,60,52,62,162,60,164,60,164,60,164,60,164,60,164,60,52,60,164,60,164,60,53,60,164,60,52,60,164,61,164,60,164,60,52,60,52,60,164,60,53,60,164,60,53,60,53,60,52,60,164,60,3976,900,222,60,1000])
    serial_write green
  end

  # 黄色ボタン
  def yellow
    yellow = adjust([903,443,63,50,60,52,63,50,62,50,62,50,63,50,60,164,60,52,62,162,62,162,62,162,63,162,62,162,62,162,63,50,60,164,62,51,62,162,62,162,62,50,62,162,60,164,62,162,62,50,60,164,60,53,60,52,63,161,60,53,62,50,60,53,62,162,62,3966,903,219,60,9585,902,220,60,1000])
    serial_write yellow
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
  end
end
