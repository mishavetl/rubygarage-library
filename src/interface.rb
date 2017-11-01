# Interface to the library application

require __dir__ + '/cmd_argument_error.rb'

class Interface
  def initialize(controller)
    @controller = controller
  end

  def run(prog_name, argv)
    @dev = false
    if (argv[0] == '-d')
      @dev = true
      argv.shift
    end

    begin
      signals = []
      read_env_signals = []
      write_env_signals = []

      while (argv.length > 0)
        if (args[argv[0].to_sym] == nil)
          raise CmdArgumentError, "invalid arguments: " + argv.join(" ")
        end

        operation = argv[0]
        needed_args_length = args[operation.to_sym].length
        if needed_args_length > argv.length - 1
          raise CmdArgumentError, "not enough arguments"
        end

        argv.shift

        signal_ar = [[map[operation.to_sym], argv.take(needed_args_length)]]
        if read_env_operations.include? operation
          read_env_signals += signal_ar
        elsif write_env_operations.include? operation
          write_env_signals += signal_ar
        else
          signals += signal_ar
        end

        argv.shift needed_args_length
      end
      signals = read_env_signals + signals + write_env_signals
      if (signals.length == 0)
        raise CmdArgumentError, "not enough arguments"
      end
      signals.collect { |signal| send(signal[0], signal[1]).to_s }.join("\n")
    rescue CmdArgumentError => e
      puts "err: " + e.message
      puts help(prog_name)
      if @dev
        raise e
      end
    end
  end

  private
  def help(prog_name)
    "help: \n" + prog_name + " [" \
    + map.keys.collect { |key| ([key.to_s] + args[key]).join(" ")} \
        .join("]\n\t[") + "]"
  end

  def method_missing(method_name, args)
    if @dev
      puts method_name.to_s + " " + args.inspect
    end
    "[" + @controller.send(method_name, *args).join("\n") + "]" \
      + (@dev ? " <= " + method_name.to_s + " " + args.inspect : "")
  end

  def map
    {"--who-takes-the-book": :who_takes_the_book,
     "--what-is-the-most-popular-book": :what_is_the_most_popular_book,
     "--most-popular": :what_is_the_most_popular_book,
     "--who-takes": :who_takes_the_book,
     "--ordered-one-of-three-most-popular":
       :how_many_ordered_one_of_three_most_popular_books,
     "--1-of-3-popular":
       :how_many_ordered_one_of_three_most_popular_books,
     "--save": :save_to_file,
     "--import": :import_from_file}
  end

  def args
    {"--who-takes-the-book": ["book_name"],
     "--what-is-the-most-popular-book": [],
     "--most-popular": [],
     "--who-takes": ["book_name"],
     "--ordered-one-of-three-most-popular": [],
     "--1-of-3-popular": [],
     "--save": ["file_name"],
     "--import": ["file_name"]}
  end

  def read_env_operations
    ["--import"]
  end

  def write_env_operations
    ["--save"]
  end
end
