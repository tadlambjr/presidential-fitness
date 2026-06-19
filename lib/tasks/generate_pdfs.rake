namespace :generate_pdfs do
  desc "Generate all PDF tracking sheets"
  task all: [:individual_performance_log, :group_assessment_template]

  desc "Generate individual performance log PDF"
  task :individual_performance_log do
    require 'prawn'
    require 'prawn/table'

    puts "Generating individual performance log PDF..."

    pdf = Prawn::Document.new(page_layout: :landscape)
    setup_individual_pdf(pdf)
    pdf.render_file "public/pdfs/individual-performance-log.pdf"

    puts "✓ Generated: public/pdfs/individual-performance-log.pdf"
  end

  desc "Generate group assessment template PDF"
  task :group_assessment_template do
    require 'prawn'
    require 'prawn/table'

    puts "Generating group assessment template PDF..."

    pdf = Prawn::Document.new(page_layout: :landscape)
    setup_group_pdf(pdf)
    pdf.render_file "public/pdfs/group-assessment-template.pdf"

    puts "✓ Generated: public/pdfs/group-assessment-template.pdf"
  end

  private

  def setup_individual_pdf(pdf)
    # Suppress font warning
    Prawn::Fonts::AFM.hide_m17n_warning = true


    # Header
    pdf.font_size 14
    pdf.text "Presidential Fitness Test", align: :center, style: :bold
    pdf.font_size 12
    pdf.text "Individual Performance Log", align: :center
    pdf.font_size 10
    pdf.text "Maple Row Homestead Edition", align: :center
    pdf.move_down 3

    # Note at top
    pdf.font_size 8
    pdf.text 'Note: Targets show boys/girls 90th percentile standards', align: :center
    pdf.move_down 5

    # Date headers - "Date" in each column
    date_headers = ["Exercise", "Date", "Date", "Date", "Date", "Date", "Date", "Date", "Date", "Date", "Date"]

    pdf.table([date_headers],
      cell_style: {
        size: 8,
        padding: [ 2, 2 ],
        borders: [ :top, :bottom, :left, :right ],
        text_color: "333333"
      },
      column_widths: [ 180, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54 ]
    ) do
      row(0).font_style = :bold
      row(0).background_color = "E8E8E8"
      column(0).background_color = "E8E8E8"
      columns(1..10).align = :left
      columns(1..10).valign = :top
    end

    # Interleaved exercises with full-width info rows and measurement rows
    exercises = [
      {name: "Broad Jump", target: "78\"/68\"", unit: "inches", instruction: "Stand behind line, swing arms, jump forward; measure best 2-3 attempts"},
      {name: "Pull-ups", target: "10/2", unit: "reps", instruction: "Hang palms away, pull until chin clears bar; count valid reps"},
      {name: "Plank", target: "180s/150s", unit: "seconds", instruction: "Hold straight-arm plank; time until form breaks"},
      {name: "50-Yard Dash", target: "7.2s/7.8s", unit: "seconds", instruction: "Sprint 50 yards from start; record fastest legal time"},
      {name: "Vertical Jump", target: "20\"/16\"", unit: "inches", instruction: "Start flat-footed, jump straight up; measure vertical displacement"},
      {name: "Push-ups", target: "35/20", unit: "reps", instruction: "Lower body in plank, lower chest to depth, return to extension; count valid reps"},
      {name: "Toe Reach", target: "6\"/8\"", unit: "inches", instruction: "From standing or seated, reach toward toes; measure past or short of toes"},
      {name: "Shuttle Run", target: "10.5s/11.3s", unit: "seconds", instruction: "Sprint back and forth between markers; record time"},
      {name: "Shot Put", target: "290\"/240\"", unit: "inches", instruction: "Throw ball from start with legal motion; measure best of 2-3 throws"},
      {name: "Sit-ups", target: "50/42", unit: "reps", instruction: "Lie back, bend knees, sit up repeatedly for 60 seconds; count valid reps"},
      {name: "Wall Sit", target: "120s/105s", unit: "seconds", instruction: "Back flat against wall, knees near 90°, hold as long as possible"},
      { name: "1-Mile Run", target: "6:30/7:30", unit: "minutes", instruction: "Run one mile as fast as possible; record finish time" },
      {name: "Chin-ups", target: "12/4", unit: "reps", instruction: "Hang palms facing you, pull until chin clears bar; count valid reps"},
      {name: "Handstand Hold", target: "20s/15s", unit: "seconds", instruction: "Kick up to stable handstand and hold; time from stable to loss of control"},
      {name: "Jump Rope", target: "140/125", unit: "reps", instruction: "Perform consecutive jumps in 60 seconds; count valid jumps"},
      {name: "Rope Climb", target: "12s/18s", unit: "seconds", instruction: "Climb rope from floor to set point; record time or completion"}
    ]

    exercises.each do |exercise|
      # Single row with metric name in column 1 and instruction spanning columns 2-11
      exercise_data = [
        "#{exercise[:name]} (Target: #{exercise[:target]} #{exercise[:unit]})",
        exercise[:instruction]
      ]

      pdf.table([exercise_data],
        cell_style: {
          size: 7,
          padding: [ 2, 4 ],
          borders: [ :top, :bottom, :left, :right ],
          text_color: "333333"
        },
        column_widths: [ 180, 540 ]
      ) do
        column(0).font_style = :bold
        row(0).background_color = "F8F8F8"
      end

      # Measurement row without "Result" label, triple height
      measurement_row = ['', '', '', '', '', '', '', '', '', '', '']

      pdf.table([measurement_row],
        cell_style: {
          size: 8,
          padding: [ 8, 6 ],
          borders: [ :top, :bottom, :left, :right ],
          text_color: "333333"
        },
        column_widths: [ 180, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54 ]
      )
    end

    # Footer
    pdf.move_down 5
    pdf.font_size 8
    pdf.text "https://fitness.roaringlambproductions.com/", align: :left
  end

  def setup_group_pdf(pdf)
    # Suppress font warning
    Prawn::Fonts::AFM.hide_m17n_warning = true

    # Header
    pdf.font_size 16
    pdf.text 'Presidential Fitness Test', align: :center, style: :bold
    pdf.text 'Group Assessment', align: :center
    pdf.text 'Maple Row Homestead Edition', align: :center
    pdf.move_down 10

    # Note about target values
    pdf.font_size 10
    pdf.text 'Note: Target values shown as (boys/girls 90th percentile)', align: :center
    pdf.move_down 15

    # Single header row with all metrics and units
    headers = [
      '',
      'Broad Jump (inches)',
      'Pull-ups (reps)',
      'Plank (seconds)',
      '50Y Dash (seconds)',
      'Vertical Jump (inches)',
      'Push-ups (reps)',
      'Toe Reach (inches)',
      'Shuttle Run (seconds)',
      'Shot Put (inches)',
      'Sit-ups (reps)',
      'Wall Sit (seconds)',
      '1 Mile (minutes)',
      'Chin-ups (reps)',
      'Handstand (seconds)',
      'Jump Rope (reps)',
      'Rope Climb (seconds)'
    ]

    pdf.table([headers],
      cell_style: {
        size: 6,
        padding: [6, 4],
        borders: [:top, :bottom, :left, :right],
        background_color: 'E8E8E8',
        text_color: '333333',
        font_style: :bold,
        align: :center
      },
      column_widths: [144, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36]
    ) do
      column(0).align = :left
    end

    # Second header row with target values
    target_headers = [
      'Participant',
      '78/68',
      '10/2',
      '180/150',
      '7.2/7.8',
      '20/16',
      '35/20',
      '6/8',
      '10.5/11.3',
      '290/240',
      '50/42',
      '120/105',
      '6:30/7:30',
      '12/4',
      '20/15',
      '140/125',
      '12/18'
    ]

    pdf.table([target_headers],
      cell_style: {
        size: 6,
        padding: [6, 4],
        borders: [:top, :bottom, :left, :right],
        background_color: 'F0F0F0',
        text_color: '333333',
        font_style: :bold,
        align: :center
      },
      column_widths: [144, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36]
    ) do
      column(0).align = :left
    end

    # Add 25 blank participant rows
    15.times do |i|
      row_data = [''] + Array.new(16, '')
      pdf.table([row_data],
        cell_style: {
          size: 8,
          padding: [11, 4],
          borders: [:top, :bottom, :left, :right],
          text_color: '333333'
        },
        column_widths: [144, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36]
      )
    end

    # Footer
    pdf.move_down 30
    pdf.font_size 8
    pdf.text "https://fitness.roaringlambproductions.com/", align: :left
  end
end
