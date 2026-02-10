# 0.0.7

## Changed

- Enum input now displays as a button that opens a searchable modal dialog instead of inline radio buttons

# 0.0.6

## Added

- Zoom controls with +/- buttons (25%-400% range)
- Pan/drag support for component preview via `InteractiveViewer`
- Center-based zoom that maintains viewport focus
- Reset button to restore default zoom and position
- Nullable parameter support for all input types (shows "null" option when `isNullable: true`)
- New input types: `UiPlaygroundDurationInput`

# 0.0.5

## Added

- New input types: `UiPlaygroundBorderRadiusInput`, `UiPlaygroundBorderRadiusGeometryInput`

# 0.0.3 - 0.0.4

## Changed

- README now includes badge links to related packages

# 0.0.2

## Added

- New input types: `UiPlaygroundEdgeInsetsInput`, `UiPlaygroundEdgeInsetsGeometryInput`, `UiPlaygroundImpaktfullUiAssetInput`, `UiPlaygroundWidgetInput`, `UiPlaygroundListInput`
- `valueOrDefault` and `valueOrDefaultRequired` getters on `UiPlaygroundInputItem`
- `defaultValue` getter on `UiPlaygroundInputItem` for providing fallback values
- Public `addListener` and `removeListener` methods on `UiPlaygroundInputItem`
- Responsive layout with drawer navigation for small screens

# 0.0.1

Initial pre-release.
