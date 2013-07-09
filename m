From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: [Babeltrace PATCH 05/23] Add MinGW implementations
	of mmap and	munmap
Date: Tue, 9 Jul 2013 14:26:12 +0000
Message-ID: <009B25148989C6458484484699278506E5384C5F__31642.0139316053$1373380022$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <009B25148989C6458484484699278506E5382F01@EU-MBX-01.mgc.mentorg.com>,
	<20130708142641.GF22703@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UwYs2-0000VD-Fi
	for lttng-dev@lists.lttng.org; Tue, 09 Jul 2013 10:26:22 -0400
In-Reply-To: <20130708142641.GF22703@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Mathieu,
thank you for your comments.
I am currently indisposed and cannot take immediate action about these patc=
hes.
It might take a while before I can submit a new set.

Thank you nonetheless. I try to comply with the coding style in the future.

Cheers,
JP
________________________________________
From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
Sent: Monday, July 08, 2013 5:26 PM
To: Ikaheimonen, JP
Cc: J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com); lttng-dev@lists=
.lttng.org
Subject: Re: [Babeltrace PATCH 05/23] Add MinGW implementations of mmap and=
     munmap

I'm stopping merging of the patch series at this patch, since it clearly
does not follow our coding style and still needs a lot of work. I expect
that the following patches either have the same needs, or have
dependencies on this one (e.g. for makefiles), so I'm not pulling them.
Please resubmit after following the advices inlined below:

* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> Add MinGW implementations of mmap, munmap and PAGE_SIZE.
> Add file include/babeltrace/compat/mman.h which in turn indirectly
> includes sys/mman.h in systems that have that file.
> Use babeltrace/compat/mman.h instead of sys/mman.h .
> ---
>  compat/Makefile.am                  |   2 +-
>  compat/compat_mman.c                | 138 ++++++++++++++++++++++++++++++=
++++++
>  converter/babeltrace-log.c          |   2 +-
>  formats/bt-dummy/bt-dummy.c         |   2 +-
>  formats/ctf-metadata/ctf-metadata.c |   2 +-
>  formats/ctf-text/ctf-text.c         |   2 +-
>  formats/ctf/ctf.c                   |   2 +-
>  include/babeltrace/align.h          |   6 ++
>  include/babeltrace/compat/mman.h    |  24 +++++++
>  include/babeltrace/ctf-text/types.h |   2 +-
>  include/babeltrace/mmap-align.h     |   2 +-
>  11 files changed, 176 insertions(+), 8 deletions(-)
>  create mode 100644 compat/compat_mman.c
>  create mode 100644 include/babeltrace/compat/mman.h
>
> diff --git a/compat/Makefile.am b/compat/Makefile.am
> index 79be1c8..00a7e02 100644
> --- a/compat/Makefile.am
> +++ b/compat/Makefile.am
> @@ -8,5 +8,5 @@ libcompat_la_LDFLAGS =3D \
>       -Wl,--no-as-needed
>
>  if BABELTRACE_BUILD_WITH_MINGW
> -libcompat_la_SOURCES +=3D compat_uuid.c
> +libcompat_la_SOURCES +=3D compat_mman.c compat_uuid.c
>  endif
> diff --git a/compat/compat_mman.c b/compat/compat_mman.c
> new file mode 100644
> index 0000000..5618deb
> --- /dev/null
> +++ b/compat/compat_mman.c

I think this file should be called compat_mman_mingw32.c

The file header is missing (comment about license, copyright, etc). This
header is missing in other .c files in other patches too.

> @@ -0,0 +1,138 @@
> +/* This file is only built under MINGW32 */
> +
> +#include <windows.h>
> +#include <stdlib.h>
> +#include <babeltrace/compat/mman.h>
> +
> +#define HAS_FLAG( BITSET, FLAG ) ( ( BITSET & FLAG ) =3D=3D FLAG )

please create a

static
unsigned int has_flag(long bitset, long flag)

instead. There is no need for a macro here. Not sure if long, int should
be used ?

> +
> +typedef struct
> +{
> +    HANDLE hFile;
> +    HANDLE hFileMappingObject;
> +    unsigned char *start_addr;
> +    long offset;
> +} mmap_data;

wrong coding style. Also, no typedef please.

> +
> +mmap_data *arr_mmap_data =3D NULL;
> +size_t arr_mmap_data_size =3D 0;
> +DWORD allocationGranularity =3D 0;

