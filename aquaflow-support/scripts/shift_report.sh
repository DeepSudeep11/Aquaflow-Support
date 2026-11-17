#!/bin/bash

if [ ! -f data/measurements.csv ]; then
    echo "ERROR: measurements.csv not found"
    exit 1
fi

REPORT="reports/shift_report.txt"

echo "AquaFlow Shift Report" > "$REPORT"
echo "Generated: $(date)" >> "$REPORT"
echo "" >> "$REPORT"

echo "Readings Below 2.0 bar:" >> "$REPORT"
awk -F, 'NR>1 && $3<2.0' data/measurements.csv >> "$REPORT"
echo "" >> "$REPORT"

echo "ALERT Count:" >> "$REPORT"
awk -F, 'NR>1 && $5=="ALERT" {count++} END {print count+0}' data/measurements.csv >> "$REPORT"
echo "" >> "$REPORT"

echo "WARN Count:" >> "$REPORT"
awk -F, 'NR>1 && $5=="WARN" {count++} END {print count+0}' data/measurements.csv >> "$REPORT"
echo "" >> "$REPORT"

echo "Received Log Messages:" >> "$REPORT"
wc -l < log/sensor.log >> "$REPORT"
echo "" >> "$REPORT"

echo "Project Disk Usage:" >> "$REPORT"
du -sh . >> "$REPORT"

echo "Shift report generated successfully."
exit 0
