constant __author = "Bill Welliver <bill@welliver.org>";
constant __version = "1.0";

// if necessary, inherit the C language module here.
inherit Database.___MongoDB;

class Collection
{
  inherit LowCollection;
}
