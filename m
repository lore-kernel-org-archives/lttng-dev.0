From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Can trace be stopped from UST on executing a
 particular function?
Date: Mon, 3 Mar 2014 11:45:53 -0500
Message-ID: <CA+jJMxuRGMuHhMk5A7Cx9sub24TeiehTSrEWui2kqaTWPXsxSw__35054.3717075654$1393865208$gmane$org@mail.gmail.com>
References: <CAO_ArvocVGwozqAVhsryQXDCfe+qa5smy9sBNswc34+Hu6hB6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WKW07-0006HN-Hq
	for lttng-dev@lists.lttng.org; Mon, 03 Mar 2014 11:46:02 -0500
Received: by mail-qa0-f50.google.com with SMTP id o15so2221805qap.37
	for <lttng-dev@lists.lttng.org>; Mon, 03 Mar 2014 08:45:54 -0800 (PST)
In-Reply-To: <CAO_ArvocVGwozqAVhsryQXDCfe+qa5smy9sBNswc34+Hu6hB6g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Mar 3, 2014 at 7:21 AM, kumar s <skumar.m226@gmail.com> wrote:
> Hello,
>
> Is it possible to stop a trace from UST. When my code reaches a particular
> function , can UST stop the trace and save both UST and kernel traces.
>
> How can i achieve this.?

You can use the tracing control library (liblttng-ctl), which is
provided by lttng-tools, to setup and stop a trace from your
application. Have a look at lttng-tools/include/lttng/lttng.h [1].

Regards,
J=E9r=E9mie

[1] https://bugs.lttng.org/projects/lttng-tools/repository/revisions/master=
/entry/include/lttng/lttng.h

>
> Thank you
> Skumar
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
