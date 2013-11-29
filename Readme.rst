=====================
JS-Webapp-BoilerPlate
=====================
Boiler plate that intend to use npm to manage back-end and front-end dependancies with npm and requirejs.
To do so, a simple express controller catch app.get("/npm/:script([a-zA-Z1-9-.]+).js") and will use
require.resolve(:script) to find the "main" script path and finally return it to the client.

This controller will only be used in a development environment.
In production, user will be able to optimize all sources in one script using r.js.


Installation
-------------

.. code-block:: bash

  npm install
  make


**Start server:**

.. code-block:: bash

  make server

Then, access the app via: `http://localhost:8080`_


**Optimize (not ready yet, require further devs):**

.. code-block:: bash

  sh make install


Todo list
---------

- optimize with r.js
- ask vendor lib authors to maintain a browser version of their lib


**Ideas:**

This express controller could be move in a different git repository as a simple dev-plugin.

.. _http://localhost:8080: http://localhost:8080
