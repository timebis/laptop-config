# some more ls aliases
alias la='ls -laF'
alias c="clear"
alias hem-log='ssh thomas-server-rasp "clear; sudo journalctl -fu hem"'
alias hem-vpn='sudo wg-quick up wg0'
alias hem-grafana-nfl='ssh -NfL 12000:localhost:3000 thomas-server-rasp'
alias commit='f() { git add .; git commit -m "$1"; }; f'
