require 'sqlite3'

$db = SQLite3::Database.new "sticky.sqlite"
$db.execute "CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY, title TEXT, msg TEXT)"
$db.results_as_hash = TRUE

def create
	print "\r\nTitle: "
	title = $stdin.gets.chomp
	print "\r\nNote: "
	note = $stdin.gets.chomp

	$db.execute "INSERT INTO notes VALUES (null, '#{title}', '#{note}')"
end

def interpreter (command)
	case command
		when "new"
			create()
		when "exit"
			exit
	end
end

if ARGV.length > 0
	interpreter (ARGV[0])
else
	$db.execute "SELECT * FROM notes" do |row|
		print "\r\n  [#{row['id']}] #{row['title']}\r\n   #{row['msg']}\r\n"
	end
end

$db.close if $db