Adding a global variable:

- missing mutex,
- missing "static": no need to expose those symbols.

> +
> +void mmap_data_add( mmap_data data )
> +{
> +    arr_mmap_data =3D (mmap_data *) realloc( arr_mmap_data, ( arr_mmap_d=
ata_size + 1 ) * sizeof( mmap_data ) );

In pretty much all the file, spaces around ( blah ) should be removed to
follow coding style.

> +    arr_mmap_data[ arr_mmap_data_size ] =3D data;
> +    arr_mmap_data_size +=3D 1;

Please double the size when needed rather than +1. Rather than
reallocating each time, we just need to reallocate log(n) times.
I strongly recommend you follow other code examples found in the
babeltrace tree to make sure you don't add bugs in this resize scheme.

As a quick example (please re-use as needed):

static inline int fls(unsigned int x)
{
        int r =3D 32;

        if (!x)
                return 0;
        if (!(x & 0xFFFF0000U)) {
                x <<=3D 16;
                r -=3D 16;
        }
        if (!(x & 0xFF000000U)) {
                x <<=3D 8;
                r -=3D 8;
        }
        if (!(x & 0xF0000000U)) {
                x <<=3D 4;
                r -=3D 4;
        }
        if (!(x & 0xC0000000U)) {
                x <<=3D 2;
                r -=3D 2;
        }
        if (!(x & 0x80000000U)) {
                x <<=3D 1;
                r -=3D 1;
        }
        return r;
}

static inline int get_count_order(unsigned int count)
{
        int order;

        order =3D fls(count) - 1;
        if (count & (count - 1))
                order++;
        return order;
}

static
int32_t bytecode_reserve(struct lttng_filter_bytecode_alloc **fb, uint32_t =
align, uint32_t len)
{
        int32_t ret;
        uint32_t padding =3D offset_align((*fb)->b.len, align);
        uint32_t new_len =3D (*fb)->b.len + padding + len;
        uint32_t new_alloc_len =3D sizeof(struct lttng_filter_bytecode_allo=
c) + new_len;
        uint32_t old_alloc_len =3D (*fb)->alloc_len;

        if (new_len > LTTNG_FILTER_MAX_LEN)
                return -EINVAL;

        if (new_alloc_len > old_alloc_len) {
                struct lttng_filter_bytecode_alloc *newptr;

                new_alloc_len =3D
                        max_t(uint32_t, 1U << get_count_order(new_alloc_len=
), old_alloc_len << 1);
                newptr =3D realloc(*fb, new_alloc_len);
                if (!newptr)
                        return -ENOMEM;
                *fb =3D newptr;
                /* We zero directly the memory from start of allocation. */
                memset(&((char *) *fb)[old_alloc_len], 0, new_alloc_len - o=
ld_alloc_len);
                (*fb)->alloc_len =3D new_alloc_len;
        }
        (*fb)->b.len +=3D padding;
        ret =3D (*fb)->b.len;
        (*fb)->b.len +=3D len;
        return ret;
}

> +}
> +
> +mmap_data *mmap_data_find_addr( unsigned char *start_addr )
> +{
> +    size_t i;
> +
> +    for( i =3D 0; i < arr_mmap_data_size; ++i )

missing {} for coding style.

> +     if( arr_mmap_data[i].start_addr + arr_mmap_data[i].offset =3D=3D st=
art_addr )
> +         return arr_mmap_data + i;

don't use +. Use &arr_mmap_data[i] instead. (true in many other
locations in the file).

> +
> +    return NULL;
> +}
> +
> +/* mmap for mingw32 */
> +void *mmap( void *ptr, long size, long prot, long type, long handle, lon=
g arg )

Why use long type ? Is it OK for the size ? What about >2GB files on
32-bit systems ?

