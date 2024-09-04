if (gcm lsd -ea SilentlyContinue) {
	Set-Alias ls lsd
}

function ll {
    ls --long $args
}

function la {
    ls --all $args
}

