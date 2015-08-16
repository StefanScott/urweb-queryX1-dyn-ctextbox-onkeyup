table thing : {
  Nam : string
}

fun filterRows fltr = 
  case fltr of
      "" =>
        queryX1 
          (SELECT thing.Nam FROM thing)
          (fn r => <xml>{[r.Nam]}<br/></xml>)
    | _ =>
        queryX1 
          (SELECT thing.Nam FROM thing WHERE thing.Nam LIKE {['%' ^ fltr ^ '%']})
          (fn r => <xml>{[r.Nam]}<br/></xml>)

fun main () =
  filt <- source ""
  ;
  rows <- source <xml/>
  ;
  return 
    <xml><body>
      <ctextbox 
        source={filt}
        onkeyup={
          fn _ =>
            filt <- get filt
            ;
            rows' <- rpc (filterRows filt)
            ; 
            set rows rows'
        }
      /><br/>
      <dyn 
        signal={
          rows' <- signal rows
          ; 
          return rows'
        }
      />
    </body></xml>