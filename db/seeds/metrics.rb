# Seed data for metrics table from CSV data
metrics_data = [
  {
    name: "Broad Jump",
    instructions: "Stand behind a line, swing arms, bend knees, and jump forward as far as possible; measure the best jump of 2-3 attempts.",
    measures: "Lower-body explosive power",
    unit: "inches",
    boys_90pct: "78",
    girls_90pct: "68",
    notes: "Approximate blended target; based on standing long jump style norms."
  },
  {
    name: "Shot Put / Softball Throw",
    instructions: "Throw a ball from a set start with a legal overhead or chest-style motion, depending on protocol; measure best of 2-3 throws.",
    measures: "Upper-body power",
    unit: "inches",
    boys_90pct: "290",
    girls_90pct: "240",
    notes: "Approximate blended target; exact implement and age matter a lot."
  },
  {
    name: "Push-ups",
    instructions: "Lower body in plank, lower chest to proper depth, and return to full arm extension; count valid reps.",
    measures: "Upper-body endurance",
    unit: "reps",
    boys_90pct: "35",
    girls_90pct: "20",
    notes: "Approximate blended target; right-angle style standards can differ."
  },
  {
    name: "Sit-ups (60s max reps)",
    instructions: "Lie back, bend knees, and sit up repeatedly for 60 seconds with valid form.",
    measures: "Core endurance",
    unit: "reps",
    boys_90pct: "50",
    girls_90pct: "42",
    notes: "Approximate blended target; curl-up protocol is often substituted."
  },
  {
    name: "Chin-ups",
    instructions: "Hang with palms facing you, pull until chin clears the bar; count valid reps.",
    measures: "Upper-body pulling strength",
    unit: "reps",
    boys_90pct: "12",
    girls_90pct: "4",
    notes: "Approximate blended target; many batteries use flexed-arm hang for girls."
  },
  {
    name: "Pull-ups",
    instructions: "Hang with palms away, pull until chin clears the bar; count valid reps.",
    measures: "Upper-body pulling strength",
    unit: "reps",
    boys_90pct: "10",
    girls_90pct: "2",
    notes: "Approximate blended target; often close to chin-up norms."
  },
  {
    name: "Handstand Hold",
    instructions: "Kick up to a stable handstand and hold without stepping or collapsing; time from stable position to loss of control.",
    measures: "Balance, shoulder strength",
    unit: "seconds",
    boys_90pct: "20",
    girls_90pct: "15",
    notes: "Approximate blended target; not a standard normed school test."
  },
  {
    name: "Wall Sit",
    instructions: "Back flat against wall, knees near 90 degrees, hold as long as possible.",
    measures: "Lower-body endurance",
    unit: "seconds",
    boys_90pct: "120",
    girls_90pct: "105",
    notes: "Approximate best-effort target; often used in general fitness batteries."
  },
  {
    name: "Toe Reach",
    instructions: "From standing or seated protocol, reach toward toes; measure how far past or short of toes.",
    measures: "Hamstring and lower-back flexibility",
    unit: "inches",
    boys_90pct: "6",
    girls_90pct: "8",
    notes: "Approximate blended target; close variant of sit-and-reach."
  },
  {
    name: "50-Yard Dash",
    instructions: "Sprint 50 yards from a start; record the fastest legal time.",
    measures: "Speed",
    unit: "seconds",
    boys_90pct: "7.2",
    girls_90pct: "7.8",
    notes: "Approximate blended target; track timing method matters."
  },
  {
    name: "1-Mile Run",
    instructions: "Run one mile as fast as possible; record finish time.",
    measures: "Aerobic endurance",
    unit: "seconds",
    boys_90pct: "390",
    girls_90pct: "450",
    notes: "Approximate blended target; age and surface matter a lot."
  },
  {
    name: "Shuttle Run",
    instructions: "Sprint back and forth between markers, touching lines or picking up blocks per protocol; record time.",
    measures: "Agility and speed",
    unit: "seconds",
    boys_90pct: "10.5",
    girls_90pct: "11.3",
    notes: "Approximate blended target; protocols vary widely."
  },
  {
    name: "Jump Rope (60s max reps)",
    instructions: "Perform consecutive jump-rope revolutions or skips in 60 seconds; count valid jumps.",
    measures: "Coordination and cardio endurance",
    unit: "reps",
    boys_90pct: "140",
    girls_90pct: "125",
    notes: "Approximate blended target; test style varies."
  },
  {
    name: "Vertical Jump",
    instructions: "Start flat-footed, jump straight up, and measure vertical displacement.",
    measures: "Lower-body explosive power",
    unit: "inches",
    boys_90pct: "20",
    girls_90pct: "16",
    notes: "Approximate blended target; standing reach method matters."
  },
  {
    name: "Rope Climb",
    instructions: "Climb a rope from the floor to a set point or top; record time or completion.",
    measures: "Upper-body and grip endurance",
    unit: "seconds",
    boys_90pct: "12",
    girls_90pct: "18",
    notes: "Approximate blended target; completion-based tests are also common."
  },
  {
    name: "Plank",
    instructions: "Hold a straight-arm plank position with body in a straight line from head to heels; time until form breaks.",
    measures: "Core endurance",
    unit: "seconds",
    boys_90pct: "180",
    girls_90pct: "150",
    notes: "Target standard for plank hold time; based on general fitness recommendations."
  }
]

metrics_data.each do |metric_data|
  Metric.create!(metric_data)
end

puts "Created #{Metric.count} metrics"
