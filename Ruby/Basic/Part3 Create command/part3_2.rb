# Session 2 文件的读取

def simple_grep(parrten, filename)
  file = File.open(filename)
  file.each do |line|
    if parrten =~ line
      print line
    end
  end
  file.close
end