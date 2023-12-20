PuzzleExample1 = '
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a
'

PuzzleExample2 = '
broadcaster -> a
%a -> inv, con
&inv -> b
%b -> con
&con -> output
'

PuzzleInput1 = ''
