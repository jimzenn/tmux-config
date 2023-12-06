 # exit the script if any statement returns a non-true return value
 set -e

 unset GREP_OPTIONS
 export LC_NUMERIC=C

 _decode_unicode_escapes() {
   printf '%s' "$*" | perl -CS -pe 's/(\\u([0-9A-Fa-f]{1,4})|\\U([0-9A-Fa-f]{1,8}))/chr(hex($2.$3))/eg' 2>/dev/null
 }


 _process_status() {
   echo "$1" | awk \
     -v fg_="$2" \
     -v bg_="$3" \
     -v attr_="$4" \
     -v mainsep="$5" \
     -v subsep="$6" \
     '
      function update_open_counts(str)
      {
        split(str, _, "[(){}\\[\\]]")
        for (k = 1; k <= length(_); ++k)
        {
          if (_[k] == "(" || _[k] == "{" || _[k] == "[") open++
          if (_[k] == ")" || _[k] == "}" || _[k] == "]") open--
        }
      }
      function subsplit(s, l, i, a, r)
      {
        l = split(s, a, ",")
        for (i = 1; i <= l; ++i)
        {
          update_open_counts(a[i])

          if (i == l)
            r = r a[i]
          else if (open > 0)
            r = r a[i] ","
          else
            r = r a[i] "#[fg=" fg[j] ",bg=" bg[j] "," attr[j] "]" subsep
        }
        gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg[j], bg[j], attr[j]), r)
        return r
      }
        BEGIN {
          FS = "|"
          l1 = split(fg_, fg, ",")
          l2 = split(bg_, bg, ",")
          l3 = split(attr_, attr, ",")
          l = l1 < l2 ? (l1 < l3 ? l1 : l3) : (l2 < l3 ? l2 : l3)
        }
        {
          for (i = j = 1; i <= NF; ++i)
          {
            if (open || open_ || open__)
              printf "|%s", subsplit($i)
            else
            {
              if (i > 1)
                printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg[j_], bg[j], mainsep, fg[j], bg[j], attr[j], subsplit($i)
              else
                printf "#[fg=%s,bg=%s,%s]%s", fg[j], bg[j], attr[j], subsplit($i)
            }
            if (!open && !open_ && !open__)
            {
              j_ = j
              j = j % l + 1
            }
          }
          printf "#[fg=%s,bg=%s,none]%s", bg[j_], "default", mainsep
        }
        '
 }

if [ -n "$tmux_conf_theme_status_left" ]; then
 status_left=$(_process_status \
   "$tmux_conf_theme_status_left" \
   "$tmux_conf_theme_status_left_fg" \
   "$tmux_conf_theme_status_left_bg" \
   "$tmux_conf_theme_status_left_attr" \
   "$tmux_conf_theme_left_separator_main" \
   "$tmux_conf_theme_left_separator_sub")
fi
if [ -n "$tmux_conf_theme_status_right" ]; then
 status_right=$(_process_status \
   "$tmux_conf_theme_status_right" \
   "$tmux_conf_theme_status_right_fg" \
   "$tmux_conf_theme_status_right_bg" \
   "$tmux_conf_theme_status_right_attr" \
   "$tmux_conf_theme_right_separator_main" \
   "$tmux_conf_theme_right_separator_sub")
fi
tmux set -g status-left "$(_decode_unicode_escapes "$status_left")" \; set -g status-right "$(_decode_unicode_escapes "$status_right")"

# for name in $(printenv | grep -E -o '^tmux_conf_[^=]+'); do tmux setenv -gu "$name"; done

"$@"
