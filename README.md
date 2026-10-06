# Low-Cost IEEE 802.15.4 / Zigbee Sniffer for ProMicro nRF52840

A low-cost IEEE 802.15.4 packet sniffer based on the inexpensive **ProMicro nRF52840** board.

The firmware is compatible with Nordic Semiconductor's **nRF Sniffer for 802.15.4** extcap utility, so the board appears directly as a capture interface in **Wireshark**. No TI CC2531 dongle and no separate capture helper are required.

This project is based on the Nordic Semiconductor `802154_sniffer` sample and adds a ProMicro nRF52840 board configuration, USB identification compatible with the Nordic extcap utility, and a simple UF2 bootloader build mode.

## Tested Environment

The project is currently developed and tested with:

- **nRF Connect SDK v3.4.0**
- **Zephyr 4.4**
- **nRF Sniffer for 802.15.4 v0.8.0**
- **Wireshark** on Windows
- ProMicro nRF52840 / Nice!Nano-compatible board with the resident nRF52 UF2 bootloader

Other nRF Connect SDK versions have not been verified.

## What You Need

- ProMicro nRF52840 board
- USB cable
- nRF Connect SDK v3.4.0
- Wireshark
- Nordic Semiconductor nRF Sniffer for 802.15.4:
  https://github.com/NordicSemiconductor/nRF-Sniffer-for-802.15.4

The ProMicro nRF52840 boards used for this project are inexpensive and are commonly sold as Nice!Nano-compatible boards.

## Board Target

Use:

```text
promicro_nrf52840_my/nrf52840
```

The project contains the board definition under `boards/`.

## Build

A pristine build is recommended whenever switching between SWD and UF2 modes.

### SWD / J-Link build

Make sure there is **no `uf2.conf` in the project root**, then build:

```bash
west build -b promicro_nrf52840_my/nrf52840 --sysbuild -p always .
```

The application is linked from flash address `0x0000`.

This mode is intended for direct SWD/J-Link flashing and debugging.

### UF2 bootloader build

The repository contains:

```text
uf2/uf2.conf
```

Copy it to the project root:

```text
uf2/uf2.conf -> uf2.conf
```

Then perform a pristine build:

```bash
west build -b promicro_nrf52840_my/nrf52840 --sysbuild -p always .
```

The root `uf2.conf` enables:

```conf
CONFIG_USE_DT_CODE_PARTITION=n
CONFIG_FLASH_LOAD_OFFSET=0x1000
CONFIG_BUILD_OUTPUT_UF2=y
```

This links the application at `0x1000`, preserving the resident bootloader at the beginning of flash, and enables Zephyr's built-in UF2 generator.

With the sysbuild layout used by this sample, the generated firmware is located at:

```text
build/802154_sniffer/zephyr/zephyr.uf2
```

Before flashing after any memory-layout change, verify that the application image starts at `0x1000`.

### Returning to SWD mode

Delete the root `uf2.conf` and perform another pristine build.

The template remains in `uf2/uf2.conf`.

## Flashing UF2

1. Short **RST** to **GND** twice quickly.
2. The board enters the resident bootloader.
3. A USB mass-storage device such as **Nice! Nano** appears.
4. Copy `zephyr.uf2` to the drive.
5. The board reboots automatically.

## Wireshark Integration

The firmware uses the same USB VID/PID expected by Nordic's 802.15.4 extcap utility:

```text
VID: 0x1915
PID: 0x154B
```

The serial output format is also compatible with the Nordic sniffer script.

### Windows setup

1. Install Wireshark.
2. Clone or download:
   https://github.com/NordicSemiconductor/nRF-Sniffer-for-802.15.4
3. Install PySerial if needed:

   ```bash
   python -m pip install pyserial
   ```

4. In Wireshark, open **Help -> About Wireshark -> Folders** and locate the **Personal Extcap path**.
5. Copy the Nordic extcap files, including `nrf802154_sniffer.py` and the Windows `.bat` wrapper, into that directory.
6. Restart Wireshark.
7. Connect the ProMicro nRF52840 sniffer.

The board should appear as an **nRF Sniffer for 802.15.4** capture interface.

The extcap interface can change the IEEE 802.15.4 channel directly from Wireshark.

For Zigbee decryption, configure the Zigbee network key in Wireshark's Zigbee protocol preferences.

## Serial Protocol

The firmware also works as a simple serial sniffer without Wireshark.

Supported commands:

```text
channel <11..26>
receive
sleep
```

Example:

```text
channel 23
receive
```

Captured packets are printed as:

```text
received: <hex PSDU> power: <dBm> lqi: <lqi> time: <timestamp>
```

Example:

```text
received: 49a85d41a5fffff4110f10270000369756e65619d09428a04b301951821db234460aa5ec4ff506631ef8adb22674683700 power: -39 lqi: 220 time: 15822687
```

## Why This Project Exists

A traditional low-cost Zigbee sniffing setup often uses a CC2531 dongle together with separate capture software.

With this project the ProMicro nRF52840 board behaves like the Nordic 802.15.4 sniffer and integrates directly with Wireshark through extcap.

The result is a compact and inexpensive IEEE 802.15.4 / Zigbee sniffer using currently supported nRF Connect SDK tooling.

## Notes

- IEEE 802.15.4 channels 11 through 26 are supported.
- Zigbee decryption requires the correct network key.
- The current build and UF2 workflow has been verified with nRF Connect SDK v3.4.0.
- If another board, bootloader, or SDK version is used, verify the flash layout before flashing.
