# openwhisk-wrapper: Haskell-based OpenWhisk services

## Provides:
- A library which wraps functions as OpenWhisk services (based on dockerSkeleton).

- An example using split docker images:
    * Build phase: based on `haskell:7.10.3` image
    * Deploy phase: uses `haskell-scratch` image

## Usage:
1. Write the logic of your service, which should be a function with type `Value -> Value`

    ```
    myService :: Value -> Value -- consumes and produces JSON objects
    myService = id -- service logic, e.g. this echoes input data
    ```

2. Wrap your service with `openwhiskWrapper` function (see `Network.OpenWhisk` module)

    ```
    main :: IO ()
    main = openwhiskWrapper myService
    ```

3. Create docker image (see `Dockerfile` and `make-image.sh` script) 

4. Upload the image to docker hub

5. Use `wsk` utility in order to instantiate an action with your image.

    ```bash
    wsk action update --docker action-name docker-hub-user/docker-hub-image
    ```

