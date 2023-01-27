STATUS="/sys/class/power_supply/battery/status"
CAPACITY="/sys/class/power_supply/battery/capacity"
CHARGING_ENABLED="/sys/class/power_supply/battery/charging_enabled"


(
  while :; do
    status="$(cat "$STATUS")"
    capacity="$(cat "$CAPACITY")"
    if [ "$status" = "Charging" ]; then
      if [ "$capacity" -gt "80" ]; then
        echo "0" > "$CHARGING_ENABLED"
      fi
    elif [ "$status" = "Discharging" ]; then
      if [ "$capacity" -lt "75" ]; then
        echo "1" > "$CHARGING_ENABLED"
      fi
    fi
    sleep 3
  done
) &
