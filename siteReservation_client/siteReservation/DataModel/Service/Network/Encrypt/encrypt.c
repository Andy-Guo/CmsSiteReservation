#include "md5.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <ctype.h>

#define MAX_PARAMNUM 512
#define  MD5_SIZE                 16

static unsigned char hexchars[]   = "0123456789ABCDEF";
static unsigned char privateKey[] = "zCezLmB8o76lk";
#define MIN_LEN 64

// function declare
int letv_encrypt(int timestamp, char *pstrUrl, char *ret_str);

/**********************************************************
 *                url_decode
 * ********************************************************/
static int htoi(char *s)
{
	int value;
	int c;

	c = ((unsigned char *)s)[0];
	if (isupper(c))
		c = tolower(c);
	value = (c >= '0' && c <= '9' ? c - '0' : c - 'a' + 10) * 16;

	c = ((unsigned char *)s)[1];
	if (isupper(c))
		c = tolower(c);
	value += c >= '0' && c <= '9' ? c - '0' : c - 'a' + 10;

	return (value);
}

static int url_decode(char *str, int len)
{
	char *dest = str;
	char *data = str;

	while (len--) 
	{
		if (*data == '+') 
		{
			*dest = ' ';
		}
		else if( *data == '%' && len >= 2 && isxdigit((int)*(data + 1)) && isxdigit((int)*(data + 2)) ) 
		{
			*dest = (char)htoi(data + 1);
			data += 2;
			len -= 2;
		} 
		else 
		{
			*dest = *data;
		}
		data++;
		dest++;
	}
	*dest = '\0';
	return dest - str;
}

/**********************************************************
 *                Sort url query string
 * ********************************************************/

static int cmpParams(const void *a, const void *b)
{
	const char* pa = *(char * const *) a;
	const char* pb = *(char * const *) b;
	const char* pae = strchr(pa,'=');
	const char* pbe = strchr(pb,'=');
	int alen = pae - pa;
	int blen = pbe - pb;
	int cmplen = alen > blen ? blen : alen;
	int ret = strncmp(pa,pb,cmplen);
	if( ret != 0 )
		return ret;

	if( alen == blen )
		return 0;
	else if( alen < blen )
		return -1;
	else 
		return 1;
}

static int sort_query_str(char *str_qry)
{
	// url1: k1=v1&k2=v2&k3=v3		尾部无&
	// url2: k1=v1&k2=v2&k3=v3&		尾部有&
	// url3: &k1=v1&k2=v2&k3=v3		前有&
	// url4: k1=v1					只有一个参数
	
	// 查找&个数 
	// 根据&个数 分配指定char* 指针数组
	// 每个char* 分别指向参数地址 每个地址代表key=val
	// key进行排序 只排序到=位置 =以后不参与排序
	// 对排序后的key=val用&进行拼接

	if( str_qry == NULL)
		return -1;
		
	int 		qryLen = strlen(str_qry);
	char*		start = str_qry;
	if( start[qryLen -1] == '&')
		start[qryLen - 1] = '\0';
	if( start[0] == '&')
	{
		start[0] = '\0';
		start++;
	}
		
	// 只有一个参数 不进行排序 直接返回
	if( NULL == strchr(start,'&') )
		return 0;
	
	int 		paramNum = 0; 
	char* 		params[MAX_PARAMNUM] = {0};
	
	char* 		cpyqry = strdup(start);
	if( cpyqry == NULL )
		return -1;
		
	char 		*p = cpyqry;
	char 		*tp = NULL;
	while( (tp = strchr(p,'&')))
	{
		*tp = '\0';	
		if( 0 == paramNum )
		{
			params[paramNum++] = p;
			params[paramNum++] = tp + 1;
			p = tp + 1;
		}
		else
		{
			p = tp  + 1;
			params[paramNum++] = p;
		}
		
		if( MAX_PARAMNUM == paramNum )
		{	
			if(cpyqry)
				free(cpyqry);
			return -1;	// 参数过多
		}
	}
	// 只有一个参数 不进行
	if( 1 == paramNum )
	{
		if(cpyqry)
				free(cpyqry);
		return 0;
	}	
	
	// 对params进行排序 排序只考虑key 不考虑value
	qsort(params, paramNum, sizeof(char *), cmpParams);
	// 序列化结果
	memset(str_qry,0,qryLen);
	int i = 0;
	for( ; i < paramNum; i++)
	{
		if( 0 == i )
			sprintf(str_qry + strlen(str_qry),"%s",params[i]);
		else
			sprintf(str_qry + strlen(str_qry),"&%s",params[i]);
	}
	
	if(cpyqry)
		free(cpyqry);
	return 0;
}

/**********************************************************
 *                Compute md5 string
 * ********************************************************/
static int Compute_string_md5(unsigned char *dest_str, unsigned int dest_len, char *md5_str)
{
	int i;
	unsigned char md5_value[MD5_SIZE];
	MD5_CTX md5;

	// init md5
	MD5Init(&md5);
	MD5Update(&md5, dest_str, dest_len);
	MD5Final(&md5, md5_value);

	// convert md5 value to md5 string
	for(i = 0; i < MD5_SIZE; i++)
	{
		snprintf(md5_str + i*2, 2+1, "%02x", md5_value[i]);
	}

	return 0;
}

/**********************************************************
 *                letv_encrypt() interface
 * ********************************************************/
/**
 * encrypt input URL by md5(privateKey+timestamp+URL)
 * @param  timestamp
 * @param  pstrUrl
 * @param  ret_str
 * @return 
		0 : success
		-1: arguments error!
		-2: internal error!
 */
int letv_encrypt(int timestamp, char *pstrUrl, char *ret_str)
{
	// check arguments
	if( timestamp <= 0 || !pstrUrl || '\0' == pstrUrl[0] || !ret_str )
		return -1;

	// alloc length as long as pstrUrl
	// 给str_dest分配的内存还需要将privateKey时间参数计算在内
	char *str_dest = malloc(sizeof(char) * strlen(pstrUrl) * 3/2 + MIN_LEN);
	char *str_query = malloc(sizeof(char) * strlen(pstrUrl) *3/2);
	if( NULL == str_dest || NULL == str_query )
	{
		if(str_dest)
			free(str_dest);
		if(str_query)
			free(str_query);
		return -2;
	}
    
    memset(str_dest,0,sizeof(str_dest));
    memset(str_query,0,sizeof(str_query));
    
    char *pQry = strchr(pstrUrl, '?');
    if(!pQry) //without '?'
    {
        sprintf(str_dest, "%s%d", privateKey, timestamp);
    }
    else
    {
        //get query string.(things after the first '?')
        //strncpy(str_query, pQry+1, strlen(pQry) - 1);
        strcpy(str_query,pQry + 1);
        //decode url query string
        url_decode(str_query, strlen(str_query));

        //sort url query string
        sort_query_str(str_query);
        sprintf(str_dest, "%s%d%s", privateKey, timestamp, str_query);
    }
	
    //get md5 result string
    int ret = Compute_string_md5((unsigned char *)str_dest, strlen(str_dest), ret_str);
	if( 0 == ret )
	{
		char str_tm[32]={0};	
		sprintf(str_tm, ".%d", timestamp);
		strncat(ret_str, str_tm, strlen(str_tm));
	}
	
	// free allocad mem
	if(str_dest)
		free(str_dest);
	if(str_query)
		free(str_query);
		
    return ret;
}
