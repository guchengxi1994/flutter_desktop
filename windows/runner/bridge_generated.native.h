#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_get_changelogs(int64_t port_);

void wire_rust_bridge_say_hello(int64_t port_);

void wire_set_db_path(int64_t port_, struct wire_uint_8_list *s);

void wire_init_db(int64_t port_);

void wire_new_log(int64_t port_, struct wire_uint_8_list *content, struct wire_uint_8_list *result);

void wire_new_file(int64_t port_,
                   struct wire_uint_8_list *virtual_path,
                   struct wire_uint_8_list *real_path);

void wire_sys_info_stream(int64_t port_);

void wire_listen_sysinfo(int64_t port_, struct wire_uint_8_list *name);

void wire_set_json_path(int64_t port_, struct wire_uint_8_list *s);

void wire_set_cache_path(int64_t port_, struct wire_uint_8_list *s);

void wire_set_idiom_path(int64_t port_, struct wire_uint_8_list *s);

void wire_get_idioms(int64_t port_, uint64_t *count);

void wire_get_one_idiom(int64_t port_, uintptr_t index);

void wire_init_folder(int64_t port_, struct wire_uint_8_list *s);

void wire_create_new_txt(int64_t port_,
                         struct wire_uint_8_list *filename,
                         struct wire_uint_8_list *open_with,
                         int64_t *folder_id);

void wire_get_children_by_id(int64_t port_, int64_t *i);

void wire_new_practice(int64_t port_);

void wire_update_practice(int64_t port_, int64_t hit, int64_t index, int64_t row_id);

void wire_get_last_practice(int64_t port_);

void wire_delete_3_days_ago_history(int64_t port_);

void wire_new_browser_history(int64_t port_, struct wire_uint_8_list *s);

void wire_fetch_history(int64_t port_, int64_t page);

int64_t *new_box_autoadd_i64_0(int64_t value);

uint64_t *new_box_autoadd_u64_0(uint64_t value);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_get_changelogs);
    dummy_var ^= ((int64_t) (void*) wire_rust_bridge_say_hello);
    dummy_var ^= ((int64_t) (void*) wire_set_db_path);
    dummy_var ^= ((int64_t) (void*) wire_init_db);
    dummy_var ^= ((int64_t) (void*) wire_new_log);
    dummy_var ^= ((int64_t) (void*) wire_new_file);
    dummy_var ^= ((int64_t) (void*) wire_sys_info_stream);
    dummy_var ^= ((int64_t) (void*) wire_listen_sysinfo);
    dummy_var ^= ((int64_t) (void*) wire_set_json_path);
    dummy_var ^= ((int64_t) (void*) wire_set_cache_path);
    dummy_var ^= ((int64_t) (void*) wire_set_idiom_path);
    dummy_var ^= ((int64_t) (void*) wire_get_idioms);
    dummy_var ^= ((int64_t) (void*) wire_get_one_idiom);
    dummy_var ^= ((int64_t) (void*) wire_init_folder);
    dummy_var ^= ((int64_t) (void*) wire_create_new_txt);
    dummy_var ^= ((int64_t) (void*) wire_get_children_by_id);
    dummy_var ^= ((int64_t) (void*) wire_new_practice);
    dummy_var ^= ((int64_t) (void*) wire_update_practice);
    dummy_var ^= ((int64_t) (void*) wire_get_last_practice);
    dummy_var ^= ((int64_t) (void*) wire_delete_3_days_ago_history);
    dummy_var ^= ((int64_t) (void*) wire_new_browser_history);
    dummy_var ^= ((int64_t) (void*) wire_fetch_history);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_i64_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u64_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
