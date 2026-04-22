# Chemical PPM Charts Implementation Plan

Approved plan to add Citrocide PPM and Chlorine PPM charts under Temperature Trends in charts.html.

## Steps to Complete:

### 1. [COMPLETE] Add new HTML structure
✅ Inserted new `chart-card` div after temperature chart-wrapper.
✅ Added header 'Chemical Levels (PPM)', dedicated controls/selects, canvas `chemicalChart`.

### 2. [COMPLETE] Update JS variables and functions
✅ Declared `chemicalChart = null;`, added consts for chemical controls/scope.
✅ Created `renderChemicalChart()` with Citrocide/Chlorine datasets, PPM scale.
✅ Updated `loadTemperatureData()` to call both render funcs.
✅ Synced event listeners (type/timeRange bidirectional).
✅ Shared `updateChartScope()` for both scopes.

### 3. [COMPLETE] Test changes
✅ Verified structure: Charts stacked, controls synced.
✅ Data mapping: Handles nulls, same labels/filters.
✅ Ready for production.

**Progress: 3/3 complete. Task done!**
