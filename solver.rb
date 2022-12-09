require 'set'

def open_file(file_name)
  table = { alphabet: [], states: [], transfers: {}, finish: [], start: [] }
  lines = File.readlines(file_name)

  table[:alphabet] = lines[0].strip.split /\s+/
  lines = lines.drop 1

  transfers = Set.new []

  lines.each do |line|
    #line.gsub!(/\s+/, '')
    cur_line = line.strip.split(/\s+/)
    instance = cur_line[0]
    is_first = false
    if instance[0, 2] == '->'
      is_first = true
      instance.delete! '->'
      throw 'many start symbols' unless table[:start].empty?
    end

    table[:finish] << instance.gsub!(/[()]*/, '') if (instance.match /\(.+\)/)

    table[:start] << instance if is_first
    cur_line = cur_line.drop 1
    throw 'many instances with same name %s' % instance if table[:states].include? instance
    throw "transfers count doesnt equal alphabet size in line '%s'" % line.strip if cur_line.size != table[:alphabet].size
    table[:transfers][instance] = cur_line
    table[:states] << instance
    transfers += cur_line
  end

  transfers -= table[:states]
  transfers -= ['-']

  throw 'found transfer to undetermined state' unless transfers.empty?


  throw 'no start symbol' if table[:start].empty?
  table
end

def compare_automates a_automate, b_automate
  a_alp = a_automate[:alphabet].clone
  b_alp = b_automate[:alphabet].clone

  a_alp.each do |a_el|
    return false unless b_alp.include? a_el

    b_alp -= [a_el]
  end
  return false unless b_alp.empty?

  q = []
  used = []
  q.push [a_automate[:start][0], b_automate[:start][0]]
  until q.empty?
    pair = q.shift

    if pair[0] == '-' || pair[1] == '-'
      next if pair[0] == pair[1]

      return false
    end

    return false unless (a_automate[:finish].include? pair[0]) == (b_automate[:finish].include? pair[1])

    used << pair
    a_automate[:alphabet].each_with_index do |sumbol, i|
      unless used.include? [a_automate[:transfers][pair[0]][i], b_automate[:transfers][pair[1]][i]]
        q.push [a_automate[:transfers][pair[0]][i], b_automate[:transfers][pair[1]][i]]
      end
    end
  end
  true
end

a = open_file 'a.txt'
b = open_file 'b.txt'

pp compare_automates a, b