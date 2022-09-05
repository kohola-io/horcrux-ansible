# OPTIONAL: modify this command to a command that copies priv_validator_state.json to the same directory as the ansible playbook
# rsync -v --rsync-path="sudo rsync" <user with sudo access to rsync>@<current validator>:<chain directory>/data/priv_validator_state.json priv_validator_state.json
#
# this command can be done manually - but priv_validator_state.json to needs to be copied to ansible control master after the current validator has been stopped
# this script requires that jq is installed on the ansible control master

height=$(cat priv_validator_state.json | jq .height | tr -d \")
round=$(cat priv_validator_state.json | jq .round | tr -d \")
step=$(cat priv_validator_state.json | jq .step | tr -d \")

ansible-playbook -i inventory.yml horcrux_state.yml -e "block_height=$height block_round=$round block_step=$step" -K --diff