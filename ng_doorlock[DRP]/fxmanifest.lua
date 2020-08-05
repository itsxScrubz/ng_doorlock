fx_version 'adamant'
games { 'rdr3', 'gta5' }

shared_script "core/shared.lua"
shared_script "@drp_core/managers/networkcallbacks.lua"

client_scripts {
	'_configs/*.lua',
	'core/client/*.lua'
}

server_scripts {
	'_configs/*.lua',
	'core/server/*.lua'
}
