## 5.7.0 (June 2018) -- rpclib only
- Add optional `strict` parameter to `jsonrpc.of_string` to ignore trailing
  junk from input. The old behaviour (`strict=true`) is the default.

## 5.6.0 (June 2018) --
* rpclib, rpclib-async, rpclib-ppx:
  - Remove duplication in .mlis, expose MarshalError, add docs
* README
  - Document IDL generator
* rpclib:
  - pythongen test: make pylint checks stricter

## 5.5.0 (June 2018) -- rpclib only
- pythongen:
  - Correctly call superclass init in exceptions
  - Generate classes for errors in interface
  - Fix tuple typechecking

## 5.4.0 (June 2018)
* ppx_deriving_rpc:
  - rpcty ppx: Fix warning 27 in generated field setter
* rpclib:
  - pythongen:
    - Fix Python argparse CLI
    - Fix generated <interface>_test class to pass typechecking
    - Add tests using CLI

## 5.3.0 (May 2018)
* ppx_deriving_rpc:
  - rpcty ppx: Avoid warning 23: "with clause is useless"
* rpclib:
  - markdowngen:
    - document params with same types but different defs
    - escape special HTML and markdown chars

## 5.2.0 (May 2018) -- rpclib only
- markdowngen: document nested variants and structs
- rpc: remove rpclib-html from compat layer

## 5.1.0 (May 2018)
- Lint generated Python code in unit test
- Reorganize tests & convert to alcotest
- markdowngen: show content of structs and variants in the documentation
- drop support for ocaml 4.03.0
- pythongen: generate pythonic code that passes linting
- pythongen: introduce an optional helpers field to inject custom versions of helpers
- pythongen: use a dictionary lookup for the dispatchers
- pythongen: display method description for methods

## 5.0.0 (May 2018)
* camlp4: delete as it is moved in ocaml-rpc-legacy
* port to jbuilder, and splut the library into
  - ppx_deriving_rpc
	- rpc (compatibility meta-package)
	- rpclib-async
	- rpclib-html
	- rpclib-js
	- rpclib-lwt
	- rpclib

## 4.2.0 (May 2018)
* idl: support unnamed parameters in Lwt and Async GenClient & GenServer
* Lwt, Async GenClient: use correct RPC call wire name
* Make sure fns are added with correct name in GenServer
* Add client<->server interop test for IDL

## 4.1.0 (Apr 2018)
* rpc_lwt: runtime check if all server as been bound to a function
* rpc_async: runtime check if all server as been bound to a function
* Avoid stack overflow due to List.map in Jsonrpc, Rpcmarshal, ppx

## 4.0.0 (Apr 2018)
* idl.ml: Change marshalling of named optional arguments to exclude them from the argument record
* pythongen.ml: Fix type checking for optional record fields

## 3.2.0 (Mar 2018)
* idl.ml: make server check for completeness of the implementation
* idl.mli: hide details of server impl
* Add a space to store test data in an abstract type
* Add the type name to the ppx-generated variant value
* Improve the markdown documentation generator.
* idl: enforce use of 'internal_error_of' in Error.Make

## 3.1.0 (Feb 2018)
* ppx_deriving_rpcty: use native split_on_char on ocaml >= 4.04.0
* ppx_deriving_rpcty: Fix 'Warning 27: unused variable x.' on deriving rpcty for structs

## 3.0.0 (Jan 2018)
* lib: remove use of cppo after dropping support for ocaml 4.02.3
* add support for async and core >= v0.9.0

## 2.3.0 (Jan 2018)
* For tuple contains more than 2 elements, fix the element order when deriving rpcty
* pythongen, rpc_genfake: improved failures for Abstract types
* cmdlinergen: implement Abstract
* add support for ocaml 4.06
* Remove unnecessary warnings
* Add failable tests for ocaml-4.06
* opam: add upper bound to async
* opam: remove [configure] from the build stanza

## 2.2.0 (Dec 2017)
* Remove warnings by extending pattern matches in {cmdliner,markdown}gen
* Redefined `to_a` with a safer interface
* Add a way to explicitly mark a tuple list as a dict
* Allow the use ocamldoc tags rather than [@doc ...]
* Add an 'abstract' typ.
* Deprecate xmlrpc from/to char producers
* Deprecate jsonrpc from/to char producers
* Port the jsonrpc module to yojson
    
## 2.1.0 (Sep 2017)
* Add defaults for polymorphic variants (@jonludlam)

## 2.0.0 (Aug 2017)
* Fix some cases of non-compliance with the JsonRpc v2.0 specs (@kc284)
* Check the structure of error objects of JsonRpc v2.0 is spec compliant (@kc284)
* Add new function to retrieve the version and id of JSON-RPC alongside the Rpc.call from the request body (@kc284)
    
## 1.9.53 (Jul 2017)
* Delay evaluation of Cmdlinergen terms (API breaking change) (@jonludlam)
* Accept marshalled ints when unmarshalling floats (@johnelse)

## 1.9.52 (Jun 2017)
* Fix compilation on MacOS X (@djs55)
* Add a ClientExnRpc functor that takes an RPC impl as argument (@jonludlam)
* ppx_deriving_rpc: Fix marshalling of dictionaries in the rpcty code too (@jonludlam)
* ppx_deriving_rpc: Allow unnamed parameters in functions to introduce compatibility with the old camlp4 idl (@jonludlam)

## 1.9.51 (May 2017)
* Support Ocaml 4.03+ (@mseri)
* Fixed javascript and htmlgen backends (@mseri)

## 1.9.50 (Mar 2017)
* Add a ppx to replace 'with rpc'
* Add a new mechanism for defining IDLs (inspired by ctypes), to replace
  the 'idl' syntax extension

## 1.6.0 (July 2016)
* Add support for JSON-RPC v2

## 1.5.4 (June 2015)
* Fix struct_extend handling of option types (with test)
* Add opam file for development
* Add travis

## 1.5.3 (Nov 2014)
* Add a mechanism for performing upgrade

## 1.5.2 (June 2014)
* Change license to ISC

## 1.5.1 (May 2014)
* make js_of_ocaml dependency optional (@djs55)

## 1.5.0 (Oct 2013)
* Abstract interface over Async and Lwt (@jonludlam)
* Remove some debug messages (@djs55)

## 1.4.1 (May 2013)
* Add support for using the browser's JSON parser (@jonludlam)

## 1.3.0 (Jan 2013)
* Add support for Int32 (@jonludlam)
* Make unmarshalling of variant types case insensitive (@jonludlam)
* Make Xmlrpc and Jsonrpc interface look more alike (@jonludlam)
* Support for recursive types in the IDL (@jonludlam)
* Improve installation instructions (Daniel Weil)