


def get_path(filename)
    return File.expand_path("../#{filename}", __FILE__)
end

input_file  = get_path 'processed.txt'
output_file = get_path 'Luke_unstrip.txt'
ruby_saving = get_path 'saving.dat'


# ソースファイルを読込み
lines = []
File.open(input_file, 'r:UTF-8') { |f|
    f.each_line { |l|
        lines.push l
    }
}
puts "File<#{input_file}> を読込みました。#{lines.length}行あります。"

dat = ''
File.open(ruby_saving, 'r:UTF-8') { |f|
    dat = f.read
}
puts "File<#{ruby_saving}> を読込みました。#{dat.length}文字あります。"


# ルビデータをパースしてハッシュ構築
dat_hash = {}
dat.scan(/<idx:(\d+\/\d+),kj:([^,]+),rb:([^>]+)> /) { |matches|
    key, kanji, ruby = matches
    dat_hash[key] = {kj: kanji, rb: ruby}
}


# 主処理
lines.each_index { |ln_idx|
    tmpline = ''
    chr_idx, remain_rubyln = 0, 0
    state = :in_plain

    lines[ln_idx].each_char { |c|

        if state == :in_ruby
            remain_rubyln -= 1

            if remain_rubyln == 0
                tmpline << '》'
                state = :in_plain
            end
        end

        key = "#{ln_idx}/#{chr_idx}"
        if dat_hash.has_key?(key)
            kanji, ruby = dat_hash[key].values_at(:kj, :rb)
            remain_rubyln = ruby.length

            tmpline << "｜#{kanji}《"
            state = :in_ruby
        end

        tmpline << c
        chr_idx += 1
    }

    lines[ln_idx] = tmpline
}


# ルビを復元したテキストを出力
File.open(output_file, 'wb:UTF-8') { |f|
    f.write lines.join
}
puts "File<#{output_file}> を出力しました。"

puts '正常終了！'
