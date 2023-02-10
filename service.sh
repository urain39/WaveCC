STATUS="/sys/class/power_supply/battery/status"
CAPACITY="/sys/class/power_supply/battery/capacity"
CHARGING_ENABLED="/sys/class/power_supply/battery/charging_enabled"


(
  while :; do
    status="$(cat "$STATUS")"
    capacity="$(cat "$CAPACITY")"
    if [ "$status" = "Charging" ] \
      || [ "$status" = "Full" ]; then
      if [ "$capacity" -ge "60" ]; then
        echo "0" > "$CHARGING_ENABLED"
      fi
    elif [ "$status" = "Discharging" ]; then
      if [ "$capacity" -le "55" ]; then
        echo "1" > "$CHARGING_ENABLED"
      fi
    fi
    sleep 15
  done
) &
