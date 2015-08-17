table thing : {
  Nam : string
}

fun filterRows aFilter anOffset = 
  case aFilter of
      "" =>
        queryX1 
          ( SELECT thing.Nam 
            FROM thing 
            ORDER BY thing.Nam 
            LIMIT 50 
            OFFSET {anOffset} )
          (fn r => <xml>{[r.Nam]}<br/></xml>)
    | _ =>
        queryX1 
          ( SELECT thing.Nam 
            FROM thing 
            WHERE thing.Nam LIKE {['%' ^ aFilter ^ '%']} 
            ORDER BY thing.Nam 
            LIMIT 50 
            OFFSET {anOffset} )
          (fn r => <xml>{[r.Nam]}<br/></xml>)

fun main () =
  theFilter <- source "" ;
  rows <- source <xml/> ;
  theOffset <- source 0;
  return 
  <xml>
    <body onload={rows' <- rpc (filterRows "" 0); set rows rows'}>
      <button 
        value="<" 
        onclick={
          fn _ => 
            theOffset' <- get theOffset ;
            set theOffset (if theOffset' >= 50 then theOffset' - 50 else 0) ;
            theOffset' <- get theOffset ;
            theFilter' <- get theFilter ;
            rows' <- rpc (filterRows theFilter' theOffset') ; 
            set rows rows'
        }/>
      <ctextbox 
        source={theFilter}
        onkeyup={
          fn _ =>
            set theOffset 0 ;
            theFilter' <- get theFilter ;
            theOffset' <- get theOffset ;
            rows' <- rpc (filterRows theFilter' theOffset') ; 
            set rows rows'
        }
      />
      <button 
        value=">" 
        onclick={
          fn _ => 
            theOffset' <- get theOffset ;
            set theOffset (theOffset' + 50) ;
            theOffset' <- get theOffset ;
            theFilter' <- get theFilter ;
            rows' <- rpc (filterRows theFilter' theOffset') ; 
            set rows rows'
        }/>
      <br/>
      <dyn 
        signal={
          rows' <- signal rows ; 
          return rows'
        }
      />
    </body>
  </xml>