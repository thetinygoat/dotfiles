function port
    set -l port_num $argv[1]

    if test -z "$port_num"
        echo "Error: No port number provided."
        echo "Usage: port <port_number>"
        return 1
    end

    # Capture lsof output as a list
    set -l output (lsof -i TCP:"$port_num" -sTCP:LISTEN -P)

    # Check if the output list is not empty
    if test -n "$output"
        echo "Process using port $port_num:"
        # Use `string join` with a newline `\n` to print each item
        # from the output list on its own line. This is the fix.
        string join \n $output
    else
        echo "No process found listening on port $port_num."
        return 1
    end
end
