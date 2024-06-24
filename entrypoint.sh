#!/bin/sh

# Startup Xvfb
Xvfb -ac :99 -screen 0 1280x1024x16 > /dev/null 2>&1 &

# Export some variables
export DISPLAY=:99.0
export PUPPETEER_EXEC_PATH="/usr/bin/google-chrome-stable"


cd integration-tests
# Run commands
cmd=$@
echo "Running '$cmd'!"
if $cmd; then
    # no op
    echo "Successfully ran '$cmd'"
else
    exit_code=$?
    echo "Failure running '$cmd', exited with $exit_code"
    echo ''
    echo 'BREAKING CHANGE !!!'
    echo 'We introduced a breaking change with the args field.'
    echo 'You might just need to change `args: test` to `args: npm test`.'
    echo 'For more details check out https://github.com/mujo-code/puppeteer-headful/pull/9'
    exit $exit_code
fi
