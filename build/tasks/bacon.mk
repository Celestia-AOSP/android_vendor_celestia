# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# Lineage OTA update package

LINEAGE_TARGET_PACKAGE := $(PRODUCT_OUT)/$(LINEAGE_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

CL_BLD="\033[1m"
CL_RED="\033[31m"
CL_GRN="\033[32m"
CL_RST="\033[0m"
CL_PURB := \033[1;35m

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv -f $(INTERNAL_OTA_PACKAGE_TARGET) $(LINEAGE_TARGET_PACKAGE)
	$(hide) $(SHA256) $(LINEAGE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/lineage/build/tools/createjson.sh $(TARGET_DEVICE) $(PRODUCT_OUT) $(LINEAGE_VERSION).zip
	$(hide) rm -rf $(call intermediates-dir-for,PACKAGING,target_files)

	@echo -e ""
	@echo -e ""
	@echo -e "${CL_PURB} ▄████▄  ▓█████  ██▓    ▓█████   ██████ ▄▄▄█████▓ ██▓ ▄▄▄      ▄▄▄       ▒█████    ██████  ██▓███  ${CL_PURB}"
	@echo -e "${CL_PURB}▒██▀ ▀█  ▓█   ▀ ▓██▒    ▓█   ▀ ▒██    ▒ ▓  ██▒ ▓▒▓██▒▒████▄   ▒████▄    ▒██▒  ██▒▒██    ▒ ▓██░  ██▒${CL_PURB}"
	@echo -e "${CL_PURB}▒▓█    ▄ ▒███   ▒██░    ▒███   ░ ▓██▄   ▒ ▓██░ ▒░▒██▒▒██  ▀█▄ ▒██  ▀█▄  ▒██░  ██▒░ ▓██▄   ▓██░ ██▓▒${CL_PURB}"
	@echo -e "${CL_PURB}▒▓▓▄ ▄██▒▒▓█  ▄ ▒██░    ▒▓█  ▄   ▒   ██▒░ ▓██▓ ░ ░██░░██▄▄▄▄██░██▄▄▄▄██ ▒██   ██░  ▒   ██▒▒██▄█▓▒ ▒${CL_PURB}"
	@echo -e "${CL_PURB}▒ ▓███▀ ░░▒████▒░██████▒░▒████▒▒██████▒▒  ▒██▒ ░ ░██░ ▓█   ▓██▒▓█   ▓██▒░ ████▓▒░▒██████▒▒▒██▒ ░  ░${CL_PURB}"
	@echo -e "${CL_PURB}░ ░▒ ▒  ░░░ ▒░ ░░ ▒░▓  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░  ▒ ░░   ░▓   ▒▒   ▓▒█░▒▒   ▓▒█░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░▒▓▒░ ░  ░${CL_PURB}"
	@echo -e "${CL_PURB}  ░  ▒    ░ ░  ░░ ░ ▒  ░ ░ ░  ░░ ░▒  ░ ░    ░     ▒ ░  ▒   ▒▒ ░ ▒   ▒▒ ░  ░ ▒ ▒░ ░ ░▒  ░ ░░▒ ░     ${CL_PURB}"
	@echo -e "${CL_PURB}░           ░     ░ ░      ░   ░  ░  ░    ░       ▒ ░  ░   ▒    ░   ▒   ░ ░ ░ ▒  ░  ░  ░  ░░       ${CL_PURB}"
	@echo -e "${CL_PURB}░ ░         ░  ░    ░  ░   ░  ░      ░            ░        ░  ░     ░  ░    ░ ░        ░           ${CL_PURB}"
	@echo -e ${CL_BLD}${CL_RED}"===============================-Package complete-==============================="${CL_RED}
	@echo -e ${CL_BLD}${CL_GRN}"Zip: "${CL_RED} $(LINEAGE_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_BLD}${CL_GRN}"SHA256: "${CL_RED}" `cat $(LINEAGE_TARGET_PACKAGE).sha256sum | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_GRN}"Size:"${CL_RED}" `du -sh $(LINEAGE_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_GRN}"TimeStamp:"${CL_RED}" `cat $(PRODUCT_OUT)/system/build.prop | grep ro.system.build.date | cut -d'=' -f2 | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_GRN}"Integer Value:"${CL_RED}" `wc -c $(LINEAGE_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_RED}"================================================================================"${CL_RED}
