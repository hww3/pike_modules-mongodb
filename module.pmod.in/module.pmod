constant __author = "Bill Welliver <bill@welliver.org>";
constant __version = "1.0";

// if necessary, inherit the C language module here.
inherit Database.___MongoDB;

class Collection
{
  inherit LowCollection;

  //!
  array find(mapping query)
  {
    array res;
    res = low_find(Standards.BSON.to_document(query, 1));
    foreach(res; int i; mixed e)
    {
      res[i] = Standards.BSON.from_document(e);
    }
    return res;
  }
  
  //! @returns object id of inserted object(s)
  string|array(string) insert(mapping|array(mapping) obj)
  {
    if(arrayp(obj))
    {
      array saved = ({});


      foreach(obj; int i; mapping d)
      {
        if(!d->_id)
           d->_id = Standards.BSON.ObjectId();
        
        saved += ({ insert(d) });
      }

      return saved;
    }
    
    if(!obj->_id)
      obj->_id = Standards.BSON.ObjectId();
    if(!insert_bson(Standards.BSON.to_document(obj))) 
      return (string)(obj->_id);
    else return 0;
  }
  
  //!
  int update(mapping condition, mapping operation, int flags)
  {
     return update_bson(Standards.BSON.to_document(condition), Standards.BSON.to_document(operation, 1), flags);  
  }
  
  //! create index
  int create_index(mapping indexspec, int flags)
  {
    return create_index_bson(Standards.BSON.to_document(indexspec), flags);      
  }
}
