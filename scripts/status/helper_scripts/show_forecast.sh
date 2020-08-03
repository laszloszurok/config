#!/bin/bash

[ ! -d "$HOME/.cache/weather" ] && mkdir $HOME/.cache/weather

getforecast() { curl -sf "wttr.in" > "$HOME/.cache/weather/weatherinfo" || exit 1 ;}

getforecast

less -Srf "$HOME/.cache/weather/weatherinfo"
