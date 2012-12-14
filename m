From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Question about use libbabeltrace
Date: Fri, 14 Dec 2012 01:13:06 -0500
Message-ID: <50CAC372.5000807__49985.3011024699$1355465633$gmane$org@gmail.com>
References: <CANFwon0LGfGbP=a+OBHQMSKWz=_DYPKoEN=-udAmX6LiTTfCng@mail.gmail.com>
	<20121213113553.GA9680@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TjOWK-00040Q-A0
	for lttng-dev@lists.lttng.org; Fri, 14 Dec 2012 01:13:16 -0500
Received: by mail-ia0-f176.google.com with SMTP id y26so2764968iab.35
	for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2012 22:13:10 -0800 (PST)
In-Reply-To: <20121213113553.GA9680@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Hui Zhu <hui_zhu@mentor.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2012-12-13 06:35, Mathieu Desnoyers wrote:
> * Hui Zhu (teawater@gmail.com) wrote:
>> Hi guys,
>>
>> Maybe you had known that I am working on add CTF support to GDB that
>> use libbabeltrace from my prev mail.
>>
>> I use libbabeltrace in this patch
>> http://sourceware.org/ml/gdb-patches/2012-11/msg00717.html
>>
>> What I check if current machine have libbabeltrace in following way:
>> +    if test "x$enable_glibtest" = "xyes" ; then
>> +      ac_save_CFLAGS="$CFLAGS"
>> +      ac_save_LIBS="$LIBS"
>> +      CFLAGS="$CFLAGS $GLIB_CFLAGS"
>> +      LIBS="$LIBS -lbabeltrace -lbabeltrace-ctf"
>> +      rm -f conf.glibtest
>> +      if test "$cross_compiling" = yes; then :
>> +  $as_echo $ac_n "cross compiling; assumed OK... $ac_c"
>> +else
>> +  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
>> +/* end confdefs.h.  */
>> +
>> +#include <babeltrace/babeltrace.h>
>> +#include <babeltrace/types.h>
>> +#include <babeltrace/ctf/events.h>
>> +#include <babeltrace/ctf/iterator.h>
>> +
>> +int
>> +main ()
>> +{
>> +  if (!bt_context_create())
>> +    return 1;
>> +  return 0;
>> +}
>> +
>> +_ACEOF
>> +if ac_fn_c_try_run "$LINENO"; then :
>> +
>> +else
>> +  no_glib=yes
>> +fi
>>
>> Just try to build example with -lbabeltrace -lbabeltrace-ctf.
>>
>> My question is does libbabeltrace have better way to handle it?  For
>> example: pkg-config
> We don't have pkg-config support in babeltrace yet, but we would gladly
> welcome a contribution adding it! :)
>

I finally did it...

Yannick
