# #!/bin/bash
# expenses
# for i in {12..0}; do
#     month_window=12
#     end_date=$(date -d "$(date +%Y/%m/01) - $i month - 1 day" "+%Y/%m/%d")
#     start_date=$(date -d "$end_date - $month_window month + 1 day" "+%Y/%m/%d")
#     ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal ^expenses and not %oneoff | xargs"
#     readarray -td' ' total <<< "$(eval "$ledger_command")"
#     average_monthly=$(awk -v total="${total[1]}" -v window="$month_window" 'BEGIN {print (total/window)}')
#     printf "Avg monthly from %s to %s: %'.2f \-\n" "$start_date" "$end_date" "$average_monthly"
# done
#
## ingestments
# for i in {12..0}; do
#     end_date=$(date -d "$(date +%Y/%m/01) - $i month - 1 day" "+%Y/%m/%d")
#     start_date=$(date -d "$end_date - 12 month + 1 day" "+%Y/%m/%d")
#     ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal income:investment | xargs"
#     readarray -td' ' yearly_income <<< "$(eval "$ledger_command")"
#     average_monthly=$(awk '{print ($1/12)}' <<<"${yearly_income[1]}")
#     printf "Avg monthly income from %s to %s: %'.2f \-\n" "$start_date" "$end_date" "$average_monthly"
# done
#
#

# months without salary
# end_date=$(date -d "$(date +%Y/%m/01) - 1 day" "+%Y/%m/%d")
# start_date=$(date -d "$end_date - 12 month + 1 day" "+%Y/%m/%d")
# ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal income:investment | xargs"
# readarray -td' ' yearly_income <<< "$(eval "$ledger_command")"
# average_income=$(awk '{print (-1 * $1/12)}' <<<"${yearly_income[1]}")
# echo $average_income
#
# ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal ^expenses and not %oneoff | xargs"
# readarray -td' ' total <<< "$(eval "$ledger_command")"
# average_expenses=$(awk -v total="${total[1]}" -v window="12" 'BEGIN {print (total/window)}')
#
#
# ledger_command="ledger -X Ksh --depth 1 bal assets and \(bank or cash or cic or mpesa or paypal\) | xargs"
# readarray -td' ' total <<< "$(eval "$ledger_command")"
# liquid="${total[1]}"
#
# echo "$liquid $average_income $average_expenses"
#
#
# months_remaining=$(awk -v l="$liquid" -v i="$average_income" -v m="$average_expenses" 'BEGIN {print (l / (m-i))}')
# echo "Months without job: $months_remaining" 
#
#
#

# window for calculations
end_date=$(date -d "$(date +%Y/%m/01) - 1 day" "+%Y/%m/%d")
start_date=$(date -d "$end_date - 12 month + 1 day" "+%Y/%m/%d")

# interest earning assets
# TODO: remove the specifics
ledger_command="ledger -X Ksh --depth 1 bal assets and \(cic or broker or cbk or icea or mutual_fund or imbank\) | xargs"
readarray -td' ' total <<< "$(eval "$ledger_command")"
earners="${total[1]}"

# average monthlu income
ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal income:investment | xargs"
readarray -td' ' yearly_income <<< "$(eval "$ledger_command")"
income=$(awk '{print (-1 * $1)}' <<<"${yearly_income[1]}")

# interest average earned
interest=$(awk -v p="$earners" -v i="$income" 'BEGIN {print (1.0 * i/p)}')
printf "Average interest: %.2f\n" $interest

# How much remaining until I earn 50% of expenses from investment?
ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal ^expenses and not %oneoff | xargs"
readarray -td' ' total <<< "$(eval "$ledger_command")"
average_expenses=$(awk -v total="${total[1]}" -v window="12" 'BEGIN {print (total/window)}')
remaining=$(awk -v i="$interest" -v e="$average_expenses" -v p="$earners" 'BEGIN {print ((6 * e / i) - p)}')
printf "Remaining to survive on interest: %.2f" $remaining

