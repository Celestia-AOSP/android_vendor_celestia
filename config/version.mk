PRODUCT_VERSION_MAJOR = 13
PRODUCT_VERSION_MINOR = 0

# Increase CR Version with each major release.
CELESTIA_VERSION := 1.0

# Codename Package
CELESTIA_CODENAME := Cosmic

# Celestia Versioning
CELESTIA_MAINTAINER ?= UNKNOWN
CELESTIA_MAINTAINER_LINK ?= UNKNOWN
CELESTIA_BUILD_TYPE ?= UNOFFICIAL

# OFFICIAL_DEVICES
ifeq ($(CELESTIA_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/lineage/celestia.devices)
    ifeq ($(filter $(LINEAGE_BUILD), $(LIST)), $(LINEAGE_BUILD))
      IS_OFFICIAL=true
      CELESTIA_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      CELESTIA_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(LINEAGE_BUILD)")
    endif
endif

# Internal version
LINEAGE_VERSION := CelestiaAOSP-v$(CELESTIA_VERSION)-$(CELESTIA_CODENAME)-$(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)-$(shell date +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := CelestiaAOSP-v$(CELESTIA_VERSION)-$(CELESTIA_CODENAME)-$(PRODUCT_VERSION_MAJOR)-$(LINEAGE_BUILD)-$(CELESTIA_BUILD_TYPE)

# System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.celestia.maintainer=$(CELESTIA_MAINTAINER) \
  ro.celestia.maintainer_link=$(CELESTIA_MAINTAINER_LINK)
