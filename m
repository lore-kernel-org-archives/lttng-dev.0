From: Hui Zhu <teawater@gmail.com>
Subject: Re: Question about use libbabeltrace
Date: Fri, 14 Dec 2012 11:45:26 +0800
Message-ID: <CANFwon0f62XWSJa2mZSWYgZ0f_a+-bpmz2ZEBz5BFaV077GZ2Q__14127.158028032$1355456807$gmane$org@mail.gmail.com>
References: <CANFwon0LGfGbP=a+OBHQMSKWz=_DYPKoEN=-udAmX6LiTTfCng@mail.gmail.com>
	<20121213113553.GA9680@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1TjME1-0002j1-B3
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 22:46:13 -0500
Received: by mail-bk0-f48.google.com with SMTP id jc3so1437828bkc.35
	for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2012 19:46:07 -0800 (PST)
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

On Thu, Dec 13, 2012 at 7:35 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
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
>
> We don't have pkg-config support in babeltrace yet, but we would gladly
> welcome a contribution adding it! :)
>
> Thanks,
>
> Mathieu

Thanks for your reply.

Best,
Hui

>
>>
>> Thanks,
>> Hui
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
