From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Addition of the return address to
	liblttng-ust-libc-wrapper
Date: Fri, 16 Jan 2015 15:32:56 -0500
Message-ID: <CAFXXi0nzOHHPx+h5vUs-pCe1-zT0T=6jNq6L+EJN6z0Nh-_NMA__25049.468180123$1421440444$gmane$org@mail.gmail.com>
References: <OF7097A1B1.090ABAC2-ONC1257DCC.0053FE7C-C1257DCC.00570880@LocalDomain>
 <1127206322.43789.1421439222351.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1YCDaG-00013u-Dy
 for lttng-dev@lists.lttng.org; Fri, 16 Jan 2015 15:33:33 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so5429552igb.1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Jan 2015 12:33:27 -0800 (PST)
In-Reply-To: <1127206322.43789.1421439222351.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 16 January 2015 at 15:13, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ________________________________
>
> From: "Olivier Delbeke" <Olivier.Delbeke@awtce.be>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, January 13, 2015 10:50:38 AM
> Subject: [lttng-dev] Addition of the return address to        liblttng-ust-libc-wrapper
>
> Hi guys,
>
>
> I am using liblttng-ust-libc-wrapper to detect memory leaks in my applications.
> In order to identify not only the thread where the unfreed allocations are done, but also the calling function, I extended the liblttng-ust-libc-wrapper to log the "return address" (__builtin_return_address(0)) in addition to the parameters of malloc(). It solves my problem and does not affect Trace Compass.
> Was this the right thing to do ?
>
>
> You should be able to achieve the same thing with the "ip" context, e.g.:
>
> lttng create
> lttng enable-event -u -a
> lttng add-context -u -t ip
> lttng start
> ....
>
> All this dynamically without changing the instrumentation.
>
> Thanks,
>
> Mathieu

I might be wrong, but from what I understand, Olivier's patch recorded
the address of the caller of malloc. Adding the ip context will record
the ip of the location of the tracepoint macro call, which will always
be the same (an address in liblttng-ust-malloc's malloc).

Simon
