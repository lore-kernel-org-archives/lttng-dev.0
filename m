From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH 3/4] Correct the behavior of the
 utils_expand_path function
Date: Wed, 13 Nov 2013 22:27:03 -0500
Message-ID: <CAE_Gge2rcE7-pH9KBh9WAkfcQYM-aNw1iAb2brUeyjVvA=Nn3Q__41883.7583078586$1384399694$gmane$org@mail.gmail.com>
References: <1384320878-28808-1-git-send-email-raphael.beamonte@gmail.com>
	<20131112195134.GB12183@thessa>
	<1384320878-28808-4-git-send-email-raphael.beamonte@gmail.com>
	<647704866.66921.1384397059144.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1Vgnab-0005M8-E7
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 22:27:30 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp4so1548793obc.36
	for <lttng-dev@lists.lttng.org>; Wed, 13 Nov 2013 19:27:23 -0800 (PST)
In-Reply-To: <647704866.66921.1384397059144.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> I might be missing something, but how about, instead:
>
> 1) if path start with /, directly pass it to realpath()
> 2) if path does not start with /, prepend getcwd() to it, and then call r=
ealpath() on the result.
>
> If we can do the same result as this patch without reimplementing tricky =
string handling, we should really aim for re-using existing libraries.
>
> Thoughts ?

Hello Mathieu,

Thing is realpath only works if the path exists (realpath(3)). I
perhaps want to give as argument an absolute path that does not exist,
or a path containing strings such as '../' or './'. In such cases,
realpath would do no good, and if we don't accept to use unexisting
paths, then there is no point in using a recursive mkdir.
If fact, if realpath would work in such cases, using an 'if' would not
even be necessary, we could just call realpath and let it resolve the
current directory if necessary.

Hope it helps to understand,

Rapha=EBl
