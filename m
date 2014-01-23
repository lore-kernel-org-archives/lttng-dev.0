From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: RH EL-5
Date: Thu, 23 Jan 2014 13:59:41 -0500
Message-ID: <CA+jJMxuMiMqoUF=EwgcP7bcDnGbmGNQDywpSMc_fxCWV5qdc9A__30694.8571735576$1390503651$gmane$org@mail.gmail.com>
References: <CAA6WC3HnbmT9MPuYm-0Oh4GZW2gixGkBzF=AO-jay0OyOkDj8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1W6PVD-0007x7-87
	for lttng-dev@lists.lttng.org; Thu, 23 Jan 2014 13:59:52 -0500
Received: by mail-qa0-f45.google.com with SMTP id ii20so2696791qab.18
	for <lttng-dev@lists.lttng.org>; Thu, 23 Jan 2014 10:59:41 -0800 (PST)
In-Reply-To: <CAA6WC3HnbmT9MPuYm-0Oh4GZW2gixGkBzF=AO-jay0OyOkDj8A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon <jonconn@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jon,

One thing is certain, kernel tracing won't be possible on 2.6.18.
However, the rest of the toolchain should be buildable, provided that
you install the necessary dependancies. The required versions are
detailed in the different projects' README files.

You will also have to build lttng-tools with the --disable-epoll
configuration option.

Regards,
J=E9r=E9mie


On Thu, Jan 23, 2014 at 12:42 PM, Jon <jonconn@gmail.com> wrote:
> Is there a way of building LTTng for an older -- kind of ancient, Red Hat
> release EL5?
>
> I found some RPMs but not the complete set necessary to make any use of
> LTTng.
>
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
