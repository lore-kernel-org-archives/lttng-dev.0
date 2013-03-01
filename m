From: Hui Zhu <teawater@gmail.com>
Subject: Re: [PATCH 3/5] Read CTF by the ctf target
Date: Fri, 1 Mar 2013 10:37:26 +0800
Message-ID: <CANFwon2TPo1X2cUXXdzDEnX3UPvG2w0ZNMpNGN=KoDdBvyXLFQ@mail.gmail.com>
References: <1361931459-3953-1-git-send-email-yao@codesourcery.com> <1361931459-3953-4-git-send-email-yao@codesourcery.com> <512F9182.3080104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <gdb-patches-return-98924-gdb-gdb-patches=m.gmane.org@sourceware.org>
In-Reply-To: <512F9182.3080104@redhat.com>
List-Unsubscribe: <mailto:gdb-patches-unsubscribe-gdb-gdb-patches=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-patches-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb-patches/>
List-Post: <mailto:gdb-patches@sourceware.org>
List-Help: <mailto:gdb-patches-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-patches-owner@sourceware.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yao Qi <yao@codesourcery.com>, gdb-patches@sourceware.org, Pedro Alves <palves@redhat.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Mar 1, 2013 at 1:18 AM, Pedro Alves <palves@redhat.com> wrote:
> (not a complete review)
>
> On 02/27/2013 02:17 AM, Yao Qi wrote:
>
>> +if test "x$with_babeltrace" != "xno"; then
>> +  saved_CFLAGS="$CFLAGS"
>> +  CFLAGS="$CFLAGS $btinc"
>> +  AC_MSG_CHECKING([for babeltrace])
>> +  AC_TRY_COMPILE([
>> +#include <babeltrace/babeltrace.h>
>> +#include <babeltrace/ctf/events.h>
>> +#include <babeltrace/ctf/iterator.h>
>
> We know from previous patches that the latest released
> babeltrace breaks gdb, due to the lookup_enum function.  Does
> this catch that?  I see namespacing fixes going into
> babeltrace as recently as last 15th.  Do we know if
> babeltrace's API is more or less done and close to a release?

Hi Mathieu,

Could you help us with this question?

Thanks,
Hui

>
>> +  ],[],
>> +  [AC_MSG_RESULT([yes]); AC_DEFINE(HAVE_LIBBABELTRACE, 1, [Define if libbabeltrace is available])],
>> +  [AC_MSG_RESULT([no]); btlibs= ; btinc= ])
>> +  CFLAGS="$saved_CFLAGS"
>> +fi
>> +
>> +# Flags needed for UST
>
> babeltrace
>
>> +AC_SUBST(btlibs)
>> +AC_SUBST(btinc)
>> +
>
> --
> Pedro Alves
>
