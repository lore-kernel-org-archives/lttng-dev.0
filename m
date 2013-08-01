From: Zifei Tong <soariez@gmail.com>
Subject: Re: Names collisions with LTTng-UST
Date: Thu, 1 Aug 2013 12:34:17 +0800
Message-ID: <CAJ7wx-GAvEDd9sANkx-eapFPL6DWaErj7-vaF2CkUsKqfQ6Qzg__45893.4138915085$1375331767$gmane$org@mail.gmail.com>
References: <CAFXXi0kt1KfRfEPm4T-NqPqEsKQO0n96P2df4Ds6TyJBJPh26Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1V4kbP-0004PW-BB
	for lttng-dev@lists.lttng.org; Thu, 01 Aug 2013 00:35:08 -0400
Received: by mail-ve0-f180.google.com with SMTP id pb11so1755580veb.25
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 21:34:57 -0700 (PDT)
In-Reply-To: <CAFXXi0kt1KfRfEPm4T-NqPqEsKQO0n96P2df4Ds6TyJBJPh26Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

On Thu, Aug 1, 2013 at 2:29 AM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> Hello tracing bending units,
>
> I encountered a problem while trying to put UST tracepoints in GDB
> today. Since GDB defines a struct tracepoint, it conflicts with
> LTTng's struct tracepoint. Renaming all struct tracepoint in UST to
> struct ust_tracepoint, and rebuilding/installing, provided a simple
> workaround. Would it be possible to do change something in LTTng to
> avoid conflicts like this in the future?
>
> Thanks

gdb used to work around this by the following snippet [1]:

/* UST puts a "struct tracepoint" in the global namespace, which
   conflicts with our tracepoint.  Arguably, being a library, it
   shouldn't take ownership of such a generic name.  We work around it
   here.  */
#define tracepoint ust_tracepoint
#include <ust/ust.h>
#undef tracepoint

I am not sure if it is still working with lttng 2.x API.

[1]: https://github.com/5kg/gdb/blob/master/gdb/gdbserver/tracepoint.c#L6497


Thanks,
Zifei Tong
