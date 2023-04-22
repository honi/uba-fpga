# Diseño de sistemas digitales con FPGA

Ciencias de la Computación - FCEN - UBA\
1er cuatrimestre 2023

## Índice

- Talleres

    - [Dimmer](talleres/dimmer)
    - [Stopwatch](talleres/stopwatch)

## FPGA

[Digilent Zybo Z7-20](https://digilent.com/reference/programmable-logic/zybo-z7/start)

## Herramientas

- [GHDL](http://ghdl.free.fr): simulador de VHDL
- [GTKWave](https://gtkwave.sourceforge.net): visualizador de señales
- [GTKWave + macOS](https://ughe.github.io/2018/11/06/gtkwave-osx): cómo arreglar la ejecución de GTKWave desde la terminal en macOS
- [Vivado](https://www.xilinx.com/support/download.html): toolchain completo de Xilinx

## Xilinx / Vivado

En Ubuntu 22.04 LTS, instalá la siguiente librería antes de correr el instalador de Xilinx (en mi caso fue necesario después de un clean install de Ubuntu).

```bash
sudo apt install libncurses5
```

Luego el instalador "Xilinx Unified Installer 2022.2: Linux Self Extracting Web Installer" debería funcionar correctamente.

Para poder conectarse a la FPGA Zybo Z7-20 fue necesario instalar el siguiente driver (*nota: debería rechequear esto con un clean install*).

```bash
# Yo instalé Vivado en `/opt/Xilinx`, ajustá acorde a tu config.
cd /opt/Xilinx/Vivado/2022.2/data/xicom/cable_drivers/lin64/install_script/install_drivers
sudo ./install_drivers
```
