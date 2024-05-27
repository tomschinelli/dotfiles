#! /bin/bash
workspaces() {

  # Get occupied workspaces and remove workspace -99 aka scratchpad if it exists
  # a="$(hyprctl workspaces | grep ID | awk '{print $3}')"
  # a="$(echo "${a//-99/}" | sed '/^[[:space:]]*$/d')"
  ows="$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id')"
  for num in $ows; do
	  export o"$num"="$num"
  done

  arg="$1"
  # Get Focused workspace for current monitor ID

  out="(box :class \"screens\" :orientation \"h\" :space-evenly \"false\" :spacing 20 "
  screens="$(hyprctl monitors -j | jq  '.[].id')"
  active_screen="$(hyprctl activeworkspace -j | jq '.monitorID')"
  for screen in $screens; do
	    active_ws="$(hyprctl monitors -j | jq --argjson arg "$screen" '.[] | select(.id == $arg).activeWorkspace.id')"

      workspaces="$(hyprctl workspaces -j | jq --argjson monitor "$screen" '.[] | select(.monitorID == $monitor).id')"
 
      out="$out (box :class \"workspaces\" :orientation \"h\" :space-evenly \"false\"  "

      # monitor label
      screen_bonus_class="$( if [[ "$screen" == "$active_screen" ]]; then echo "active"; else echo "" ; fi ) " 
      out="$out (box :class \"screen_label $screen_bonus_class\" \"󰍹\" )"

      for ws in $workspaces; do
        ws_bonus_class="$( if [[ "$ws" == "$active_ws" ]]; then echo "active"; else echo "" ; fi ) " 
        out="$out (box :class \"workspace_label $ws_bonus_class\" \"$ws\" )"
      done

      out="$out )"


  done

  out="$out )"
  echo $out
}

workspaces 
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r; do 
  workspaces
done