require "date"
require "json"
class Meal
  def initialize(name)
    d = Date.today
    @name = name
    @date_info = {"year" => d.year,"month" => d.month,"day" => d.day}

    @contents_materials = {}
    @cost = []
    @calory = []
    @sum_calory = 0
    @sum_cost = 0

  end

  def create_meal_data
    while true
      print "何を食べましたか？料理名を入力してください。終了したい場合はqを入力してください。"
      content = gets.to_s.chop
      if content == "q"
        print "終了します。入力された料理名は以下の通りです"
        @contents_materials.each_key do |key|
          print key,"\n"
        end

        @cost.each do |cost|
          @sum_cost += cost
        end
        @calory.each do |calory|
          @sum_calory += calory
        end
        print "今日の食事の摂取カロリーは#{@sum_calory}kcal,費用は#{@sum_cost}円です"
        break
      end

      @contents_materials[content] = []

    while true
      print "材料を一点づつ入力してください。終了した場合はqを入力してください"
      material = gets.to_s.chop
      if material == "q"
        print "終了します。あなたが入力した材料は以下の通りです。\n"
        @contents_materials.each_value do |value|
          print value,"\n"
        end
        break
      end

      print "材料費はいくらですか、数字で入力してください。"
      cost = gets.chop.to_i

      print "食材のカロリーはどれくらいですか、数字だけで入力してください"
      calory = gets.chop.to_i

      @calory << calory
      @cost << cost
      @contents_materials[content] << material
    end
  end
  @meal_data = {"menu_and_materials" => @contents_materials,"cost" => @sum_cost, "calory" => @sum_calory}
  @meal_file = {"date" => @date_info, "name" => @name, "contents" => @meal_data}
  return @meal_file
  end

  def save(save_file)
    json_data = load_json
    if json_data.nil?
      json_data = []
    end
    json_data << save_file
    File.open("meal_data.json","w") do |file|
      str = JSON.dump(json_data,file)
    end
    print "Success!"
  end
end

def load_json
  File.open("meal_data.json") do |j|
    @json_data = JSON.load(j)

  end
  return @json_data
end

def view(data)
  print "#{data["date"]["year"]}/#{data["date"]["month"]}/#{data["date"]["day"]} #{data["name"]}#{data["contents"]["menu_and_materials"].keys} カロリー:#{data["contents"]["calory"]}kcal 金額:#{data["contents"]["cost"]}円"
end
