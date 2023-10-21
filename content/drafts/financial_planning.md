Title: Financial Planning
Date: 2023-05-31
Category: Random
Slug: financial_planning
Author: John Nduli

TODO:

- create a single ledger file that I'll use in all my examples
- harmonize examples to work with this single ledger file
- test out all code examples


I record my expenses and income in
[ledger-cli](https://ledger-cli.org/doc/ledger3.html), for example:

```ledger
2023-01-01 * Opening Balances
    Assets:cash                                    Ksh 1000.00
    Equity:Opening Balances

2023-01-03 * Home
    Expenses:water                                  Ksh 250.00
    Expenses:food                                   Ksh 500.00
    Assets:cash

2023-01-31 * Salary
    Assets:bank                                    Ksh 3000.00
    Income:job

2023-02-01 * Transport
    Expenses:transport                              Ksh 100.00
    Assets:cash

2023-02-01 * Hospital
    Expenses:doctor                                Ksh 1000.00 ; oneoff:
    Expenses:medicine                               Ksh 200.00 ; oneoff:
    Assets:bank

2023-02-14 * Investment
    Assets:bank                                     Ksh 200.00
    Income:investment

2023-02-28 * Salary
    Assets:bank                                    Ksh 2000.00
    Income:job

```

I get my total expenses using:

```bash
ledger --no-pager --permissive --depth 1 \
    --file trial.ledger \
    --begin 2023-01-01 \
    --end 2023-02-28 \
    bal expenses               
         Ksh 2451.00  Expenses
```

I tag some expenses with `oneoff` to show that they aren't regular expenses. If
I want to exclude these from my report, I do:

```bash
ledger --no-pager --permissive --depth 1 \
    --file trial.ledger \
    --begin 2023-01-01 \
    --end 2023-02-28 \
    bal expenses and not %oneoff
         Ksh 1251.00  Expenses
```

I can get total income with:

```bash
$ ledger --file income.ledger --permissive --no-pager bal income --begin 2023-01-01 --end 2023-03-01 --depth 1
        Ksh -4200.00  Income
# and a detailed breadkdown with
$ ledger --file income.ledger --permissive --no-pager bal income --begin 2023-01-01 --end 2023-03-01
        Ksh -4200.00  Income
         Ksh -200.00    investment
        Ksh -4000.00    job
--------------------
        Ksh -4200.00
```

I can filter out my salary to see my side income with:

```bash
$ ledger -f income.ledger --permissive --no-pager --begin 2023-01-01 --end 2023-03-01 --depth 1 bal income and not job
         Ksh -200.00  Income
# or         
$ ledger -f income.ledger --permissive --no-pager --begin 2023-01-01 --end 2023-03-01 --depth 1 bal income:investment 

         Ksh -200.00  Income
```



TODO: clean up

I get a 12 month rolling expense report using the above command. This helps me
see a trend in my expenses.

```bash
for i in {12..0}; do
    end_date=$(date -d "$(date +%Y/%m/01) - $i month - 1 day" "+%Y/%m/%d")
    start_date=$(date -d "$end_date - 12 month + 1 day" "+%Y/%m/%d")
    ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal expenses and not %oneoff | xargs"
    readarray -td' ' yearly_expenses <<< "$(eval "$ledger_command")"
    average_monthly=$(awk '{print ($1/12)}' <<<"${yearly_expenses[1]}")
    printf "Avg monthly from %s to %s: %'.2f \-\n" "$start_date" "$end_date" "$average_monthly"
done
```
Note: I haven't used -f in the above command since I've set up the correct file
in my `.ledgerrc`.


I generate a 12 month rolling window average to see trends in my income with:

```bash
#!/bin/bash
for i in {12..0}; do
    end_date=$(date -d "$(date +%Y/%m/01) - $i month - 1 day" "+%Y/%m/%d")
    start_date=$(date -d "$end_date - 12 month + 1 day" "+%Y/%m/%d")
    ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal income:investment | xargs"
    readarray -td' ' yearly_income <<< "$(eval "$ledger_command")"
    average_monthly=$(awk '{print ($1/12)}' <<<"${yearly_income[1]}")
    printf "Avg monthly income from %s to %s: %'.2f \-\n" "$start_date" "$end_date" "$average_monthly"
done
```

I can get some financial health metrics from the above reports. For example, if
I wan't to learn how long I can survive without my main income (salary):


$$
\begin{aligned}
l = liquid\_assets, i = monthly\_income \\
e = monthly\_expenses, x = no\_of\_months \\
l + ix - ex = 0 \\
x = \frac{l}{e-i}
\end{aligned}
$$

and here's the code for this:

```bash
# window for calculations
end_date=$(date -d "$(date +%Y/%m/01) - 1 day" "+%Y/%m/%d")
start_date=$(date -d "$end_date - 12 month + 1 day" "+%Y/%m/%d")
# average monthlu income
ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal income:investment | xargs"
readarray -td' ' yearly_income <<< "$(eval "$ledger_command")"
income=$(awk -v total="${total[1]}" 'BEGIN {print (total/12)}')

# average monthly expenses
ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal ^expenses and not %oneoff | xargs"
readarray -td' ' total <<< "$(eval "$ledger_command")"
expenses=$(awk -v total="${total[1]}" 'BEGIN {print (total/12)}')

# liquid assets
# and section limites this from illiquid assets e.g. fixed deposit bank accounts
ledger_command="ledger -X Ksh --depth 1 bal assets and \(bank or cash or mpesa\) | xargs"
readarray -td' ' total <<< "$(eval "$ledger_command")"
liquid="${total[1]}"

months_remaining=$(awk -v l="$liquid" -v i="$average_income" -v m="$average_expenses" 'BEGIN {print (l / (m-i))}')
echo "Months without job: $months_remaining" 
```

I can get the average interest rate of my investments for the last 12 months. I
use the interest to get a rouhg idea for how much more I need to have to cater
for half my monthly expenses (assuming I can maintain this interest).

$$
\begin{aligned}
interest = i, interest\_earners = p \\
monthly\_expenses = e \\
expected\_income = 0.5 * e \\
0.5e = new_p * i / 12 \\
new_p = \frac{6e}{i} \\
remaining = \frac{6e}{i} - new_p
\end{aligned}
$$

and here's the code for this:

```bash
end_date=$(date -d "$(date +%Y/%m/01) - 1 day" "+%Y/%m/%d")
start_date=$(date -d "$end_date - 12 month + 1 day" "+%Y/%m/%d")

# use and to filter out the interest earning assets
ledger_command="ledger -X Ksh --depth 1 bal assets and \(savings or cbk or mutual_fund\) | xargs"
readarray -td' ' total <<< "$(eval "$ledger_command")"
earners="${total[1]}"

# average monthlu income from the earners
ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal income:investment | xargs"
readarray -td' ' yearly_income <<< "$(eval "$ledger_command")"
income=$(awk '{print (-1 * $1)}' <<<"${yearly_income[1]}")

# interest average earned
interest=$(awk -v p="$earners" -v i="$income" 'BEGIN {print (1.0 * i/p)}')
printf "Average interest: %.2f\n" $interest

# How much remaining until I earn 50% of expenses from investment?
ledger_command="ledger --begin $start_date --end $end_date --depth 1 -X Ksh bal ^expenses and not %oneoff | xargs"
readarray -td' ' total <<< "$(eval "$ledger_command")"
average_expenses=$(awk -v total="${total[1]}" 'BEGIN {print (total/12)}')
remaining=$(awk -v i="$interest" -v e="$average_expenses" -v p="$earners" 'BEGIN {print ((6 * e / i) - p)}')
printf "Remaining to survive on interest: %.2f" $remaining
```

I hate using bash for these calculations, and I've seen that ledger has a python
api that I'll learn and see if I can make this better.
