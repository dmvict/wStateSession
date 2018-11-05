( function _StateSession_s_() {

'use strict';

/**
  @module Tools/mid/StateSession - Mixin to add persistent session storing functionality to a class. StateSession extends StateStorage. These modules solve the common problem to persistently store the state( session ) of an object. Them let save the state in a specific moment ( for example on process exit ) and to restore the state later ( for example on process start ). Use the module to be more cross-platform, don't repeat yourself and forget about details of implementation you don't worry.
*/

/**
 * @file files/StateSession.s.
 */

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  let _ = _global_.wTools;

  _.include( 'wProto' );
  _.include( 'wStateStorage' );

}

//

let _global = _global_;
let _ = _global_.wTools;
let Parent = null;
let Self = function wStateSession( o )
{
  _.assert( arguments.length === 0 || arguments.length === 1, 'Expects single argument' );
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'StateSession';

// --
//
// --

function sessionCreate()
{
  let self = this;
  let exists = true;

  _.assert( self.opened !== undefined );
  _.assert( !self.opened );
  _.assert( arguments.length === 0 );

  if( self.storageFilePath === null )
  self.storageFilePath = self.storageFilePathToSaveGet();
  self.opened = 1;

  return exists;
}

//

function sessionOpenOrCreate()
{
  let self = this;
  let exists = true;

  _.assert( self.opened !== undefined );
  _.assert( !self.opened );
  _.assert( arguments.length === 0 );

  if( !self.opened )
  {
    if( !self.storageLoad() )
    {
      exists = false;
    }
  }

  self.sessionCreate();

  return exists;
}

//

function sessionOpen()
{
  let self = this;

  if( self.opened )
  return self;

  _.assert( self.opened !== undefined );
  _.assert( !self.opened );
  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( self.storageFileName ), 'Expects string field {-storageFileName-}' );

  if( !self.storageLoad() )
  throw _.errBriefly
  (
    'Cant open a session ' + _.strQuote( self.storageFileName ) + '.\n'
    + 'At ' + _.strQuote( self.storageFilePathToLoadGet() ) + '.'
  );

  self.opened = 1;
  return self;
}

//

function sessionClose()
{
  let self = this;
  _.assert( self.opened !== undefined );
  _.assert( arguments.length === 0 );

  if( !self.opened )
  {
    return self ;
  }

  self.opened = 0;
  if( self.storageFilePath !== undefined )
  self.storageFilePath = null;
  if( self.storagesLoaded )
  self.storagesLoaded.splice( 0 );

  return self;
}

//

function sessionCloseSaving()
{
  let self = this;
  _.assert( self.opened !== undefined );
  _.assert( arguments.length === 0 );
  if( !self.opened )
  return;
  self.sessionSave();
  self.sessionClose();
  return self;
}

//

function sessionSave()
{
  let self = this;
  _.assert( self.opened !== undefined );
  _.assert( !!self.opened, 'Cant save closed session' );
  _.assert( arguments.length === 0 );
  self.storageSave();
  return self;
}

// --
//
// --

let MustHave =
{
  opened : null,
}

let CouldHave =
{
  storageFilePath : null,
}

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{
}

// --
// declare
// --

let Supplement =
{

  sessionCreate : sessionCreate,
  sessionOpenOrCreate : sessionOpenOrCreate,
  sessionOpen : sessionOpen,
  sessionClose : sessionClose,
  sessionCloseSaving : sessionCloseSaving,
  sessionSave : sessionSave,

  //

  MustHave : MustHave,
  CouldHave : CouldHave,

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  supplement : Supplement,
  withMixin : true,
  withClass : true,
});

// --
// export
// --

_global_[ Self.name ] = _[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
