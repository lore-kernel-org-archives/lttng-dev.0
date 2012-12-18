From: Hui Zhu <teawater@gmail.com>
Subject: Re: Question about use libbabeltrace
Date: Tue, 18 Dec 2012 19:19:56 +0800
Message-ID: <CANFwon2QmPqS=2vB_3rBuYkM_h0Dh+_CAe2JcRSYUGB7mBJvXg__22811.7271246903$1355829686$gmane$org@mail.gmail.com>
References: <CANFwon0LGfGbP=a+OBHQMSKWz=_DYPKoEN=-udAmX6LiTTfCng@mail.gmail.com>
	<20121213113553.GA9680@Krystal> <50CAC372.5000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1TkvE1-0000M6-Tz
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 06:20:42 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so471950oag.17
	for <lttng-dev@lists.lttng.org>; Tue, 18 Dec 2012 03:20:36 -0800 (PST)
In-Reply-To: <50CAC372.5000807@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: Hui Zhu <hui_zhu@mentor.com>, lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On Fri, Dec 14, 2012 at 2:13 PM, Yannick Brosseau
<yannick.brosseau@gmail.com> wrote:
> On 2012-12-13 06:35, Mathieu Desnoyers wrote:
>> * Hui Zhu (teawater@gmail.com) wrote:
>>> Hi guys,
>>>
>>> Maybe you had known that I am working on add CTF support to GDB that
>>> use libbabeltrace from my prev mail.
>>>
>>> I use libbabeltrace in this patch
>>> http://sourceware.org/ml/gdb-patches/2012-11/msg00717.html
>>>
>>> What I check if current machine have libbabeltrace in following way:
>>> +    if test "x$enable_glibtest" = "xyes" ; then
>>> +      ac_save_CFLAGS="$CFLAGS"
>>> +      ac_save_LIBS="$LIBS"
>>> +      CFLAGS="$CFLAGS $GLIB_CFLAGS"
>>> +      LIBS="$LIBS -lbabeltrace -lbabeltrace-ctf"
>>> +      rm -f conf.glibtest
>>> +      if test "$cross_compiling" = yes; then :
>>> +  $as_echo $ac_n "cross compiling; assumed OK... $ac_c"
>>> +else
>>> +  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
>>> +/* end confdefs.h.  */
>>> +
>>> +#include <babeltrace/babeltrace.h>
>>> +#include <babeltrace/types.h>
>>> +#include <babeltrace/ctf/events.h>
>>> +#include <babeltrace/ctf/iterator.h>
>>> +
>>> +int
>>> +main ()
>>> +{
>>> +  if (!bt_context_create())
>>> +    return 1;
>>> +  return 0;
>>> +}
>>> +
>>> +_ACEOF
>>> +if ac_fn_c_try_run "$LINENO"; then :
>>> +
>>> +else
>>> +  no_glib=yes
>>> +fi
>>>
>>> Just try to build example with -lbabeltrace -lbabeltrace-ctf.
>>>
>>> My question is does libbabeltrace have better way to handle it?  For
>>> example: pkg-config
>> We don't have pkg-config support in babeltrace yet, but we would gladly
>> welcome a contribution adding it! :)
>>
>
> I finally did it...
>
> Yannick

It works OK in my part.  It is great for me.  Thanks for your work.

Best,
Hui
