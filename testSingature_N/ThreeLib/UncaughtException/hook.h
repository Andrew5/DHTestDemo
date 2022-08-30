#ifndef dhkit_hook
#define dhkit_hook

#include "common.h"
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
#define EXTERN_C_START
extern "C"
{
#define EXTERN_C_END }
#else
#define EXTERN_C_START
#define EXTERN_C_END
#endif

EXTERN_C_START

struct DKRebinding {
    const char *name;
    void *replacement;
    uintptr_t *replaced;
};

DHKIT_EXPORT bool DKRebindSymbols(struct DKRebinding rebinding[], size_t length);

EXTERN_C_END

#endif
