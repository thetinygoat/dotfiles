function llmc --description "Combine files with annotations for LLM input"
    # Check if any arguments provided
    if test (count $argv) -eq 0
        echo "Usage: llmc file1 [file2 ...] [dir] [pattern]"
        echo "Examples:"
        echo "  llmc file.txt           # Single file"
        echo "  llmc *.py              # All Python files (glob)"
        echo "  llmc src/              # All files in src directory"
        echo "  llmc file.txt *.rs dir/ # Mix of files, globs, and directories"
        echo ""
        echo "Combines files with annotations and copies to clipboard"
        return 1
    end

    # Variable to store combined output
    set -l output ""
    set -l file_count 0
    set -l processed_files

    for arg in $argv
        if test -d $arg
            # It's a directory - process all files in it (non-recursive)
            for file in $arg/*
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

                    set file_count (math $file_count + 1)
                    set -a processed_files $file
                end
            end
        else if test -f $arg
            # It's a regular file
            # Add file header
            set -a output "=== File: $arg ==="
            set -a output ""

            # Add file content
            set -a output (cat $arg)
            set -a output ""
            set -a output "=== End of $arg ==="
            set -a output ""
            set -a output ""

            set file_count (math $file_count + 1)
            set -a processed_files $arg
        else
            # Not a file or directory - might be a glob pattern that didn't match
            echo "Warning: $arg not found or no matching files" >&2
        end
    end

    # Copy to clipboard
    if test $file_count -gt 0
        printf "%s\n" $output | pbcopy
        echo "✓ Copied $file_count file(s) to clipboard"

        # List processed files (limit output if too many)
        if test $file_count -le 20
            for file in $processed_files
                echo "  • $file"
            end
        else
            # Show first 10 and last 5 files if more than 20
            for i in (seq 1 10)
                echo "  • $processed_files[$i]"
            end
            echo "  ... ("(math $file_count - 15)" more files)"
            for i in (seq (math $file_count - 4) $file_count)
                echo "  • $processed_files[$i]"
            end
        end
    else
        echo "Error: No valid files to copy" >&2
        return 1
    end
end
