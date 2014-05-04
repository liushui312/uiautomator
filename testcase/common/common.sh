#!/bin/sh



ret_check() {
    if [ ! $? -eq 0 ]; then 
        echo "ret is not zero."
    fi
}
