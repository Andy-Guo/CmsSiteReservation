#ifndef _LE_MD5_H
#define _LE_MD5_H

#define MD5PUB_API    __attribute__ ((visibility("default")))

MD5PUB_API int letv_encrypt(int timestamp, char *pstrIn, char *ret_str);

#endif
