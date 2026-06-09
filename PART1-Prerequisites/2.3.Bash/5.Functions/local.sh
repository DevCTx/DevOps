#!/bin/bash

counter=100

with_workaround() {
    local global_backup=$counter  # Save global BEFORE declaring local
    local counter=5
    
    echo "Local: $counter"
    echo "Global (shadowed): $counter"  # Still prints 5, not 100!
    echo "Global (saved): $global_backup"
}

with_workaround
