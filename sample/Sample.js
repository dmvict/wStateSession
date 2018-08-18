
let _ = require( 'wTools' );
require( 'wstatesession' );

/**/

let Self = function wSample( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

//

function init( o )
{
  let sample = this;
  _.instanceInit( sample );
}

//

let Associates =
{
  storageFileName : '.sample.config.json',
  fileProvider : _.fileProvider,
}

//

let Extend =
{

  init : init,
  Associates : Associates,

}

//

_.classDeclare
({
  cls : Self,
  extend : Extend,
});

_.StateStorage.mixin( Self );

//

// let sample = new Self();
// sample.storageLoad();
