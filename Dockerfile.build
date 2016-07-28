FROM haskell:7.10.3
VOLUME /stack-root
VOLUME /artifacts
VOLUME /src
CMD stack install                  \
      --stack-root /stack-root     \
      --work-dir .stack-work-docker \
      --local-bin-path /artifacts  \
      --stack-yaml /src/stack.yaml \
      --allow-different-user