EXTENSION = pg_proctab
EXTVERSION := $(shell grep default_version $(EXTENSION).control | \
		sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DATA := $(filter-out $(wildcard sql/*--*.sql),$(wildcard sql/*.sql),$(wildcard contrib/*.sql))
DOCS := $(wildcard doc/*)
MODULES := $(patsubst %.c,%,$(wildcard src/*.c))
SCRIPTS := $(wildcard contrib/*.sh) $(wildcard contrib/*.pl)
PG_CONFIG = pg_config

all: sql/$(EXTENSION)--$(EXTVERSION).sql

sql/$(EXTENSION)--$(EXTVERSION).sql: sql/$(EXTENSION).sql
	cp $< $@

DATA = $(wildcard sql/*--*.sql)
EXTRA_CLEAN = sql/$(EXTENSION)--$(EXTVERSION).sql

# Determine the database version in order to build with the right queries.

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
