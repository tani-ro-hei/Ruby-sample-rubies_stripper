


input_file = './Luke_orig.txt'
output_file = './Luke_strip.txt'
ruby_saving = './saving.dat'


# ソースファイルを読込み
lines = []
File.open(input_file, 'r:UTF-8') { |f|
    f.each_line { |l|
        lines.push l
    }
}
puts "File<#{input_file}> を読込みました。#{lines.length}行あります。"


# 数値文字参照を解決
cnt = 0
lines.map! { |l|
    l.gsub(/&#x([0-9a-f]+);/i) {
        cnt += 1
        [ $1.to_i(16) ].pack('U*')
    }
}
puts "#{cnt}箇所の数値文字参照を置換しました。"


# 主処理
dat = ''
cnt = 0
lines.each_index { |ln_idx|
    tmpline, kanji, ruby = ['', '', '']
    chr_idx = 0
    state = :in_plain

    lines[ln_idx].each_char { |c|
        if /([｜《》])/ =~ c
            case $1
            when '｜'
                state = :in_kanji
            when '《'
                state = :in_ruby
            when '》'
                dat << "<idx:#{ln_idx}/#{chr_idx},kj:#{kanji},rb:#{ruby}> "
                tmpline << ruby
                chr_idx += ruby.length
                kanji, ruby = ['', '']
                cnt += 1
                state = :in_plain
            end
        else
            case state
            when :in_plain
                tmpline << c
                chr_idx += 1
            when :in_kanji
                kanji << c
            when :in_ruby
                ruby << c
            end
        end
    }

    lines[ln_idx] = tmpline
}
puts "#{cnt}箇所のルビを除去しました。"


# 作成したストリップテキスト及びルビデータを出力
# (Windows でなければ 'w' モードでよい)
File.open(output_file, 'wb:UTF-8') { |f|
    f.write lines.join
}
puts "File<#{output_file}> を出力しました。"

File.open(ruby_saving, 'wb:UTF-8') { |f|
    f.write dat
}
puts "File<#{ruby_saving}> を出力しました。"

puts '正常終了！'
