-module(d1).
-export ([find/1, find_part_two/1]).

find(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    List = binary:split(Binary, [<<"\n">>], [global]),
    
    [H | _] = calculateElves(List, [], 0),

    H.
find_part_two(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    List = binary:split(Binary, [<<"\n">>], [global]),

    [One, Two, Three | _] = calculateElves(List, [], 0),

    One + Two + Three.

calculateElves([], Res, _) ->
    Res;
calculateElves([H | T], Res, ElfAcc) ->
    case H of 
        <<>> -> NewRes = addElf(Res, ElfAcc), NewAmout = 0;
        <<Amount/binary>> -> NewAmout = ElfAcc + binary_to_integer(Amount), NewRes = Res
end,

calculateElves(T, NewRes, NewAmout).

addElf([], Calories) ->
    [Calories];
addElf([H | _] = List, Calories) when Calories > H ->
    [Calories | List];
addElf([H | T], Calories) ->
    [H | addElf(T, Calories)].
      
