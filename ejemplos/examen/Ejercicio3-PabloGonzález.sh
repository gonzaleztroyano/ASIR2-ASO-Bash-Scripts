#!/usr/bin/env bash

cuenta_cpu=$(cat /proc/cpuinfo | grep "cpu cores" | grep -o -m 1 -e "[0-9]")
arquitectura=$(lscpu | grep "Arquitectura" )
arquitectura=${arquitectura:14:-1}
discos=$(df | grep "/dev/sd" | wc -l)
memoria_en_kb=$(cat /proc/meminfo  | grep "MemTotal" | grep -o -e "[0-9]*")
memoria_en_mb=$(($memoria_en_kb / 1024))
cuenta_pci=$(lspci | wc -l)
cuenta_usb=$(lsusb  | wc -l)

echo "${cuenta_cpu} discos, arquitectura ${arquitectura:14:-1}, ${discos} discos, $memoria_en_mb MB de RAM, $cuenta_pci puertos PCI, $cuenta_usb puertos USB"
 
