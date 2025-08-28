function llmc --description "Combine files with annotations for LLM input"
    # Check if any arguments provided
    if test (count $argv) -eq 0
        echo "Usage: llmc file1 [file2 ...]"
        echo "Combines files with annotations and copies to clipboard"
        return 1
    end

    # Variable to store combined output
    set -l output ""

    # Process each file
    for file in $argv
        if test -f $file
            # Add file header
            set -a output "=== File: $file ==="
            set -a output ""

            # Add file content
            set -a output (cat $file)
            set -a output ""
            set -a output "=== End of $file ==="
            set -a output ""
            set -a output ""
        else
            echo "Warning: $file not found or not a regular file" >&2
        end
    end

    # Copy to clipboard
    if test -n "$output"
        printf "%s\n" $output | pbcopy
        echo "✓ Copied" (count $argv) "file(s) to clipboard"

        # List processed files
        for file in $argv
            if test -f $file
                echo "  • $file"
            end
        end
    else
        echo "Error: No valid files to copy" >&2
        return 1
    end
end
