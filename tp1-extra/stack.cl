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

class Node{
  value : String <- "null";
  next : Node;

  set_value (new_value : String) : String{
    value <- new_value
  };

  get_value () : String{
    value
  };

  set_node (next_node : Node) : Node{
    next <- next_node
  };

  get_node () : Node{
    next
  };
};

Class Stack inherits IO {
  head : Node <- new Node;

  push(new_value : String) : Object {
    let tmp : Node <- head in {
      head <- new Node;
      head.set_value(new_value);
      head.set_node(tmp);
    }
  };

  pop() : Node {
    let tmp : Node <- head in {
      if isvoid tmp.get_node() then "" else
        head <- tmp.get_node()
      fi;
      tmp;
    }
  };
 
  print() : Object{
    let tmp : Node <- head in {
      while (not isvoid tmp.get_node()) loop {
        out_string(tmp.get_value().concat("\n"));
        tmp <- tmp.get_node();
      } 
      pool;
    }
  };
};

class StackMachice inherits Stack{
  compare : Compare <- new Compare;
  input : String <- "";
  converter : A2I <- new A2I;

  eval() : Object {{
    if head.get_value() = "+" then {
      pop();
      let i : Int <- 0 in {
        i <- converter.a2i(head.get_value());
        pop();
        i <- i + converter.a2i(head.get_value());
        head.set_value(converter.i2a(i));
      };
    } else
      if head.get_value() = "s" then{
        pop();
         let n : Node <- head in {
          head <- head.get_node();
          n.set_node(head.get_node());
          head.set_node(n);
         };
      } else ""
    fi fi;
  }};

  run() : Object {{
    out_string("Enter Command: ");
    input <- in_string();
    
    while not compare.isX(input) loop {
      if compare.isX(input) then out_string("\n") else
      if compare.isD(input) then print() else
      if compare.isE(input) then eval() else
      if compare.isS(input) then push("s") else
      if compare.isPlus(input) then push("+") else
        push(input)
      fi fi fi fi fi;
      out_string("Enter Command: ");
      input <- in_string();
    } pool;
    out_string("Execution End\n");
  }};

};

class Main{
  machine : StackMachice <- new StackMachice;

  main() : Object {machine.run()};
};  