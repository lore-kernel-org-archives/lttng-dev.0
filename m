From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Questions about trace streaming
Date: Wed, 18 Sep 2013 13:07:01 -0400
Message-ID: <CA+jJMxvCc5WFKTCLLJmY=R+Z2EoNubLyW5KgoN7EFvheoL-S8w__29555.6072881029$1379524087$gmane$org@mail.gmail.com>
References: <15791CE1D0394DEA8AEEC1E9AAD00832@DVDMANDT5>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VMLDX-0007st-Jz
	for lttng-dev@lists.lttng.org; Wed, 18 Sep 2013 13:07:13 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so6788006wgg.8
	for <lttng-dev@lists.lttng.org>; Wed, 18 Sep 2013 10:07:01 -0700 (PDT)
In-Reply-To: <15791CE1D0394DEA8AEEC1E9AAD00832@DVDMANDT5>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?David_Lindstr=F6m?= <david.lindstrom@percepio.se>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Sep 18, 2013 at 11:39 AM, David Lindstr=F6m
<david.lindstrom@percepio.se> wrote:
> Hi, I have some quick questions about trace streaming, that is over TCP.
>
> 1. What is the overall status of trace streaming?

It was introduced in version 2.1 (December 2012).

> 2. How can I get started?

After making sure you have installed the appropriate LTTng packages on
both systems, simply launch lttng-relayd on the trace collecting
system.
Then setup your trace on the "tracee" as you would do for a local
tracing session, the only difference being that you must use the -U
option when creating the session.

$ lttng create -U net://adress.of.trace.collecting.host

// Then setup whatever options you want for this session.

$ lttng enable-event -u -a
$ lttng start
// Launch an instrumented application...
$ lttng stop
$ lttng destroy

You should then find a trace on the trace collecting system under
~/lttng-traces, the default output base directory.

You can, of course, choose the ports used for data and control
connections and the output directory, but this should be enough to get
you started. See the lttng-relayd and lttng man pages for details.

> 3. Is the protocol(s) documented and reasonably stable? If so, where can I
> find information about said protocol(s)?

The protocol is not documented as far as I know. However, the original
RFCs in the lttng-tools tree under doc/proposals may shed some light
on it.

I can't comment on the protocol's stability. David and Julien could
offer more insight on this point.

Regards,
J=E9r=E9mie

> Mvh
> David Lindstr=F6m
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