> +{
> +    mmap_data data_entry;
> +    long offset;
> +
> +    if (allocationGranularity =3D=3D 0)
> +    {

coding style (same elsewhere).

> +        SYSTEM_INFO sysinfo;
> +        GetSystemInfo(&sysinfo);
> +        allocationGranularity =3D sysinfo.dwAllocationGranularity;
> +    }
> +
> +    if( prot =3D=3D PROT_NONE || HAS_FLAG( prot, PROT_EXEC ) )
> +     return MAP_FAILED; /* not supported - fail safe */

everywhere in the file: please replace spaces with single tab.

Please re-send this patch and the following patches from the patchset
after fixing these issues. I won't reply to the other patches until they
are resent.

Thanks,

Mathieu

> +
> +    data_entry.hFile =3D (HANDLE) _get_osfhandle( handle );
> +    if( data_entry.hFile !=3D INVALID_HANDLE_VALUE )
> +    {
> +
> +     /* There is no 1:1 mapping, best effort strategy */
> +     DWORD flProtect =3D PAGE_READONLY;
> +     DWORD dwDesiredAccess =3D FILE_MAP_READ;
> +
> +     if( HAS_FLAG( prot, PROT_WRITE ) )
> +     {
> +         flProtect =3D PAGE_READWRITE;
> +         if( HAS_FLAG( prot, PROT_READ ) )
> +             dwDesiredAccess =3D FILE_MAP_ALL_ACCESS;
> +         else
> +             dwDesiredAccess =3D FILE_MAP_WRITE;
> +     }
> +
> +     if( HAS_FLAG( type, MAP_PRIVATE ) )
> +     {
> +         flProtect =3D PAGE_WRITECOPY;
> +         dwDesiredAccess =3D FILE_MAP_COPY;
> +     }
> +
> +     data_entry.hFileMappingObject =3D CreateFileMapping( data_entry.hFi=
le, NULL, flProtect, 0, 0, NULL );
> +     if( data_entry.hFileMappingObject !=3D NULL )
> +     {
> +            DWORD filesizelow;
> +            DWORD filesizehigh;
> +
> +         filesizelow =3D GetFileSize(data_entry.hFile, &filesizehigh);
> +         offset =3D 0;
> +            while (arg > allocationGranularity)
> +            {
> +                if (filesizelow < allocationGranularity)
> +                {
> +                     filesizehigh--;
> +             }
> +             filesizelow -=3D allocationGranularity;
> +
> +                arg -=3D allocationGranularity;
> +                offset +=3D allocationGranularity;
> +            }
> +            data_entry.offset =3D arg;
> +            size =3D size + arg;
> +            if ((size > filesizelow) && (filesizehigh =3D=3D 0))
> +            {
> +                size =3D filesizelow;
> +            }
> +         data_entry.start_addr =3D MapViewOfFile( data_entry.hFileMappin=
gObject, dwDesiredAccess, 0, offset, size);
> +         if( data_entry.start_addr !=3D NULL )
> +         {
> +             mmap_data_add( data_entry );
> +             return (void *)(data_entry.start_addr + arg);
> +         }
> +     }
> +
> +    }
> +
> +    return MAP_FAILED;
> +}
> +
> +
> +/* munmap for mingw32 */
> +long munmap( void *ptr, long size )
> +{
> +    mmap_data *data_entry =3D mmap_data_find_addr( ptr );
> +    if( data_entry !=3D NULL  && UnmapViewOfFile( data_entry->start_addr=
 ) !=3D 0 )
> +    {
> +     CloseHandle( data_entry->hFileMappingObject );
> +     data_entry->start_addr =3D NULL;
> +     return 0;
> +    }
> +
> +    return -1;
> +}
> +
> +/* PAGESIZE for mingw */
> +unsigned int getpagesize(void)
> +{
> +     SYSTEM_INFO sys_info;
> +
> +     GetSystemInfo(&sys_info);
> +     return sys_info.dwPageSize;
> +}
> diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
> index 537a8bf..ee9b309 100644
> --- a/converter/babeltrace-log.c
> +++ b/converter/babeltrace-log.c
> @@ -33,7 +33,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
> -#include <sys/mman.h>
> +#include <babeltrace/compat/mman.h>
>  #include <dirent.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/formats/bt-dummy/bt-dummy.c b/formats/bt-dummy/bt-dummy.c
> index 6192e88..4be9741 100644
> --- a/formats/bt-dummy/bt-dummy.c
> +++ b/formats/bt-dummy/bt-dummy.c
> @@ -28,7 +28,7 @@
>  #include <babeltrace/format.h>
>  #include <babeltrace/babeltrace-internal.h>
>  #include <inttypes.h>
> -#include <sys/mman.h>
> +#include <babeltrace/compat/mman.h>
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> diff --git a/formats/ctf-metadata/ctf-metadata.c b/formats/ctf-metadata/c=
tf-metadata.c
> index a5a74c3..7ac36e1 100644
> --- a/formats/ctf-metadata/ctf-metadata.c
> +++ b/formats/ctf-metadata/ctf-metadata.c
> @@ -31,7 +31,7 @@
>  #include <babeltrace/babeltrace-internal.h>
>  #include <babeltrace/ctf/events-internal.h>
>  #include <inttypes.h>
> -#include <sys/mman.h>
> +#include <babeltrace/compat/mman.h>
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
> index 48ce31b..bc5c2a7 100644
> --- a/formats/ctf-text/ctf-text.c
> +++ b/formats/ctf-text/ctf-text.c
> @@ -32,7 +32,7 @@
>  #include <babeltrace/babeltrace-internal.h>
>  #include <babeltrace/ctf/events-internal.h>
>  #include <inttypes.h>
> -#include <sys/mman.h>
> +#include <babeltrace/compat/mman.h>
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index bb94e52..bb43664 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -37,7 +37,7 @@
>  #include <babeltrace/endian.h>
>  #include <inttypes.h>
>  #include <stdio.h>
> -#include <sys/mman.h>
> +#include <babeltrace/compat/mman.h>
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> diff --git a/include/babeltrace/align.h b/include/babeltrace/align.h
> index f6a1966..4a46925 100644
> --- a/include/babeltrace/align.h
> +++ b/include/babeltrace/align.h
> @@ -27,11 +27,17 @@
>
>  #include <babeltrace/compiler.h>
>  #include <unistd.h>
> +
>  #include <limits.h>
>
>  #ifndef PAGE_SIZE            /* Cygwin limits.h defines its own PAGE_SIZ=
E */
> +#ifdef __MINGW32__
> +extern unsigned int getpagesize(void);
> +#define PAGE_SIZE            getpagesize()
> +#else
>  #define PAGE_SIZE            sysconf(_SC_PAGE_SIZE)
>  #endif
> +#endif
>
>  #define ALIGN(x, a)          __ALIGN_MASK(x, (typeof(x))(a) - 1)
>  #define __ALIGN_MASK(x, mask)        (((x) + (mask)) & ~(mask))
> diff --git a/include/babeltrace/compat/mman.h b/include/babeltrace/compat=
/mman.h
> new file mode 100644
> index 0000000..a004b1e
> --- /dev/null
> +++ b/include/babeltrace/compat/mman.h
> @@ -0,0 +1,24 @@
> +#ifndef _BABELTRACE_INCLUDE_COMPAT_MMAN_H
> +#define _BABELTRACE_INCLUDE_COMPAT_MMAN_H
> +
> +#ifdef __MINGW32__
> +
> +#define PROT_READ    0x1
> +#define PROT_WRITE   0x2
> +#define PROT_EXEC    0x4
> +#define PROT_NONE    0x0
> +
> +#define MAP_SHARED   0x01
> +#define MAP_PRIVATE  0x02
> +#define MAP_FAILED   ((void *) -1)
> +
> +/* mmap for mingw32 */
> +void *mmap (void *ptr, long size, long prot, long type, long handle, lon=
g arg);
> +/* munmap for mingw32 */
> +long munmap (void *ptr, long size);
> +
> +#else
> +#include <sys/mman.h>
> +#endif
> +
> +#endif /* _BABELTRACE_INCLUDE_COMPAT_MMAN_H */
> diff --git a/include/babeltrace/ctf-text/types.h b/include/babeltrace/ctf=
-text/types.h
> index 7b4b717..c528355 100644
> --- a/include/babeltrace/ctf-text/types.h
> +++ b/include/babeltrace/ctf-text/types.h
> @@ -27,7 +27,7 @@
>   * SOFTWARE.
>   */
>
> -#include <sys/mman.h>
> +#include <babeltrace/compat/mman.h>
>  #include <errno.h>
>  #include <stdint.h>
>  #include <unistd.h>
> diff --git a/include/babeltrace/mmap-align.h b/include/babeltrace/mmap-al=
ign.h
> index f7c18fa..3d90c85 100644
> --- a/include/babeltrace/mmap-align.h
> +++ b/include/babeltrace/mmap-align.h
> @@ -27,7 +27,7 @@
>
>  #include <babeltrace/align.h>
>  #include <stdlib.h>
> -#include <sys/mman.h>
> +#include <babeltrace/compat/mman.h>
>
>  /*
>   * This header implements a wrapper over mmap (mmap_align) that memory
> --
> 1.8.1.msysgit.1
>

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
