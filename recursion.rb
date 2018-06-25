require 'byebug'

def range(start, last)
  return [] if last < start
  return [last-1] if last - start == 1
  [start].concat(range(start+1, last))
end

def exp_a(base, power)
  return 1 if power == 0
  base * exp_a(base, power - 1)

end


def exp_b(base, power)
  return 1 if power == 0
  return base if power == 1
  if power.even?
    prev_exp = exp_b(base, power / 2)
    prev_exp * prev_exp
  else
    prev_exp = exp_b(base, (power - 1) / 2)
    base * prev_exp * prev_exp
  end

end

def child_projected_income(parent_age)
  child_age = parent_age / 2
  child_bank_account = child_age**2
  years_before_retirement = 65 - child_age
  child_bank_account * years_before_retirement
end

class Array
  def deep_dup
    return [] if self.empty?
    result = []

    self.each do |el|
      if el.is_a?(Array)
        result << el.deep_dup
      else
        result << el
      end
    end
    result
  end
end

def iterative_fib(num)
  return [1] if num == 1
  fib_array = [1, 1]

  while num > 2
    previous_num = fib_array[-2]
    current_num = fib_array[-1]
    fib_array << previous_num + current_num
    num -= 1

  end
  fib_array
end

def recursive_fib(num)
  return [1] if num == 1
  return [1, 1] if num == 2

  prev_fib = recursive_fib(num - 1)
  prev_fib << prev_fib[-1] + prev_fib[-2]
end

def bsearch(array, target)
  if array.length == 1
    if array.first == target
      return 0
    else
      return nil
    end
  end

  mid = array.length / 2
  if array[mid] < target
    count = bsearch(array[mid+1..-1], target)
    return nil if count.nil?
    count = count + mid + 1
  elsif array[mid] > target
    bsearch(array[0...mid], target)
  else
    mid
  end
end

def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2
  lower_half = merge_sort(array[0...mid])
  top_half = merge_sort(array[mid..-1])

  merge(lower_half, top_half)
end

def merge(arr1, arr2 = nil)
  return arr1 if arr2.nil?
  result = []
  until arr1.empty? || arr2.empty?
    if arr1.first < arr2.first
      result << arr1.shift
    else
      result << arr2.shift
    end
  end
  result + arr1 + arr2
end

class Array
  def subsets
    return [[]] if self.empty?
    last = self.pop
    previous_subset = self.subsets

    result = previous_subset.dup

    previous_subset.each do |el|
      result << el + [last]
    end
    result
  end

end

def permutations(array)
  return [array] if array.length == 1
  last = array.last
  previous_perm = permutations(array[0..-2])
  result = []

  array.length.times do |idx1|
    previous_perm.each_with_index do |el, idx2|
      result << el[0...idx1] + [last] + el[idx1..-1]
    end
  end
  result.sort
end

def greedy_make_change(total, coins)
  return [coins.max] if total - coins.max == 0
  max_coin = coins.max
  if total / max_coin > 0
    [max_coin] + greedy_make_change(total - max_coin, coins)
  else
    coins.shift
    greedy_make_change(total, coins)
  end
end

def make_better_change(total, coins)
  return [] if total == 0
  return make_better_change(total, coins[1..-1]) if coins.first > total

  best_combo = []

  coins.each do |coin|
    debugger
    combinations = []
    lower_coins = coins.select{|c| c <= coin}
    combinations << [coin] + make_better_change(total - coin, lower_coins)
    combinations.sort_by!{|combo| combo.length}
    best_combo << combinations.first
  end

  best_combo.sort_by!{|combo| combo.length}
  best_combo.first

end

p make_better_change(24, [10, 7, 1])
