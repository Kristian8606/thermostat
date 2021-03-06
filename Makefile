PROGRAM = main

EXTRA_COMPONENTS = \
	extras/dht \
	extras/http-parser \
	extras/dhcpserver \
	extras/rboot-ota \
    $(abspath ../../external_libs/wolfssl) \
    $(abspath ../../external_libs/cJSON) \
    $(abspath ../../external_libs/homekit) \
    $(abspath ../../external_libs/wifi_config) \
	$(abspath ../../libs/led_codes) \
    $(abspath ../../libs/adv_button)

FLASH_SIZE = 8
FLASH_MODE = dout
FLASH_SPEED = 40

HOMEKIT_SPI_FLASH_BASE_ADDR = 0x8c000
HOMEKIT_MAX_CLIENTS = 16
HOMEKIT_SMALL = 0
HOMEKIT_OVERCLOCK = 1
HOMEKIT_OVERCLOCK_PAIR_SETUP = 1
HOMEKIT_OVERCLOCK_PAIR_VERIFY = 1

EXTRA_CFLAGS += -I../.. -DHOMEKIT_SHORT_APPLE_UUIDS -DWIFI_CONFIG_CONNECT_TIMEOUT=180000

## DEBUG
#EXTRA_CFLAGS += -DHOMEKIT_DEBUG=1

include $(abspath ../../sdk/esp-open-rtos/common.mk)

signature: 
	$(shell /usr/local/opt/openssl/bin/openssl   sha384 -binary -out firmware/main.bin.sig firmware/main.bin)
	$(shell printf "%08x" `cat firmware/main.bin | wc -c`| xxd -r -p >>firmware/main.bin.sig)

monitor:
	$(FILTEROUTPUT) --port $(ESPPORT) --baud 115200 --elf $(PROGRAM_OUT)
