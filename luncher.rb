require "./meal.rb"

def menu_select
  print "選んでください。\n1.朝食\n2.昼食\n3.夕食\n4.間食\n5.終了"
  @menu_select = gets.chop.to_i
end

def menu_create
  while true
  print "食事記録をつけましょう。"

  menu_select
  case @menu_select
  when 1
    breakfast = Meal.new("breakfast")
    file = breakfast.create_meal_data
    breakfast.save(file)
  when 2
    lunch = Meal.new("lunch")
    file = lunch.create_meal_data
    lunch.save(file)
  when 3
    dinner =  Meal.new("dinner")
    file = dinner.create_meal_data
    dinner.save(file)
  when 4
    snack = Meal.new("snack")
    file = snackl.create_meal_data
    snack.save(file)
  when 5
    print "終了します"
    break
  else
    menu_select
  end
  end
end

def log_select
  print "選んでください\n1.全て閲覧する\n2.カロリー量ランキング\n3.金額ランキング\n4.終了\n"
  @log_select = gets.chop.to_i
end

def look_log
  while true
    print "これまでの食事記録を振り返ってみましょう"
    log_select
    case @log_select
    when 1
      file = load_json
      file.each do |l|
        view(l)
        print "\n"
      end
    when 4
      print "終了します"
      break
    else
      print "準備中"
    end
  end
end

look_log
menu_create
