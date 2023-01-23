## NOTE 

- Realsense only works on USB 3.0 port. To check USB port version:
```
>> lsusb
Bus 004 Device 002: ID 8086:0b07 Intel Corp. RealSense D435
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 005: ID 187c:0550 Alienware Corporation LED controller
Bus 003 Device 004: ID 0c45:6738 Microdia Integrated_Webcam_HD
Bus 003 Device 011: ID 04b4:0101 Cypress Semiconductor Corp. Keyboard/Hub
Bus 003 Device 006: ID 8087:0026 Intel Corp. AX201 Bluetooth
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

>> lsusb -D /dev/bus/usb/004/002 | grep "bcdUSB"
  bcdUSB               3.20
```
