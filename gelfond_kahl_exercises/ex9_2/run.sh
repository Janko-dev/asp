
cd "$(dirname "$0")"

# run with horizon n = 2
clingo 0 -c n=4 briefcase_system.lp simple_planner.lp input.lp 
