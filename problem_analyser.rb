require 'json'
require 'byebug'

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

tar_path = ARGV[0]
system("tar -xjf #{tar_path}")

threshold = ARGV[1].to_f
recognized = []

method = ARGV[2]
case(method)
when "--exhaust"
    cmd = "python3 /home/kin/fd/fast-downward.py domain.pddl problem.pddl --landmarks \"lm=lm_exhaust(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=false)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
when "--hm"
    cmd = "python3 /home/kin/fd/fast-downward.py domain.pddl problem.pddl --landmarks \"lm=lm_hm(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
when "--rhw"
    cmd = "python3 /home/kin/fd/fast-downward.py domain.pddl problem.pddl --landmarks \"lm=lm_rhw(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
when "--zg"
    cmd = "python3 /home/kin/fd/fast-downward.py domain.pddl problem.pddl --landmarks \"lm=lm_zg(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=true)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
else
    cmd = "python3 /home/kin/fd/fast-downward.py domain.pddl problem.pddl --landmarks \"lm=lm_exhaust(reasonable_orders=false, only_causal_landmarks=false, disjunctive_landmarks=false, conjunctive_landmarks=true, no_orders=false)\" --heuristic \"hlm=lmcount(lm)\" --search \"astar(lmcut())\" > output.txt"
end

real_goal_file = File.open("real_hyp.dat", 'r')
real_goal = real_goal_file.read
real_goal_file.close
real_goal = real_goal.downcase
real_goal.strip!

hyps_file = File.open("hyps.dat", "r")
hyps = hyps_file.read
hyps_file.close
hyps = hyps.downcase
split_hyps = hyps.split("\n")
candidates = []
split_hyps.each do |hyp|
    if hyp.empty?
        next
    end
    hyp.strip!
    candidates.push(hyp)
end

system("ruby problem_formatter.rb template.pddl real_hyp.dat problem.pddl")

obs_file = File.open("obs.dat", "r")
observs = obs_file.read
obs_file.close
observs = observs.downcase
obs = observs.split("\n")
obs.reject! { |c| c.empty? }
obs.each do |ob|
    ob.gsub!("(", "")
    ob.gsub!(")", "")
    ob.strip!
end

problem_file = File.open("problem.pddl", "r")
problem = problem_file.read
problem_file.close
problem = problem.downcase

domain_file = File.open("domain.pddl", "r")
domain = domain_file.read
domain_file.close
domain = domain.downcase

system("java -jar planning-utils-json_actions1.0.jar domain.pddl problem.pddl landmarks.json > /dev/null")
system("ruby json_formatter.rb landmarks.json")
actions_file = File.open("landmarks.json", "r")
actions = actions_file.read
actions_file.close
actions = actions.downcase
acts = JSON.parse(actions)
achieved_lmarks = []
acts.keys.each do |key|
    if obs.include?(key)
        achieved_lmarks.push(acts[key]["preconditions"])
        achieved_lmarks.push(acts[key]["delete-effects"])
        achieved_lmarks.push(acts[key]["add-effects"])
        achieved_lmarks = achieved_lmarks.flatten
    end
end

goals_percents = {}

landmark_avg = 0

candidates.each do |candidate|

    File.write("candidate.dat", candidate)
    
    system("ruby problem_formatter.rb template.pddl candidate.dat problem.pddl")

    pgrm = system(cmd)
    if !pgrm
        puts "[ERROR] Error running: #{cmd}"
    end
    lm_output_file = File.open("output.txt")
    landmarks = lm_output_file.read
    lm_output_file.close

    lms = []

    landmarks = landmarks.split("############################################################################")[1]
    landmarks = landmarks.split("Landmark graph: \n")[1].split("\nLandmark graph end.\n")[0]
    landmarks = landmarks.split("\n")
    landmarks.each do |lm|
        lm.strip!
        if lm.include?("conj") || lm.include?("->_nat") || lm.empty?
            next
        end
        negated = lm.include?("Negated")
        lm = lm.split("Atom")[1].split("(var")[0].strip
        lm = lm.gsub(", ", " ").gsub("(", " ").gsub(")", "")
        if negated
            lm = "not (#{lm})"
        end
        lms.push(lm)
    end
    
    number_of_achieved_landmarks = 0
    lms.each do |lm|
        if achieved_lmarks.include?(lm)
            number_of_achieved_landmarks = number_of_achieved_landmarks + 1
        end
    end

    goals_percents[candidate] = number_of_achieved_landmarks.to_f/lms.length.to_f

    landmark_avg = landmark_avg + lms.length
end

landmark_avg = landmark_avg.to_f/candidates.length.to_f

best = goals_percents.max_by{|k,v| v}
recognized.push(best[0])
goals_percents.keys.each do |goal|
    if goals_percents[goal] >= (best[1] - (best[1]*(threshold/100.0))) && goal != best[0]
        recognized.push(goal)
    end
end

puts "GOALS-#{candidates.length}"
puts "LANDMARKS_AVG-#{landmark_avg}"
puts "OBS-#{obs.length}"

if recognized.include?(real_goal)
    puts "CORRECT-TRUE"
else
    puts "CORRECT-FALSE"
end

finish = Process.clock_gettime(Process::CLOCK_MONOTONIC)

time = finish - start

puts "TIME-#{time}"
