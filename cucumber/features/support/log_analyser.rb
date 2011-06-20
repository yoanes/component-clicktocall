class LogAnalyser
  attr_reader :log_files
  
  def initialize(log_file_specs)
    @log_files = []
    log_file_specs.each do |spec|
      @log_files.push LogFile.new(spec["server"], spec["log_file_path"])
    end
  end

  def new_deltas(wait_seconds)
    sleep wait_seconds
    result = LogDeltas.new
    @log_files.each do |e|
      new_delta = e.new_delta
      if !new_delta.nil?
        result.push new_delta
      end
    end

    result
  end

  class LogFile
    attr_reader :server, :log_file_path, :num_lines

    def initialize(server, log_file_path)
      @server = server
      @log_file_path = log_file_path 
      @num_lines = count_lines
    end

    def new_delta
      if log_changed?
        log_lines = `tail -#{count_lines - @num_lines} #{@log_file_path}`
        @num_lines = count_lines
        LogDelta.new(@server, @log_file_path, log_lines)
      else 
        nil
      end
    end

    def to_s
      result = "#{self.class}["
      self.instance_variables.sort.each do |v|
        result << "#{v}: #{instance_variable_get(v)}, "
      end
      result.chomp(", ") << "]"
    end

    private 

    def log_changed?
      count_lines != @num_lines
    end

    def count_lines
      `wc -l #{@log_file_path}`.split.first.to_i
    end
  end

  class LogDeltas
    attr_reader :log_deltas

    def initialize
      @log_deltas = []
    end

    def push(delta)
      @log_deltas.push delta
    end

    def has_unique?(log_str)
      found_delta = nil
      @log_deltas.each do |d|
        if (d.has_unique?(log_str)) 
          if (found_delta == nil)
            found_delta = d;
          else
            raise "Found log string in #{found_delta} and #{d} when expected unique."
          end
        end
      end

      if (!found_delta.nil?)
        true
      else
        false
      end
    end

    def to_s
      result = "#{self.class}["
      self.instance_variables.sort.each do |v|
        result << "#{v}: #{instance_variable_get(v)}, "
      end
      result.chomp(", ") << "]"
    end

  end

  class LogDelta
    attr_reader :server, :log_file_path, :lines

    def initialize(server, log_file_path, lines)
      @server = server;
      @log_file_path = log_file_path
      @lines = lines
    end

    def has_unique?(log_str)
      match_found = false
      lines.lines do |curr_line|  
        if (!curr_line.scan(log_str).empty?)
          if (!match_found)
            match_found = true
          else
            raise "Found log string twice in #{self}."
          end
        end
      end

      match_found
    end
    
    def to_s
      result = "#{self.class}["
      self.instance_variables.sort.each do |v|
        result << "#{v}: #{instance_variable_get(v)}, "
      end
      result.chomp(", ") << "]"
    end
  end
end
