fish_add_path /opt/homebrew/bin /opt/homebrew/opt/openjdk/bin ~/.local/bin

set -gx EDITOR nano
set -gx PATH ~/tools/kafka/bin $PATH


set config_dir (dirname (status --current-filename))
set secrets_path "$config_dir/secrets.fish"

if test -e $secrets_path
    source $secrets_path
end
