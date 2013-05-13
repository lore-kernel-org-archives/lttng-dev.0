From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 08/28] Add MinGW
 implementation of mmap and munmap
Date: Mon, 13 May 2013 16:20:23 -0400
Message-ID: <CA+jJMxvJ99VmpwuBdypUsePJfu1mSuFHjctnv0pHyXkrgGK=bQ__9596.5962428183$1368476466$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E8A5@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzEU-0001DQ-49
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:20:30 -0400
Received: by mail-wi0-f175.google.com with SMTP id hn14so991790wib.8
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:24 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E8A5@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, May 2, 2013 at 7:49 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> Implementations of mmap and munmap using Windows API.
> The header file sys/mman.h is now indirectly included by
> include/babeltrace/compat/mman.h .
> For MinGW, PAGE_SIZE is defined as a constant instead of
> using a sysconf() setting.
> ---
>  compat/Makefile.am                  |   4 +-
>  compat/compat_mman.c                | 128 ++++++++++++++++++++++++++++++=
++++++
>  converter/babeltrace-log.c          |   2 +-
>  formats/bt-dummy/bt-dummy.c         |   2 +-
>  formats/ctf-metadata/ctf-metadata.c |   2 +-
>  formats/ctf-text/ctf-text.c         |   2 +-
>  formats/ctf/ctf.c                   |   2 +-
>  include/babeltrace/align.h          |   5 ++
>  include/babeltrace/compat/mman.h    |  24 +++++++
>  include/babeltrace/ctf-text/types.h |   2 +-
>  include/babeltrace/mmap-align.h     |   2 +-
>  11 files changed, 166 insertions(+), 9 deletions(-)
>  create mode 100644 compat/compat_mman.c
>  create mode 100644 include/babeltrace/compat/mman.h
>
> diff --git a/compat/Makefile.am b/compat/Makefile.am
> index e624a79..e573854 100644
> --- a/compat/Makefile.am
> +++ b/compat/Makefile.am
> @@ -9,5 +9,5 @@ libcompat_la_LDFLAGS =3D \
>         -Wl,--no-as-needed
>
>  if BABELTRACE_BUILD_WITH_MINGW
> -libcompat_la_SOURCES +=3D compat_uuid.c
> -endif
> \ No newline at end of file
> +libcompat_la_SOURCES +=3D compat_mman.c compat_uuid.c
> +endif
> diff --git a/compat/compat_mman.c b/compat/compat_mman.c
> new file mode 100644
> index 0000000..0e45260
> --- /dev/null
> +++ b/compat/compat_mman.c
> @@ -0,0 +1,128 @@
> +/* This file is only built under MINGW32 */
> +
> +#include <windows.h>
> +#include <stdlib.h>
> +#include <babeltrace/compat/mman.h>
> +
> +#define HAS_FLAG( BITSET, FLAG ) ( ( BITSET & FLAG ) =3D=3D FLAG )
> +
> +typedef struct
> +{
> +    HANDLE hFile;
> +    HANDLE hFileMappingObject;
> +    unsigned char *start_addr;
> +    long offset;
> +} mmap_data;
> +
> +mmap_data *arr_mmap_data =3D NULL;
> +size_t arr_mmap_data_size =3D 0;
> +DWORD allocationGranularity =3D 0;
> +
> +void mmap_data_add( mmap_data data )
> +{
> +    arr_mmap_data =3D (mmap_data *) realloc( arr_mmap_data, ( arr_mmap_d=
ata_size + 1 ) * sizeof( mmap_data ) );
> +    arr_mmap_data[ arr_mmap_data_size ] =3D data;
> +    arr_mmap_data_size +=3D 1;
> +}
> +
> +mmap_data *mmap_data_find_addr( unsigned char *start_addr )
> +{
> +    size_t i;
> +    for( i =3D 0; i < arr_mmap_data_size; ++i )
> +       if( arr_mmap_data[i].start_addr + arr_mmap_data[i].offset =3D=3D =
start_addr )
> +           return arr_mmap_data + i;
> +
> +    return NULL;
> +}
> +
> +/* mmap for mingw32 */
> +void *mmap( void *ptr, long size, long prot, long type, long handle, lon=
g arg )
> +{
> +    //__builtin_printf( "mmap: %p, %d, %d, %d, %d, %d\n", ptr, size, pro=
t, type, handle, arg );
> +    mmap_data data_entry;
> +    long offset;
> +
> +    if (allocationGranularity =3D=3D 0)
> +    {
> +        SYSTEM_INFO sysinfo;
> +        GetSystemInfo(&sysinfo);
> +        allocationGranularity =3D sysinfo.dwAllocationGranularity;
> +    }
> +
> +    if( prot =3D=3D PROT_NONE || HAS_FLAG( prot, PROT_EXEC ) )
> +       return MAP_FAILED; /* not supported - fail safe */
> +
> +    data_entry.hFile =3D (HANDLE) _get_osfhandle( handle );
> +    if( data_entry.hFile !=3D INVALID_HANDLE_VALUE )
> +    {
> +
> +       /* There is no 1:1 mapping, best effort strategy */
> +       DWORD flProtect =3D PAGE_READONLY;
> +       DWORD dwDesiredAccess =3D FILE_MAP_READ;
> +
> +       if( HAS_FLAG( prot, PROT_WRITE ) )
> +       {
> +           flProtect =3D PAGE_READWRITE;
> +           if( HAS_FLAG( prot, PROT_READ ) )
> +               dwDesiredAccess =3D FILE_MAP_ALL_ACCESS;
> +           else
> +               dwDesiredAccess =3D FILE_MAP_WRITE;
> +       }
> +
> +       if( HAS_FLAG( type, MAP_PRIVATE ) )
> +       {
> +           flProtect =3D PAGE_WRITECOPY;
> +           dwDesiredAccess =3D FILE_MAP_COPY;
> +       }
> +
> +       data_entry.hFileMappingObject =3D CreateFileMapping( data_entry.h=
File, NULL, flProtect, 0, 0, NULL );
> +       if( data_entry.hFileMappingObject !=3D NULL )
> +       {
> +            DWORD filesizelow;
> +            DWORD filesizehigh;
> +           filesizelow =3D GetFileSize(data_entry.hFile, &filesizehigh);
> +           offset =3D 0;
> +            while (arg > allocationGranularity)
> +            {
> +                if (filesizelow < allocationGranularity)
> +                {
> +                       filesizehigh--;
> +               }
> +               filesizelow -=3D allocationGranularity;
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
> +           data_entry.start_addr =3D MapViewOfFile( data_entry.hFileMapp=
ingObject, dwDesiredAccess, 0, offset, size);
> +           if( data_entry.start_addr !=3D NULL )
> +           {
> +               mmap_data_add( data_entry );
> +               return (void *)(data_entry.start_addr + arg);
> +           }
> +       }
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
> +       CloseHandle( data_entry->hFileMappingObject );
> +       data_entry->start_addr =3D NULL;
> +       return 0;
> +    }
> +
> +    return -1;
> +}
> diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
> index 52a2fe1..b11eb99 100644
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
> index d77c93a..0cfad44 100644
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
> index f6a1966..e7d715e 100644
> --- a/include/babeltrace/align.h
> +++ b/include/babeltrace/align.h
> @@ -30,8 +30,13 @@
>  #include <limits.h>
>
>  #ifndef PAGE_SIZE              /* Cygwin limits.h defines its own PAGE_S=
IZE */
> +#ifdef __MINGW32__
> +#define PAGE_SIZE              4096

You could get the real page size like this on Windows:
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#define PAGE_SIZE ({SYSTEM_INFO sys_info; GetSystemInfo (&sys_info);
sys_info.dwPageSize;})

> +#else
>  #define PAGE_SIZE              sysconf(_SC_PAGE_SIZE)
>  #endif
> +#endif
> +
>
>  #define ALIGN(x, a)            __ALIGN_MASK(x, (typeof(x))(a) - 1)
>  #define __ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
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
> +#define PROT_READ      0x1
> +#define PROT_WRITE     0x2
> +#define PROT_EXEC      0x4
> +#define PROT_NONE      0x0
> +
> +#define MAP_SHARED     0x01
> +#define MAP_PRIVATE    0x02
> +#define MAP_FAILED     ((void *) -1)
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
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
