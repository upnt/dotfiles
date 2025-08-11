#!/bin/bash

echo "Installing julia"

# julia
export JULIAUP_ROOT="$HOME/.juliaup"
if [ ! -d "$JULIAUP_ROOT" ]; then
	curl -fsSL https://install.julialang.org | sh -s -- -y
fi
