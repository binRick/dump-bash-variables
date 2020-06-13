#!/bin/bash
set -e
INCLUDE_VAR_NAMES=${INCLUDE_VAR_NAMES:-0}
source test_vars.sh

get_letters(){
    for x in {a..z}; do  echo $x; echo ${x^}; done
}

generate_dump_letter_commands(){
    while read -r l; do echo -ne "${l} " && echo -e "echo -e \"\${!$l@}\""; done
}

process_letter_commands(){
    while read -r letter letter_cmd; do
        local var_names="$(eval $letter_cmd)"
        echo -e "$letter \"$var_names\""
    done
}

process_var_names(){
    while read -r letter var_names; do
        local extra=
        local qty=$(echo -e ${var_names}|tr ' ' '\n'|wc -l)
        [[ "$INCLUDE_VAR_NAMES" == "1" ]] && extra="$extra vars=$var_names"
        local jo_cmd="jo letter=$letter qty=$qty $extra"
        eval $jo_cmd
    done
}

main(){
    get_letters \
      | generate_dump_letter_commands \
      | process_letter_commands \
      | process_var_names
}


main
