# irb
# require './checking'
# u = Check.new.remote_file_exists?(path)

class Check
  def remote_file_exists?(path)
    results = []
    
    system("if [ -e '#{path}' ]; then echo -n 'trueee'; fi") do |ch, stream, out|
      results << (out == 'true')
    end
  
    results
  end
end