
cd "$(dirname "$0")"

# run to see if configuration.lp is a symptom
# if consistent, then C is not a symptom
# if inconsistent, then C is a symptom
# clingo 0 baking_system.lp all_clear.lp configuration.lp 

# run to see all possible explanations for the symptom
clingo 0 diagnose.lp baking_system.lp all_clear.lp configuration.lp 
