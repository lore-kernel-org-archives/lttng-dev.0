From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: linking c++ with shared object tracepoints
Date: Thu, 30 May 2013 09:42:23 -0400
Message-ID: <CA+jJMxusCXn9=F3dQ+ss1mGYtjv0NPXWuYWb3tLukdS1QFwtBw__42979.5652781197$1369921417$gmane$org@mail.gmail.com>
References: <CAE5ibEn5d479UzR4_zFt3nj2T6pbS94ZS50F=dkxZN3RzarvfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Ui37y-0003Th-UX
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 09:42:51 -0400
Received: by mail-wi0-f179.google.com with SMTP id hq7so252607wib.0
	for <lttng-dev@lists.lttng.org>; Thu, 30 May 2013 06:42:45 -0700 (PDT)
In-Reply-To: <CAE5ibEn5d479UzR4_zFt3nj2T6pbS94ZS50F=dkxZN3RzarvfQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aryeh Weinreb <weinrea@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Thu, May 30, 2013 at 4:51 AM, Aryeh Weinreb <weinrea@gmail.com> wrote:
> Hi there,
>
> I am trying to link c++ code with c compiled tracepoints.
> It works when I link directly but when I put the tracepoints in a
> dynamic lib first I get an undefined reference to "tracepoint_dlopen".
> Is supported to link c++ code with c compiled tracepoints put it a dynami=
c lib?

Yes, I just tried it here.

>
> When I remove the hidden attribute from tracepoint_dlopen in
> lttng/tracepoint.h it links okay.
> What is the reason for declaring it hidden in the first place? Is it
> safe to remove it?

No, that wouldn't be safe. This is done to make sure loading multiple
.so providers doesn't cause symbols to be overridden.

The header is probably fine and I'd advise againt modifying it without
careful thought. Could you provide a short example reproducing the
problem?

Thanks,
J=E9r=E9mie

>
> Thanks,
> aryeh
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
