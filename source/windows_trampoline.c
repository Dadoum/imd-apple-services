//
// Created by dadoum on 30/05/23.
//

typedef int (__attribute__((sysv_abi)) *NACInit_t)(const void* cert_bytes, int cert_len, void** out_validation_ctx, void **out_request_bytes, int *out_request_len);
typedef int (__attribute__((sysv_abi)) *NACKeyEstablishment_t)(void* validation_ctx, void* response_bytes, int response_len);
typedef int (__attribute__((sysv_abi)) *NACSign_t)(void* validation_ctx, void* unk_bytes, int unk_len, void** validation_data, int* validation_data_len);
typedef int (__attribute__((sysv_abi)) *NACFree_t)(void *ptr);
typedef int (__attribute__((sysv_abi)) *NACCleanup_t)(void *ptr);

int NACInit(NACInit_t func, const void* cert_bytes, int cert_len, void** out_validation_ctx, void **out_request_bytes, int *out_request_len) {
    return func(cert_bytes, cert_len, out_validation_ctx, out_request_bytes, out_request_len);
}

int NACKeyEstablishment(NACKeyEstablishment_t func, void* validation_ctx, void* response_bytes, int response_len) {
    return func(validation_ctx, response_bytes, response_len);
}

int NACSign(NACSign_t func, void* validation_ctx, void* unk_bytes, int unk_len, void** validation_data, int* validation_data_len) {
    return func(validation_ctx, unk_bytes, unk_len, validation_data, validation_data_len);
}

int NACFree(NACFree_t func, void *ptr) {
    return func(ptr);
}

int NACCleanup(NACCleanup_t func, void *ptr) {
    return func(ptr);
}

