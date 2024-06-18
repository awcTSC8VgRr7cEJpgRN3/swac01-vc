# Switch AC OFF/ON

###### Control AC devices using ~~a~~ Programmable Logic Device.

## Modules

> Regarding the hardware limitations of CPLD, see `git log`.

### Main Module

- ~~`swac01`~~: Fully modular ~~power supply~~ structure, not used.
- `swac02`: Semi modular ~~power supply~~ structure for hardware optimization.

### Sub-Modules

- `clock`: The outputs should be fed to `display5461AS1`.
- `dec27segs`
- `display5461AS1`
- ~~`hex27segs`~~: Try hardware optimization, use `dec27segs` instead.
- ~~`keypad3c4r`~~: Coupled with Main Module, not used.
- ~~`num2decs`~~

### Nerf-Modules

> Bad arithmetic limited by hardware tbh.