# After how many steps the adder stores the computed final sum value? Is this number constant? Can you explain its behaviour?
The `adder` may take four steps.

One of the worst cases is when all four digits are independent, and all the
variables in `bit-adder` are initialised to the wrong values.
For example, if there is no carry among the various digits involved in the
operations, but the various `cin` parameters are initialised to `TRUE` the
system evolves digit by digit.
In the case described by the model below, after one step nuXmv fixes the value
and carry for the 0th bit; a second step takes the carry from the previous step
and uses it to compute the correct value and carry for the 1st bit; so on and so
forth.

Example:
```
-- This module constains the logic for a full adder
MODULE bit-adder(in1, in2, cin, sum_init, cout_init)
VAR
  sum : boolean;
  cout : boolean;
ASSIGN
  init(sum) := sum_init;
  next(sum) := (in1 xor in2) xor cin;
  init(cout) := cout_init;
  next(cout) := (in1 & in2) | ((in1 xor in2) & cin);

-- Here I hardcoded all the wrong initial values for the full adder; bit[0]
-- should have sum 0 and no carry, so bit[0]: bit-adder(...., TRUE, TRUE).
-- Same for all the other bits, bit[1] should have sum 1 and no carry.
MODULE adder(in1, in2)
VAR
  bit[0] : bit-adder(in1[0], in2[0], bool(0), TRUE, TRUE);
  bit[1] : bit-adder(in1[1], in2[1], bit[0].cout, FALSE, TRUE);
  bit[2] : bit-adder(in1[2], in2[2], bit[1].cout, FALSE, TRUE);
  bit[3] : bit-adder(in1[3], in2[3], bit[2].cout, FALSE, TRUE);
DEFINE
  sum[0] := bit[0].sum;
  sum[1] := bit[1].sum;
  sum[2] := bit[2].sum;
  sum[3] := bit[3].sum;
  overflow := bit[3].cout;

-- For the sake of simplicity I fixed the initial numbers to be op1=10 and op2=4
MODULE main
VAR
  in1 : array 0..3 of boolean;
  in2 : array 0..3 of boolean;
  a: adder(in1, in2);
ASSIGN
  init(in1[0]) := FALSE;
  init(in1[1]) := TRUE;
  init(in1[2]) := FALSE;
  init(in1[3]) := TRUE;
  init(in2[0]) := FALSE;
  init(in2[1]) := FALSE;
  init(in2[2]) := TRUE;
  init(in2[3]) := FALSE;
  next(in1[0]) := in1[0];
  next(in1[1]) := in1[1];
  next(in1[2]) := in1[2];
  next(in1[3]) := in1[3];
  next(in2[0]) := in2[0];
  next(in2[1]) := in2[1];
  next(in2[2]) := in2[2];
  next(in2[3]) := in2[3];
DEFINE
  op1 := toint(in1[0]) + 2*toint(in1[1]) + 4*toint(in1[2]) + 8*toint(in1[3]);
  op2 := toint(in2[0]) + 2*toint(in2[1]) + 4*toint(in2[2]) + 8*toint(in2[3]);
  sum := toint(a.sum[0]) + 2*toint(a.sum[1]) + 4*toint(a.sum[2]) + 8*toint(a.sum[3]) + 16*toint(a.overflow);
```
# What happens if we initialize both sum and cout inside the bit-adder to FALSE? Can you tell the main difference with respect to the original algorithm?
The algorithm stops as soon as there is no carry to propagate.
