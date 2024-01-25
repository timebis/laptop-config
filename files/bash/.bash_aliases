alias la='ls -laF'
alias c="clear"
alias hem-log='ssh thomas-server-rasp "clear; sudo journalctl -fu hem"'
alias hem-vpn='sudo wg-quick up wg0'
alias hem-grafana-nfl='ssh -NfL 12000:localhost:3000 thomas-server-rasp'
alias commit='f() { git add .; git commit -m "$1"; }; f'
alias gwip='git add -A && git rm $(git ls-files --deleted) 2> /dev/null && git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "--wip--" && git reset HEAD~1'

