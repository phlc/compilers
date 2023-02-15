class Compare{
  isPlus(s : String) : Bool {
    s = "+"
  };
  isS(s : String) : Bool {
    s = "s"
  };
  isE(s : String) : Bool {
    s = "e"
  };
  isD(s : String) : Bool {
    s = "d"
  };
  isX(s : String) : Bool {
    s = "x"
  };
};

class Main inherits IO {
  compare : Compare <- new Compare;
  input : String <- "";

  main() : Object {{
      while (not compare.isX(input)) loop {
        input <- in_string();
        out_string(input.concat("\n"));
      }
      pool;
  }};
};  