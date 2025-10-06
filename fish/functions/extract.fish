function extract
    if test (count $argv) -eq 0
        echo "Usage: extract [file.tar.gz | file.tgz | file.zip | file.tar.bz2]"
        return 1
    end

    switch $argv[1]
        case '*.tar.gz' '*.tgz'
            tar -xzf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.tar.bz2'
            tar -xjf $argv[1]
    end
end
